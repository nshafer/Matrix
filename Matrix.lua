-- Matrix extensions based on GiderosCodingEasy by ar2rsawseen with a few fixes/changes.
-- Original: https://github.com/ar2rsawseen/GiderosCodingEasy/blob/master/GiderosCodingEasy.lua
-- Discussion: http://www.giderosmobile.com/forum/discussion/2924
function Matrix:rotate(deg)
	local rad = math.rad(deg)
	return self:multiply(Matrix.new(math.cos(rad), -math.sin(rad), math.sin(rad), math.cos(rad), 0, 0))
end

function Matrix:translate(x,y)
	return self:multiply(Matrix.new(1, 0, 0, 1, x, y or x))
end

function Matrix:translateX(x)
	return self:translate(x, 0)
end

function Matrix:translateY(y)
	return self:translate(0, y)
end

function Matrix:scale(sx,sy)
	return self:multiply(Matrix.new(sx, 0, 0, sy or sx, 0, 0))
end

function Matrix:scaleX(x)
	return self:scale(x, 1)
end

function Matrix:scaleY(y)
	return self:scale(1, y)
end

function Matrix:skew(xAng,yAng)
	xAng = math.rad(xAng)
	yAng = math.rad(yAng or xAng)
	return self:multiply(Matrix.new(1, math.tan(xAng), math.tan(yAng), 1, 0, 0))
end

function Matrix:skewX(xAng)
	return self:skew(xAng, 0)
end

function Matrix:skewY(yAng)
	return self:skew(0, yAng)
end

function Matrix:multiply(matrix)
	local m11 = self:getM11()*matrix:getM11() + self:getM12()*matrix:getM21()
	local m12 = self:getM11()*matrix:getM12() + self:getM12()*matrix:getM22()
	local m21 = self:getM21()*matrix:getM11() + self:getM22()*matrix:getM21()
	local m22 = self:getM21()*matrix:getM12() + self:getM22()*matrix:getM22()
	local tx  = self:getM11()*matrix:getTx()  + self:getM12()*matrix:getTy() + self:getTx()
	local ty  = self:getM21()*matrix:getTx()  + self:getM22()*matrix:getTy() + self:getTy()
	return self:setElements(m11, m12, m21, m22, tx, ty)
end

function Matrix:copy()
	return Matrix.new(self:getElements())
end

function Matrix:apply(obj)
	if obj.setMatrix then
		obj:setMatrix(self)
	end
	return self
end

function Matrix:reset()
	return self:setElements(1, 0, 0, 1, 0, 0)
end

function Matrix:applyToPoint(x, y)
	local newX = self:getM11() * x + self:getM12() * y + self:getTx()
	local newY = self:getM21() * x + self:getM22() * y + self:getTy()
	return newX, newY
end