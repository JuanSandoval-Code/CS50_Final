
local Map = {}
local STI = require("sti")
local Player = require("player")
local Enemy = require("enemy")
local Spike = require("spike")

function Map:update()
    if Player.x > MapWidth - 16 then
        self:next()
    end
end

function Map:load()
    self.currentLevel = 1
    World = love.physics.newWorld(0,2000)
    World:setCallbacks(beginContact, endContact)
    self:init()
end

function Map:init()
    self.level = STI("map/"..self.currentLevel..".lua", {"box2d"})
    self.level:box2d_init(World)
    self.solidLayer = self.level.layers.Solid
    self.floorLayer = self.level.layers.Floor
    self.entityLayer = self.level.layers.Entity
    self.solidLayer.visible = false
    self.entityLayer.visible = false
    MapWidth = self.floorLayer.width * 16
    self:spawnEntities()
end

function Map:next()
    self:reset()
    self.currentLevel = self.currentLevel + 1
    self:init()
    Player:resetPosition()
end

function Map:reset()
    self.level:box2d_removeLayer("solid")
    Enemy.removeAll()
    Spike.removeAll()
end

function Map:spawnEntities()
    for i, v in ipairs(self.entityLayer.objects) do
        if v.type == "enemy" then
            Enemy.new(v.x + v.width / 2, v.y + v.height / 2)
        elseif v.type == "spikes" then
            Spike.new(v.x + v.width / 2, v.y + v.height / 2)
        end
    end
end

return Map
