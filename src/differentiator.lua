DIFFERENTIATOR = {}

local __instance = { __index = DIFFERENTIATOR }

function DIFFERENTIATOR.new ()
    instance = {}
    setmetatable(instance, __instance)
    return instance
end

DIFFERENTIATOR.current = 0;
DIFFERENTIATOR.diff    = 0;

function DIFFERENTIATOR:update (value)
    self.diff    = value - self.current
    self.current = value
end

function DIFFERENTIATOR:reset ()
    self.diff    = 0
    self.current = 0
end
