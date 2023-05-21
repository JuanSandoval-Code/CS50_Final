
local GUI = {}
local Player = require("player")

function GUI:load()
    self.health = {}
    self.health.img = love.graphics.newImage("assets/heart.png")
    self.health.width = self.health.img:getWidth()
    self.health.height = self.health.img:getHeight()
    self.health.x = 0
    self.health.y = 30
    self.health.scale = 3
    self.health.spacing = self.health.width + self.health.scale + 30
end

function GUI:update(dt)

end

function GUI:displayHealth()
    for i = 1, Player.health.current do
        local x = self.health.x + self.health.spacing * i
        love.graphics.setColor(0,0,0,0.6)
        love.graphics.draw(self.health.img, x + 2, self.health.y + 2, 0, self.health.scale, self.health.scale)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(self.health.img, x, self.health.y, 0, self.health.scale, self.health.scale)
    end
end

function GUI:draw()
    self:displayHealth()
end

return GUI
