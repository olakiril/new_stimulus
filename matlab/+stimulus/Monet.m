%{
# pink noise with periods of motion and orientation
-> stimulus.Condition
---
moving_noise_version        : smallint                      # algorithm version; increment when code changes
rng_seed                    : double                        # random number generate seed
fps                         : decimal(5,2)                  # display refresh rate
tex_ydim                    : smallint                      # (pixels) texture dimension
tex_xdim                    : smallint                      # (pixels) texture dimension
spatial_freq_half           : float                         # (cy/deg) spatial frequency modulated to 50 percent
spatial_freq_stop           : float                         # (cy/deg), spatial lowpass cutoff
temp_bandwidth              : float                         # (Hz) temporal bandwidth of the stimulus
ori_on_secs                 : float                         # seconds of movement and orientation
ori_off_secs                : float                         # seconds without movement
n_dirs                      : smallint                      # number of directions
ori_bands                   : tinyint                       # orientation width expressed in units of 2*pi/n_dirs
ori_modulation              : float                         # mixin-coefficient of orientation biased noise
speed                       : float                         # (degrees/s)
x_degrees                   : float                         # degrees across x if screen were wrapped at shortest distance
y_degrees                   : float                         # degrees across y if screen were wrapped at shortest distance
directions                  : blob                          # (degrees) directions in periods of motion
onsets                      : blob                          # (s) the times of onsets of moving periods
movie                       : longblob                      # actual movie
%}


classdef Monet < dj.Manual & stimulus.core.Visual
    % Legacy Monet stimulus used for migrating from +vis but not for
    % running new stimuli. The code for generating the stimulus is in
    % psy.MonetLookup
    
    properties(Constant)
        version = 'legacy from vis.Monet * vis.MonetLookup'
    end
        
    methods
        function showTrial(~)
            error 'This is a legacy stimulus for analysis only.  The showTrial code is visual-stimulus/+stims/Monet.m'
        end
    end
end