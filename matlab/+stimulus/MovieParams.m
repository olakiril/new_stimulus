%{
# Movie parameters for parametric models
-> stimulus.Movie
---
params                      : longblob                      # 
params_file                 : varchar(255)                  # exported from
%}

classdef MovieParams < dj.Part
    
    properties(SetAccess=protected)
        master= stimulus.Movie
    end
    
end
