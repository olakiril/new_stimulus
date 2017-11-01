%{
# 
-> stimulus.StaticImage
image_id                    : int                           # image id
---
imagenet_id                 : varchar(25)                   # 
class_label                 : smallint                      # imagenet class
description                 : varchar(255)                  # image content
%}


classdef StaticImageImageNet < dj.Manual
end