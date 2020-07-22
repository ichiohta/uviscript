--------------------------------------------------------------------------------
-- Vibrato
--------------------------------------------------------------------------------

require('lfo')
require('lfo-util')
require('differentiator')

local lfo     = LFO.new()
local tracker = DIFFERENTIATOR.new()

Delay = Knob("Delay", 0, 0, 5000) -- 0 msec
Freq = Knob("Freq", 4.0, 0, 10) -- 4 Hz
Depth = Knob("Depth", 0.1, 0, 5)
Attack = Knob("Attack", 0, 0, 5000) -- 0 msec

bindKnobsToLfo{lfo=lfo, delay=Delay, freq=Freq, depth=Depth, attack=Attack}

function onNote(e)
    local id = postEvent(e) -- duration is omitted

    lfo:reset()
    tracker:reset()

    while isNoteHeld() do
        local current = lfo:getModulation()
        tracker:update(current)
        changeTune(id, tracker.diff, true)
        wait(lfo.grain)
        lfo:tick()
    end

    changeTune(id, -tracker.current, true)
end

