--------------------------------------------------------------------------------
-- Vibrato
--------------------------------------------------------------------------------

require('lfo')

local lfo = LFO.new()

Delay = Knob("Delay", 0, 0, 1000) -- 0 msec
Delay.changed = function(self)
    self.displayText = string.format("%4.0f msec", self.value)
    lfo.delay = self.value
end
Delay:changed()

Freq = Knob("Freq", 4.0, 0, 10) -- 4 Hz
Freq.changed = function(self)
    self.displayText = string.format("%0.1f hz", self.value)
    lfo.freq = self.value
end
Freq:changed()

Depth = Knob("Depth", 0.1, 0, 1)
Depth.changed = function(self)
    self.displayText = string.format("%0.1f %%", self.value * 100.0)
    lfo.depth = self.value
end
Depth:changed()

function onNote(e)
    local id = postEvent(e) -- duration is omitted

    lfo:reset()

    while isNoteHeld() do
        changeTune(id, lfo:getModulation())
        wait(lfo.grain)
        lfo:tick()
    end

    changeTune(id, 0)
end

