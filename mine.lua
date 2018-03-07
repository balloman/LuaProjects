local rb = require("robot")
local c = require("component")
local g = c.generator

function fillGenerator()
  for i = 1, 16, 1
  do
    local item = component.inventory_controller.getStackInInternalSlot(i)
    
    if item then
      if (item.name == "coal") then
        rb.select(i)
        g.insert(64)
      end
    end
  end
end

function checkCobble()
  for i = 1, 16, 1
  do
    local item = component.inventory_controller.getStackInInternalSlot(i)
    
    if item then
      if (item.name == "cobblestone") then
        rb.select(i)
        rb.drop(64)
        rb.suck()
      end
    end
  end
end


function mineRow(length)
  for i=length, 1, -1
  do
    toolCheck = rb.swing()
    succ = rb.suck()
    if (succ == false) then
      checkCobble()
    end
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

function mine(levels, x, y)
  for i=levels, 1, -1
  do
    for i = 1, y, 1
    do
      mineRow(x)
      if (i % 2 == 0) then
        nextRow("left")
      else
        nextRow("right")
      end
    end
    nextLevel()
  end
end

io.write("Enter how many levels, then the x and y which will be the dimensions.")
argum = {}
for i = 1, 3, 1
do
  argum[i] = io.read()
end
mine(argum[1], argum[2], argum[3])
for i = argum[1], 1, -1
do
  robot.up()
end