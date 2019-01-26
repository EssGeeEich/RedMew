local Event = require 'utils.event'
local Game = require 'utils.game'
local Global = require 'utils.global'
local Gui = require 'utils.gui'
local Color = require 'resources.color_presets'
local Command = require 'utils.command'

local type = type
local tonumber = tonumber
local pairs = pairs
local size = table.size

local Public = {}

local memory = {
    id = 0,
    active_toasts = {},
}

Global.register(memory, function (tbl) memory = tbl end, 'toast')

---Creates a unique ID for a toast message
local function autoincrement()
    local id = memory.id + 1
    memory.id = id
    return id
end

---Toast to a specific player
---@param p number|string|LuaPlayer player index or object
---@param duration number in seconds
---@param message|nil message displayed, leave empty to have an empty LuaGuiElement
function Public.toast_player(p, duration, message)
    local player
    local player_name

    if type(p) == 'string' then
        player = Game.get_player_by_index(tonumber(p))
        player_name = player.name
    elseif type(p) == 'number' then
        player = Game.get_player_by_index(p)
        player_name = player.name
    else
        player = p
        player_name = p.name
    end

    if not player or not player.valid then
        return nil
    end

    local frame = player.gui.left.add({type = 'frame', direction = 'vertical', style = 'captionless_frame'})
    frame.style.width = 300

    local container = frame.add({type = 'flow', direction = 'horizontal'})
    container.style.horizontally_stretchable = true

    local progressbar = frame.add({type = 'progressbar'})
    local style = progressbar.style
    style.width = 290
    style.height = 3
    style.color = Color.grey
    progressbar.value = 1 -- it starts full

    local id = autoincrement()
    local tick = game.tick
    if not duration then
        duration = 15
    end

    Gui.set_data(frame, {
        is_toast = true,
        toast_id = id,
        progressbar = progressbar,
        start_tick = tick,
        end_tick = tick + duration * 60
    })
    memory.active_toasts[id] = player_name

    if message ~= nil then
        local label = container.add({type = 'label', caption = message})
        label.style.single_line = false
    end

    return container
end

---Attempts to get a toast based on the element, will traverse through parents to find it.
---@param element LuaGuiElement
local function get_toast(element)
    if not element or not element.valid then
        return nil
    end

    local data = Gui.get_data(element)

    if data and data.is_toast then
        return element, data
    end

    -- no data, have to check the parent
    return get_toast(element.parent)
end

Event.add(defines.events.on_gui_click, function (event)
    local element, data = get_toast(event.element)
    if not element or not data then
        return
    end

    Gui.destroy(element)
    memory.active_toasts[data.toast_id] = nil
end)

Event.on_nth_tick(2, function (event)
    local active_toasts = memory.active_toasts
    if size(active_toasts) == 0 then
        return
    end

    local tick = event.tick
    local players = game.players

    for _, player_name in pairs(active_toasts) do
        local player = players[player_name]
        if player and player.valid then
            for _, element in pairs(player.gui.left.children) do
                local toast, data = get_toast(element)
                if toast and data then
                    local end_tick = data.end_tick

                    if tick > end_tick then
                        Gui.destroy(element)
                        active_toasts[data.toast_id] = nil
                    else
                        local limit = end_tick - data.start_tick
                        local current = end_tick - tick
                        data.progressbar.value = current / limit
                    end
                end
            end
        end
    end
end)

Event.add(defines.events.on_player_left_game, function (event)
    local active_toasts = memory.active_toasts
    if size(active_toasts) == 0 then
        return
    end

    -- active toasts, do a cleanup so data remains uncorrupted
    for _, element in pairs(Game.get_player_by_index(event.player_index).gui.left.children) do
        local toast = get_toast(element)
        if toast then
            Gui.destroy(element)
        end
    end
end)

Command.add('toast', {
    description = 'Toast!',
    arguments = {'message'},
    capture_excess_arguments = true,
}, function (arguments)
    for _, player in pairs(game.connected_players) do
        Public.toast_player(player, 10, arguments.message)
    end
end)

return Public