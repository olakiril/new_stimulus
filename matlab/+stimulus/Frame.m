%{
# Image condition
-> stimulus.Condition
-----
-> stimulus.StaticImageImage
pre_blank_period                  : float           # (s) off duration
presentation_time                 : float           # (s) image duration
%}

classdef Frame < dj.Manual & stimulus.core.Visual
    
    properties(Constant)
        version = '1'
    end
    
    
    methods
        
        function showTrial(self, cond)
            
            img = fetch1(stimulus.StaticImageImage & cond, 'image');
            
            % blank the screen if there is a blanking period
            if cond.pre_blank_period>0
                self.flip(struct('clearScreen', true))
                WaitSecs(cond.pre_blank_period);
            end
            
            tex = Screen('MakeTexture', self.win, img);
            Screen('DrawTexture', self.win, tex, [], self.rect)
            self.flip(struct('checkDroppedFrames', false))
            Screen('close',tex)
            WaitSecs(cond.presentation_time);
            
        end
        
    end
end