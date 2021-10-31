=begin
================================================================================
                   Image-based HP and MP Gauges v1.1 by wltr3565
================================================================================
Influenced by Runefreak's post. He seems to wanting his battle menu to be like
Hanzo Kimura's game. Yeah, I think it's very godly. Well, his battle menu
gauges are imaged. Runefreak asked how to make the HUD show like that. I want
to make the gauges like that in my game too, and after trying, I get the result.
================================================================================
Script effect:
Making HP and MP gauges based on image for more customization of the gauge's 
looking. Very useful script for drawers. And compatible for any battle systems,
and shows almost everywhere!
================================================================================
How to use:
I can't say that this script is plug and play. You need the images in Graphics/
System folder in the name that you assigned in the configurations below.
================================================================================
Incompatibility:
STR33 ATB battle system. Your drawn HP and MP gauge can be seen normally in
the menu screen, but not in the battle. Star seems to use another different
method to draw those gauges. Instead, the gauge that shows in battle is the one
for that battle system.
================================================================================
Install:
Put it above main and below HP-MP gauge related scripts. You can use the gauges
that I've posted for your use to be placed in your game's Graphics/System
folder, but GIVE ME CREDITS FOR THOSE GAUGES! I DREW THEM AND DON'T CLAIM AS
YOUR OWN DRAWING!
================================================================================
FAQ:
Q: Hey, the gauge seems funny.
A: Resizing your gauge will be a good option.
 
Q: Still funny, no matter what.
A: First; adjust the gauge's x and y position to your fitting. Second; Seems
   to be by another content drawing. I'll see what I can help, but show me the 
   screenshot of your problem, okay?
   
Q: Can I use only the gauges that you posted?
A: Yes, but GIVE ME CREDITS FOR THOSE GAUGES! I DREW THEM AND DON'T CLAIM AS
   YOUR OWN DRAWING! And for what do you use it?
 
Q: The gauge squished!
A: Ah, must be the corresponding window. Resizing it can be good.
 
Q: Can I use the gauge in STR33 ATB's format?
A: No. The gauge format is like Enu's ATB gauge. If you want to use STR33 ATB's
   gauge that hardly, make the gauge to be like mine.
================================================================================
Terms of use:
Crediting me, wltr3565, or not, it's up to you. Use this script at your own 
risk. For the gauges I posted, GIVE ME CREDITS FOR THOSE GAUGES! I DREW THEM 
AND DON'T CLAIM AS YOUR OWN DRAWING!
================================================================================
=end
#===============================================================================
#      IMPORTING SCRIPT FOR EASIER CASE SOLVE
#===============================================================================
 
$imported = {} if $imported == nil
$imported["wltr3565's_Image_Gauged_HP_MP"] = true
 
#===============================================================================
#       END IMPORT
#===============================================================================
module WLTR
  module IMAGE_GAUGES
#===============================================================================
#-------------------------------------------------------------------------------
# Configuring HP gauge. The gauges are placed in Graphics/System folder.
#-------------------------------------------------------------------------------
 
#===============================================================================
# HP_SKIN is for the name of the gauge skin.
#===============================================================================
    HP_SKIN = "HP_Skin"
 
#===============================================================================
# HP_OKAY is for the name of the gauge color when the corresponding 
# enemy/actor's HP is above the percentage of HP_CRISIS_LIMIT
#===============================================================================
    HP_OKAY = "HP_Okay"
 
#===============================================================================
# HP_CRISIS is for the name of the gauge color when the corresponding 
# enemy/actor's HP is below the percentage of HP_CRISIS_LIMIT. If you want to
# use the same color even when crisis, just write the name as the same as the 
# ones that you've written in HP_OKAY.
#===============================================================================
    HP_CRISIS = "HP_Crisis"
 
#===============================================================================
# HP_CRISIS_LIMIT is for defining how much is the percentage for the HP is in
# "crisis". It's in percentage. Below the number, the gauge color will use the 
# one in HP_CRISIS.
#===============================================================================
    HP_CRISIS_LIMIT = 50
 
#===============================================================================
# HP gauge x position. Positive numbers will make the gauge to move to the 
# right, and negative numbers will make the gauge to move to the left.
#===============================================================================
    HP_X = -4
 
#===============================================================================
# HP gauge y position. Positive numbers will make the gauge to move to bottom,
# and negative numbers will make the gauge to move to top.
#===============================================================================
    HP_Y = 0
 
#-------------------------------------------------------------------------------
# END HP SETTING
#-------------------------------------------------------------------------------
#===============================================================================
 
#===============================================================================
#-------------------------------------------------------------------------------
# Configuring MP gauge. The gauges are placed in Graphics/System folder.
#-------------------------------------------------------------------------------
 
#===============================================================================
# MP_SKIN is for the name of the gauge skin.
#===============================================================================
    MP_SKIN = "MP_Skin"
 
#===============================================================================
# MP_OKAY is for the name of the gauge color when the corresponding 
# enemy/actor's MP is above the percentage of MP_CRISIS_LIMIT
#===============================================================================
    MP_OKAY = "MP_Okay"
 
