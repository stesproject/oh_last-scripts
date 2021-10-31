#==============================================================================
# ** Main
#------------------------------------------------------------------------------
#  After defining each class, actual processing begins here.
#==============================================================================

begin
Font.default_name = "Tahoma"        
#  il nome del font andrà cambiato con il vostro
Font.default_size = 20        
#  di default è impostato a 20
Font.default_bold = true            
#  true= abilita grassetto, false= disabilita grassetto
Font.default_italic = true  
#  true= abilita corsivo, false= disabilita corsivo
Font.default_shadow = true
#  true= abilita ombra testo, false= disabilita ombra testo
  $TEST = false
  Graphics.freeze
  $scene = Scene_Title.new
  $scene.main while $scene != nil
  Graphics.transition(30)
rescue Errno::ENOENT
  filename = $!.message.sub("No such file or directory - ", "")
  print("Unable to find file #{filename}.")
end
