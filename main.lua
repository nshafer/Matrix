-- Demo of Matrix translations

-- Matrix
-- https://github.com/nshafer/Matrix

-- The MIT License (MIT)

-- Copyright (c) 2013 Nathan Shafer

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

function createBox(width, height, lineStyle, fillStyle)
	lineStyle = lineStyle or {2, 0x000000, 1}
	fillStyle = fillStyle or {Shape.NONE}
	local box = Shape.new()
	box:setLineStyle(unpack(lineStyle))
	box:setFillStyle(unpack(fillStyle))
	box:beginPath()
	box:moveTo(0,0)
	box:lineTo(100,0)
	box:lineTo(100,100)
	box:lineTo(0,100)
	box:closePath()
	box:endPath()
	stage:addChild(box)
	return box
end

-- Create a red box and rotate it traditionally
local box1 = createBox(100,100, {2, 0xFF0000, 1}, {Shape.SOLID, 0xFF0000, 1})
box1:setRotation(25) -- Rotates around the origin (0,0) or top left corner of the box

-- Create a green box and rotate it around the point 50,50
local box2 = createBox(100, 100, {2, 0x00FF00, 1})
local matrix = box2:getMatrix()
matrix:translate(50,50) -- Moves the box down to our pivot point
matrix:rotate(25) -- rotates by 25 degrees
matrix:translate(-50,-50) -- moves it back to where we started
box2:setMatrix(matrix) -- Effectively pivots around the anchor point 50,50

-- Create a blue box and do a bunch of wild and crazy things to it  Try commenting out
-- individual parts to understand how they all work together
local box3 = createBox(100,100, {2, 0x0000FF, 1}, {Shape.SOLID, 0x0000FF, 1})
box3:setPosition(100,200) -- Set a new position for the box.  
local matrix = box3:getMatrix() -- This gets the current matrix, which includes the new position we just set
matrix:translate(50,50) -- Move to our new anchor point relative to current position
matrix:rotate(45) -- Rotate by 45 degrees
matrix:scale(1.5) -- Scale by 150%
matrix:skew(20, 0) -- Skew the x axis by 20 degrees
matrix:translate(-50,-50) -- Put it back
box3:setMatrix(matrix)
