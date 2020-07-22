LFO = {}

local __instance = { __index = LFO }

function LFO.new ()
    instance = {}
    setmetatable(instance, __instance)
    return instance
end

LFO.delay     = 0   -- msec
LFO.freq      = 4   -- Hz
LFO.depth     = 0.1 -- [0..1]
LFO.grain     = 5   -- msec
LFO.elapsed   = 0   -- msec

function LFO:tick ()
    self.elapsed = self.elapsed + self.grain
end

function LFO:getModulation ()
    local elapsed = math.max(self.elapsed - self.delay)
    local phase = self.freq * math.max(elapsed, 0) / 1000
    return self.depth * math.sin(2 * math.pi * phase)
end

function LFO:reset ()
    self.elapsed = 0
end
