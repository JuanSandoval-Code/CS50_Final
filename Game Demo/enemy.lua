
local Enemy = {}
Enemy.__index = Enemy
local Player = require("player")

local ActiveEnemies = {}

function Enemy.new(x, y)
    local instance = setmetatable({}, Enemy)
    instance.x = x
    instance.y = y
    instance.offsetY = -8
    instance.r = 0
    instance.state = "walk"
    instance.speed = 100
    instance.xVel = instance.speed
    instance.speedMod = 1
    instance.damage = 1
    instance.counter = 0
    instance.trigger = 2
    instance.animation = {timer = 0, rate = 0.1}
    instance.animation.attack = {total = 4, current = 1, img = Enemy.attackAnim}
    instance.animation.walk = {total = 4, current = 1, img = Enemy.walkAnim}
    instance.animation.draw = instance.animation.walk.img[1]
    instance.physics = {}
    instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "dynamic")
    instance.physics.body:setFixedRotation(true)
    instance.physics.shape = love.physics.newRectangleShape(instance.width * 0.4, instance.height * 0.75)
    instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)
    instance.physics.body:setMass(25)
    table.insert(ActiveEnemies, instance)
end

function Enemy.loadAssets()
   Enemy.walkAnim = {}
   for i = 1, 4 do
      Enemy.walkAnim[i] = love.graphics.newImage("assets/enemy/walk/"..i..".png")
   end
   Enemy.attackAnim = {}
   for i = 1, 4 do
      Enemy.attackAnim[i] = love.graphics.newImage("assets/enemy/attack/"..i..".png")
   end
   Enemy.height = Enemy.attackAnim[1]:getHeight()
   Enemy.width = Enemy.attackAnim[1]:getWidth()
end

function Enemy:animate(dt)
   self.animation.timer = self.animation.timer + dt
   if self.animation.timer > self.animation.rate then
       self.animation.timer = 0
       self:setNewFrame()
   end
end

function Enemy:syncPhysics()
    self.x, self.y = self.physics.body:getPosition()
    self.physics.body:setLinearVelocity(self.xVel * self.speedMod, 100)
end

function Enemy:setNewFrame()
   local anim = self.animation[self.state]
   if anim.current < anim.total then
       anim.current = anim.current + 1
   else
       anim.current = 1
   end
   self.animation.draw = anim.img[anim.current]
end

function Enemy:update(dt)
   self:animate(dt)
   self:syncPhysics()
end

function Enemy.updateAll(dt)
   for i, instance in ipairs(ActiveEnemies) do
       instance:update(dt)
   end
end

function Enemy:draw()
    local scaleX = 1
    if self.xVel < 0 then
        scaleX = -1
    end
    love.graphics.draw(self.animation.draw, self.x, self.y + self.offsetY, self.r, scaleX, 1, self.width / 2, self.height / 2)
end

function Enemy.drawAll()
    for i, instance in ipairs(ActiveEnemies) do
        instance:draw()
    end
end

function Enemy.beginContact(a,b, collision)
    for i, instance in ipairs(ActiveEnemies) do
        if a == instance.physics.fixture or b == instance.physics.fixture then
            if a == Player.physics.fixture or b == Player.physics.fixture then
                Player:takeDamage(instance.damage)
            end
            instance:rage()
            instance:turn()
        end
    end
end

function Enemy:turn()
   self.xVel = -self.xVel
end

function Enemy:rage()
   self.counter = self.counter + 1
   if self.counter > self.trigger then
      self.state = "attack"
      self.speedMod = 2
      self.counter = 0
   else
      self.state = "walk"
      self.speedMod = 1
   end
end

function Enemy.removeAll()
   for i, v in ipairs(ActiveEnemies) do
       v.physics.body:destroy()
   end
   ActiveEnemies = {}
end

return Enemy
