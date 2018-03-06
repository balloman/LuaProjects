local rb = require("robot")
local c = require("component")

function checkCobble()
  for i = 1, 15, 1
  do
    local item = component.inventory_controller.getStackInInternalSlot(i)
    
    if item then
      if (item.name = "mc:block.Cobblestone") then
        rb.select(i)
        rb.drop(64)
        rb.suck()


function mineRow(length)
  for i=length, 1, -1
  do
    toolCheck = rb.swing()
    if (toolCheck == false) then
      repeat
        toolCheck = rb.swing()
      until (toolCheck == true)
    rb.forward()
  end
end

function nextRow(direction)
  if (direction == "left") then
    rb.turnLeft()
    rb.swing()
    rb.forward()
    rb.turnLeft()
  else
    rb.turnRight()
    rb.swing()
    rb.forward()
    rb.turnRight()
  end
end

function nextLevel()
  rb.swingDown()
  rb.down()
  rb.turnAround()
end

function mine(levels)
  for i=levels, 1, -1
  do
    mineRow(9)
    nextRow("right")
    mineRow(9)
    nextRow("left")
    mineRow(9)
    nextLevel()
  end
end

mine(30)