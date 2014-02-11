#include "colors.inc" background { color Gray75 }

#declare USE_RADIOSITY  = on;
#declare USE_PHOTONS    = on;
#declare USE_AREA_LIGHT = on;
#declare USE_FILL_LIGHT = on;

#declare USE_GLASS  = on;
#declare USE_WINDOW = on;
#declare USE_PLANT  = off;

#include "rad_def.inc"

global_settings 
{
  assumed_gamma 2.5
  max_trace_level 20
  #if (USE_PHOTONS)
    photons {count 20000 jitter off}
  #end
  #if (USE_RADIOSITY)
  radiosity {Rad_Settings(Radiosity_Fast, off, off) normal off brightness 0.75}
  #end
}

camera { 
  location <0,2,-3>
  look_at <0,1.25,0>
}

light_source { <2, 4, -3>
  color Gray75
  fade_distance 15
  fade_power .5
  area_light x, z, 8, 8
  adaptive 1
  jitter
}

#macro Egg_Shape (Lower_Scale, Upper_Scale)

#local Egg_Lower_Part = difference {
  sphere { 0, 1 scale <1, Lower_Scale, 1> }
  box { <-1,0,-1>, <1, Lower_Scale, 1> }
}

#local Egg_Upper_Part = difference {
  sphere { 0, 1 scale <1, Upper_Scale, 1> }
  box { <-1, -Upper_Scale, -1>, <1, 0, 1> }
}

union {
  object {Egg_Upper_Part}
  object {Egg_Lower_Part}
  translate <0, Lower_Scale, 0>
  scale 2 / (Lower_Scale + Upper_Scale)
}

#end

#declare Egg = object { Egg_Shape (1.15,1.55)}

object{ Egg
  texture {
    pigment { rgb <255,230,217>/255 }
    normal { bozo 1 scale .005 }
  }
  translate 1*z
}

union {
  plane { y, 0 }
  union {
    plane { z, 8 }
    plane { x, 4 }
    rotate -30*y
  }
  texture {
    pigment { rgb <249,241,233>/255 }
    normal { bozo 2 scale .01 }
  }
}

