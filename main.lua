
love.graphics.setDefaultFilter("nearest", "nearest")
local GUI = require("gui")
local Map = require("map")
local Camera = require("camera")
local Player = require("player")
local Enemy = require("enemy")
local Spike = require("spike")


function love.load()
    Enemy.loadAssets()
    GUI:load()
    Map:load()
    Background = love.graphics.newImage("assets/background.png")
    Player:load()
end

function love.update(dt)
    World:update(dt)
    GUI:update(dt)
    Map:update(dt)
    Camera:setPosition(Player.x, 0)
    Player:update(dt)
    Enemy.updateAll(dt)
    Spike.updateAll(dt)
end

function love.draw()
    love.graphics.draw(Background)
    GUI:draw()
    Map.level:draw(-Camera.x, -Camera.y, Camera.scale, Camera.scale)
    Camera:apply()
    Player:draw()
    Enemy.drawAll()
    Spike.drawAll()
    Camera:clear()
end

function beginContact(a, b, collision)
    if Spike.beginContact(a, b, collision) then return end
    Player:beginContact(a, b, collision)
    Enemy.beginContact(a, b, collision)
end

function endContact(a, b, collision)
    Player:endContact(a, b, collision)
end

function love.keypressed(key)
    Player:jump(key)
end
