--------------------------------------------------------------------------------
-- Vibrato
--------------------------------------------------------------------------------

require('lfo')
require('lfo-util')

Delay = Knob("Delay", 0, 0, 1000) -- 0 msec
Freq = Knob("Freq", 4.0, 0, 10) -- 4 Hz
Depth = Knob("Depth", 0.1, 0, 2)
Attack = Knob("Attack", 0, 0, 1000) -- 0 msec

local lfo = LFO.new()
bindKnobsToLfo{lfo=lfo, delay=Delay, freq=Freq, depth=Depth, attack=Attack}

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

