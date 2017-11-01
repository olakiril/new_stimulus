%{
# 
-> stimulus.StaticImage
image_id                    : int                           # image id
---
image                       : longblob                      # actual image
%}


classdef StaticImageImage < dj.Manual
end