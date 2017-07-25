import numpy as np
from scipy import interpolate
import datajoint as dj
from pipeline import reso, stimulus

schema = dj.schema('pipeline_responsiveness', locals())

@schema
class ResponseLatency(dj.Lookup):
    definition = """
    latency     : double  # response latency in ms.
    """

    @property
    def contents(self):
        return [i for i in zip(50 * np.arange(0, 10))]



@schema
class TrialResponse(dj.Computed):
    definition = """
    -> reso.Activity
    -> ResponseLatency
   """

    class Spikes(dj.Part):
        definition = """
        -> master
        -> reso.Activity.Trace
        -> stimulus.Trial
        ---
        pre_flips    : longblob
        post_flips   : longblob
        """

    class Fluorescence(dj.Part):
        definition = """
        -> master
        -> reso.Fluorescence.Trace
        -> stimulus.Trial
        ---
        pre_flips    : longblob
        post_flips   : longblob
        """

    @property
    def key_source(self):
        return reso.Activity() * ResponseLatency() & 'spike_method=5'

    def _make_tuples(self, key):
        latency = key['latency'] / 1000

        print('Populate ', key)
        self.insert1(key)

        frame_times = (stimulus.Sync() & key).fetch1('frame_times').squeeze()
        n_slices = (reso.ScanInfo() & key).fetch1('nslices')
        dframe = np.median(np.diff(frame_times)) * n_slices
        h_trace = np.hamming(2 * int(latency // dframe) + 1)

        trace_keys, traces, slices, fluorescence = (reso.Activity() * reso.Activity.Trace() * reso.ScanInfo.Slice()
                                                    * reso.ScanSet.Unit() * reso.Fluorescence.Trace().proj(
            fluorescence_trace='trace') & key).fetch(dj.key, 'trace', 'slice', 'fluorescence_trace')
        frame_times = frame_times[:traces[0].shape[0] * n_slices]  # truncate if scan is interrupted.
        trial_keys, flips = (stimulus.Sync() * stimulus.Trial() & key).fetch(dj.key, 'flip_times')

        def valid_flips_and_keys(tks, fts, frts):
            mi, ma = frts.min(), frts.max()
            for tk, ft in zip(tks, fts):
                if ft.min() > mi + latency and ft.max() < ma - latency:
                    yield tk, ft

        for tk, ft in valid_flips_and_keys(trial_keys, map(np.squeeze, flips), frame_times[::n_slices]):
            for trk, s, tr, fr in zip(trace_keys, slices - 1, traces, fluorescence):
                trace_time = frame_times[s::n_slices]
                interp_trace = interpolate.interp1d(trace_time, np.convolve(tr, h_trace, mode='same'))
                interp_fluor = interpolate.interp1d(trace_time, np.convolve(fr, h_trace, mode='same'))

                pre_spikes = interp_trace(ft - latency)
                post_spikes = interp_trace(ft + latency)
                pre_fluor = interp_fluor(ft - latency)
                post_fluor = interp_fluor(ft + latency)
                self.Spikes().insert1(
                    dict(trk, **tk, latency=key['latency'], pre_flips=pre_spikes, post_flips=post_spikes),
                    ignore_extra_fields=True)
                self.Fluorescence().insert1(
                    dict(trk, **tk, latency=key['latency'], pre_flips=pre_fluor, post_flips=post_fluor),
                    ignore_extra_fields=True)
            print('.', end='', flush=True)