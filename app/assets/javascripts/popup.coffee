screenWidth = $(screen)[0].width/4
screenHeight = $(screen)[0].height/2

window.openScreen1L2LOne = ->
  window.screen1L2LOne ||= window.open("/variables/screen1L2L","_blank","toolbar=no, titlebar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=#{screenWidth}, height=#{2*screenHeight}")
  window.screen1L2LOne.moveTo(0, 0)
  window.screen1L2LOne.focus()
  window.screen1L2LOne.onbeforeunload = ->
    window.screen1L2LOne = undefined

window.openScreen1ROne = ->
  window.screen1ROne ||= window.open("/maps/0/screen1R","_blank","toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=#{3*screenWidth}, height=#{2*screenHeight}")
  window.screen1ROne.moveTo(screenWidth, 0)    
  window.screen1ROne.focus()    

  window.screen1ROne.onbeforeunload = ->
    window.screen1ROne = undefined

window.openWindowOne = ->
  window.openScreen1L2LOne()
  window.openScreen1ROne()

window.openScreen1L2LTwo = ->
  window.screen1L2LTwo ||=  window.open("/variables/screen1L2L","_blank","toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=#{screenWidth}, height=#{2*screenHeight}")
  window.screen1L2LTwo.moveTo(0, 0)
  window.screen1L2LTwo.focus()

  window.screen1L2LTwo.onbeforeunload = ->
    window.screen1L2LTwo = undefined


window.openScreen2MT_1Two = ->
  window.Screen2MT_1Two ||=  window.open("/maps/0/screen2MT/1","_blank","toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=yes, copyhistory=no, width=#{screenWidth}, height=#{screenHeight}")
  window.Screen2MT_1Two.moveTo(screenWidth, 0)
  window.Screen2MT_1Two.focus()
  window.Screen2MT_1Two.onbeforeunload = ->
    window.Screen2MT_1Two = undefined

window.openScreen2MT_2Two = ->
  window.Screen2MT_2Two ||=  window.open("/maps/0/screen2MT/2","_blank","toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=yes, copyhistory=no, width=#{screenWidth}, height=#{screenHeight}")

  window.Screen2MT_2Two.moveTo(2*screenWidth, 0)
  window.Screen2MT_2Two.focus()

  window.Screen2MT_2Two.onbeforeunload = ->
    window.Screen2MT_2Two = undefined

window.openScreen2RTwo = ->
  window.Screen2RTwo ||=  window.open("/agents/screen2R/","_blank","toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=#{screenWidth}, height=#{2*screenHeight}")

  window.Screen2RTwo.moveTo(3*screenWidth, 0)
  window.Screen2RTwo.focus()

  window.Screen2RTwo.onbeforeunload = ->
    window.Screen2RTwo = undefined

window.openScreen2MBTwo = ->
  window.Screen2MBTwo ||=  window.open("/charts/screen2MB","_blank","toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=#{2*screenWidth}, height=#{screenHeight}")

  window.Screen2MBTwo.moveTo(screenWidth, screenHeight)
  window.Screen2MBTwo.focus()

  window.Screen2MBTwo.onbeforeunload = ->
    window.Screen2MBTwo = undefined

window.openWindowTwo = ->
  window.openScreen1L2LTwo()

  window.openScreen2MT_1Two()

  window.openScreen2MT_2Two()

  window.openScreen2RTwo()

  window.openScreen2MBTwo()


window.openWindowThree = ->
  window.openScreen3LThree()
  window.openScreen3RThree()



window.openScreen3LThree = ->
  window.Screen3LThree ||= window.open("/agents/screen3L","_blank","toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=#{screenWidth}, height=#{2*screenHeight}")
  window.Screen3LThree.focus()
  window.Screen3LThree.onbeforeunload = ->
    window.Screen3LThree = undefined  

window.openScreen3RThree = ->
  window.Screen3RThree ||= window.open("/maps/2/screen3R","_blank","toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=#{3*screenWidth}, height=#{2*screenHeight}")
  window.Screen3RThree.moveTo(screenWidth, 0)
  window.Screen3RThree.focus()
  window.Screen3RThree.onbeforeunload = ->
    window.Screen3RThree = undefined

