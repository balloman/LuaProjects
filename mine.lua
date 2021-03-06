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
  for i=1, length, 1
  do
    repeat
      d,nextBlock = rb.detect()
      rb.swing()
    until(nextBlock ~= "solid")
    succ = rb.suck
    if (succ == false) then
      io.write(nextBlock)
      if (nextBlock ~= "air") then
        checkCobble()
      end
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
  elseif (direction == "right") then
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

function mineLevel(x, y)
  for a = 1, y, 1
  do
    mineRow(x)
    if (a % 2 == 0) then
      nextRow("left")
    elseif (a % 2 ~= 0) then
      nextRow("right")
    end
  end
  mineRow(x)
end

function mine(levels, x, y)
  for i = 1, levels, 1
  do
    nextLevel()
    mineLevel(x-1, y-1)
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
  rb.up()
end
