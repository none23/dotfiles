local awful     = require("awful")
local beautiful = require("beautiful")
local tonumber  = tonumber
local math      = { floor = math.floor }
local nlay      = { name = "nlay" }

function nlay.arrange(p)
    local bw = tonumber(beautiful.global_border_width) or 0
    local wa = p.workarea
    local cls = p.clients
    local t = awful.tag.selected(p.screen)
    local mwfact = awful.tag.getmwfact(t)

    if #cls > 0 then
        local c = cls[#cls]
        local g = {}
        local mainwid = math.floor(wa.width * mwfact)
        local mainhei = math.floor(wa.height * (mwfact + 1) / 2)
        local slaveRwid = wa.width - mainwid 
        local slaveRhei = (wa.height / 2) 
        local slaveBhei = wa.height - mainhei 
        
        --If only one client
        if #cls == 1 then
            c = cls[1]
            g = {}
            g.height = wa.height - bw * 2
            g.width = wa.width - bw * 2
            g.x = wa.x 
            g.y = wa.y
            c:geometry(g)

        --If two clients
        elseif #cls == 2 then
            --client 1
            c = cls[1]
            g = {}
            g.height = wa.height - bw * 2
            g.width = mainwid - bw * 2
            g.x = wa.x 
            g.y = wa.y
            c:geometry(g)
        
            --client 2
            c = cls[2]
            g = {}
            g.height = wa.height - bw * 2
            g.width = slaveRwid - bw * 2
            g.x = wa.x + mainwid 
            g.y = wa.y 
            c:geometry(g)

        --If three clients
        elseif #cls == 3 then
            --client 1
            c = cls[1]
            g = {}
            g.height = mainhei - bw * 2
            g.width = mainwid - bw * 2
            g.x = wa.x
            g.y = wa.y
            c:geometry(g)
        
            --client 2
            c = cls[2]
            g = {}
            g.height = wa.height - bw * 2
            g.width = slaveRwid - bw * 2
            g.x = wa.x + mainwid 
            g.y = wa.y
            c:geometry(g)

            --client 3
            c = cls[3]
            g = {}
            g.height = slaveBhei - bw * 2
            g.width = mainwid - bw * 2
            g.x = wa.x 
            g.y = wa.y + mainhei
            c:geometry(g)

        --If four clients or more 
        else
            --client 1
            c = cls[1]
            g = {}
            g.height = mainhei - bw * 2
            g.width = mainwid - bw * 2
            g.x = wa.x
            g.y = wa.y
            c:geometry(g)
        
            --client 2
            c = cls[2]
            g = {}
            g.height = slaveRhei - bw * 2 
            g.width = slaveRwid - bw * 2
            g.x = wa.x + mainwid
            g.y = wa.y
            c:geometry(g)

            --client 3
            c = cls[3]
            g = {}
            g.height = slaveBhei - bw * 2 
            g.width = mainwid - bw * 2
            g.x = wa.x
            g.y = wa.y + mainhei
            c:geometry(g)
        
            --all other clients
            for i = 4, #cls, 1 do
                c = cls[i]
                g = {}

                g.height = wa.height - slaveRhei - bw * 2
                g.width = slaveRwid - bw * 2
                g.x = wa.x + mainwid
                g.y = wa.y + slaveRhei
                c:geometry(g)
            end
        end
    end
end

return nlay
