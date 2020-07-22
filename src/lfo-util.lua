require('lfo')

function bindKnobsToLfo (arg)

    local lfo = arg.lfo
    local delay = arg.delay
    local freq = arg.freq
    local depth = arg.depth
    local attack = arg.attack

    if (delay) then
        delay.changed = function (self)
            self.displayText = string.format("%4.0f msec", self.value)
            lfo.delay = self.value
        end
        delay:changed()
    end

    if (freq) then
        freq.changed = function (self)
            self.displayText = string.format("%0.1f hz", self.value)
            lfo.freq = self.value
        end
        freq:changed()
    end

    if (depth) then
        depth.changed = function (self)
            self.displayText = string.format("%0.1f %%", self.value * 100.0)
            lfo.depth = self.value
        end
        depth:changed() 
    end

    if (attack) then
        attack.changed = function (self)
            self.displayText = string.format("%4.0f msec", self.value)
            lfo.attack = self.value
        end
        attack:changed()
    end
    
end