#===============================================================================
# MP_CRISIS is for the name of the gauge color when the corresponding 
# enemy/actor's MP is below the percentage of MP_CRISIS_LIMIT. If you want to
# use the same color even when crisis, just write the name as the same as the 
# ones that you've written in MP_OKAY.
#===============================================================================
    MP_CRISIS = "MP_Crisis"
 
#===============================================================================
# MP_CRISIS_LIMIT is for defining how much is the percentage for the MP is in
# "crisis". It's in percentage. Below the number, the gauge color will use the 
# one in MP_CRISIS.
#===============================================================================
    MP_CRISIS_LIMIT = 50
 
#===============================================================================
# MP gauge x position. Positive numbers will make the gauge to move to the 
# right, and negative numbers will make the gauge to move to the left.
#===============================================================================
    MP_X = 0
 
#===============================================================================
# MP gauge y position. Positive numbers will make the gauge to move to bottom,
# and negative numbers will make the gauge to move to top.
#===============================================================================
    MP_Y = 0
 
#-------------------------------------------------------------------------------
# END MP SETTING
#-------------------------------------------------------------------------------
#===============================================================================
 
#===============================================================================
# Do you want the imaged gauges to show in menu too or not?
# true  = let the gauge shown in the menu is the image.
# false = let the gauge shown in the menu is the default and only effect in
#         battle.
#===============================================================================
  IMAGE_AT_MENU = true
  end
end
 
#===============================================================================
# Editing below might give you extreme headache without any scripting 
# experience. I don't want to take responsibility after looking below.
#===============================================================================
 
class Window_Base < Window
  def draw_actor_hp_gauge(actor, x, y, width = 100)
  if $game_temp.in_battle or WLTR::IMAGE_GAUGES::IMAGE_AT_MENU
    gw = width * actor.hp / actor.maxhp 
    bitmap1 = Cache.system(WLTR::IMAGE_GAUGES::HP_SKIN)
  if gw >= width * WLTR::IMAGE_GAUGES::HP_CRISIS_LIMIT / 100
    bitmap2 = Cache.system(WLTR::IMAGE_GAUGES::HP_OKAY)
  else
    bitmap2 = Cache.system(WLTR::IMAGE_GAUGES::HP_CRISIS)
  end
    cwn = bitmap1.width
    cw = bitmap2.width * gw / width
    ch1 = bitmap1.height
    ch2 = bitmap2.height
    src_rect1 = Rect.new(0,0, cwn, ch1)
    src_rect2 = Rect.new(0,0, cw, ch2)
    self.contents.blt(x + WLTR::IMAGE_GAUGES::HP_X, y + WLTR::IMAGE_GAUGES::HP_Y, bitmap1, src_rect1)
    self.contents.blt(x + WLTR::IMAGE_GAUGES::HP_X, y + WLTR::IMAGE_GAUGES::HP_Y, bitmap2, src_rect2)
  else
    gw = width * actor.hp / actor.maxhp
    gc1 = hp_gauge_color1
    gc2 = hp_gauge_color2
    self.contents.fill_rect(x, y + WLH - 8, width, 6, gauge_back_color)
    self.contents.gradient_fill_rect(x, y + WLH - 8, gw, 6, gc1, gc2)
  end
  end
 
  def draw_actor_mp_gauge(actor, x, y, width = 100)
  if $game_temp.in_battle or WLTR::IMAGE_GAUGES::IMAGE_AT_MENU
    gw = width * actor.mp / actor.maxmp 
    bitmap1 = Cache.system(WLTR::IMAGE_GAUGES::MP_SKIN)
  if gw >= width * WLTR::IMAGE_GAUGES::MP_CRISIS_LIMIT / 100
    bitmap2 = Cache.system(WLTR::IMAGE_GAUGES::MP_OKAY)
  else 
    bitmap2 = Cache.system(WLTR::IMAGE_GAUGES::MP_CRISIS)
  end
    cwn = bitmap1.width
    cw = bitmap2.width * gw / width
    ch1 = bitmap1.height
        ch2 = bitmap2.height
    src_rect1 = Rect.new(0,0, cwn, ch1)
    src_rect2 = Rect.new(0,0, cw, ch2)
    self.contents.blt(x + WLTR::IMAGE_GAUGES::MP_X, y + WLTR::IMAGE_GAUGES::MP_Y, bitmap1, src_rect1)
    self.contents.blt(x + WLTR::IMAGE_GAUGES::MP_X, y + WLTR::IMAGE_GAUGES::MP_Y, bitmap2, src_rect2)
  else
    gw = width * actor.mp / [actor.maxmp, 1].max
    gc1 = mp_gauge_color1
    gc2 = mp_gauge_color2
    self.contents.fill_rect(x, y + WLH - 8, width, 6, gauge_back_color)
    self.contents.gradient_fill_rect(x, y + WLH - 8, gw, 6, gc1, gc2)
  end
end
end
#===============================================================================
#
# END OF SCRIPT
#
#===============================================================================