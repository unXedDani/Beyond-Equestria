function init()
	r, g, b, a = MainScene:getLight(ParentObject:getID()):getColor()
end

function update()
	local coef = math.random(0.9, 0.95)
	MainScene:getLight(ParentObject:getID()):setColor(r*coef, g*coef, b*coef, a)
end

function render()

end