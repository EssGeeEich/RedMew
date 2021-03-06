_DEBUG = false
_CHEATS = false
_DUMP_ENV = false
local currency = 'coin'

global.config = {
    -- adds a GUI listing the scenario features, the rules, and the details of the current map
    map_info = {
        enabled = true,
        -- The title of the map
        map_name_key = 'This Map has no name',
        -- The long description of the map, typically 1 paragraph
        map_description_key = "This section is supposed to be filled out on a per map basis. If you're seeing this message, ping the admin team to get a description added for this map. A 20 coin bonus is available to the first person to point this out.",
        -- The feature list of the map
        map_extra_info_key = 'This map has no extra information',
        -- New Scenario Features, appears in the "What's new" tab
        new_info_key = 'Nothing is new. The world is at peace'
    },
    -- map generation settings for redmew's maps (only applies to maps that use 'shapes')
    map_generation = {
        -- whether to regen decoratives
        ['regen_decoratives'] = false,
        -- the number of 'tiles' that are calculated per tick
        ['tiles_per_tick'] = 32,
        -- the entity modules to load (takes a list of requires), example included
        ['entity_modules'] = {
            -- require('map_gen.entities.fluffy_rainbows')
        },
        -- the terrain modules to load (takes a list of requires), example included
        ['terrain_modules'] = {
            --require('map_gen.terrain.tris_chunk_grid')
        },
    },
    -- redmew_surface allows a map preset to control world generation as well as map and difficulty settings
    -- the entire module can be toggled or just individual parts
    redmew_surface = {
        enabled = true,
        map_gen_settings = true,
        map_settings = true,
        difficulty = true
    },
    -- time before a player gets the auto-trusted rank, allowing them access to the deconstructions planner, nukes, etc.
    rank_system = {
        time_for_trust = 3 * 60 * 60 * 60, -- 3 hours
        everyone_is_regular = false
    },
    -- saves players' lives if they have a small-plane in their inventory, also adds the small-plane to the market and must therefor be loaded first
    train_saviour = {
        enabled = true
    },
    -- Adds the infinite storage chest to the market and adds a custom GUI to it. Also has to be loaded first due to adding a market item
    infinite_storage_chest = {
        enabled = false,
        cost = 100
    },
    -- adds a command to scale UPS and movement speed. Use with caution as it might break scenarios that modify movement speed
    performance = {
        enabled = true
    },
    -- adds a player list icon and keeps track of data.
    player_list = {
        enabled = true,
        show_coin_column = true
    },
    -- enables the poll system
    poll = {
        enabled = true
    },
    -- enables players to create and join tags
    tag_group = {
        enabled = true
    },
    -- enables players to create and prioritize tasks
    tasklist = {
        enabled = true
    },
    -- enables the blueprint helper
    blueprint_helper = {
        enabled = true
    },
    -- enables score and tracking thereof
    score = {
        enabled = true
    },
    -- adds a paint brush
    paint = {
        enabled = true
    },
    -- adds a market
    market = {
        enabled = true,
        -- will create a standard market on game startup
        create_standard_market = true,
        -- the coordinates at which the standard market will be created
        standard_market_location = {x = 0, y = -5},
        currency = currency,
        -- defines the chance that killing an entity will drop coins and the min and max it can drop upon death
        entity_drop_amount = {
            ['biter-spawner'] = {low = 5, high = 15, chance = 1},
            ['spitter-spawner'] = {low = 5, high = 15, chance = 1},
            ['small-worm-turret'] = {low = 2, high = 8, chance = 1},
            ['medium-worm-turret'] = {low = 5, high = 15, chance = 1},
            ['big-worm-turret'] = {low = 10, high = 20, chance = 1},
            -- default is 0, no chance of coins dropping from biters/spitters
            ['small-biter'] = {low = 1, high = 5, chance = 0},
            ['small-spitter'] = {low = 1, high = 2, chance = 0},
            ['medium-spitter'] = {low = 1, high = 3, chance = 0},
            ['big-spitter'] = {low = 1, high = 3, chance = 0},
            ['behemoth-spitter'] = {low = 1, high = 10, chance = 0},
            ['medium-biter'] = {low = 1, high = 3, chance = 0},
            ['big-biter'] = {low = 1, high = 5, chance = 0},
            ['behemoth-biter'] = {low = 1, high = 10, chance = 0}
        }
    },
    -- adds anti-nuke griefing
    nuke_control = {
        enabled = true,
        enable_autokick = true,
        enable_autoban = true,
        -- how long a player must be on the server to be allowed to use the nuke
        nuke_min_time_hours = 3
    },
    -- adds a meltdown feature, requiring precise management
    reactor_meltdown = {
        enabled = true,
        -- when enabled, controls whether it's on by default. State can be controlled with the /meltdown command.
        on_by_default = false
    },
    -- adds hodor responses to messages
    hodor = {
        enabled = true
    },
    -- enable RedMew auto respond messages
    auto_respond = {
        enabled = true
    },
    -- enable the mentioning system, which notifies a player when their name is mentioned
    mentions = {
        enabled = true
    },
    -- settings for when a player joins the server for the first time
    player_create = {
        enabled = true,
        -- items automatically inserted into the player inventory
        starting_items = {
            {name = 'iron-gear-wheel', count = 8},
            {name = 'iron-plate', count = 16}
        },
        -- opens the scenario popup when the player joins
        show_info_at_start = true,
        -- prints messages when the player joins
        join_messages = {
            'Welcome to this map created by the RedMew team. You can join our discord at: redmew.com/discord',
            'Click the question mark in the top left corner for server information and map details.'
        },
        -- format is a table: {{message, weight}, {message, weight}}, where a higher weight has more chance to be shown
        random_join_message_set = require 'resources.join_messages',
        -- applied when cheat_mode is set to true
        cheats = {
            -- Sets the manual mining speed for the player force. A value of 1 = 100% faster. Setting it
            -- to 0.5 would make it 50% faster than the base speed.
            manual_mining_speed_modifier = 1000,
            -- increase the amount of inventory slots for the player force
            character_inventory_slots_bonus = 0,
            -- increases the run speed of all characters for the player force
            character_running_speed_modifier = 5,
            -- a flat health bonus to the player force
            character_health_bonus = 1000000,
            -- starts with a fully slotted power armor mk2
            start_with_power_armor = true,
            -- adds additional items to the player when _CHEATS is true
            starting_items = {
                {name = 'steel-axe', count = 10},
                {name = 'submachine-gun', count = 1},
                {name = 'uranium-rounds-magazine', count = 200},
                {name = 'construction-robot', count = 250},
                {name = 'electric-energy-interface', count = 50},
                {name = 'substation', count = 50},
                {name = 'roboport', count = 10},
                {name = 'infinity-chest', count = 10},
                {name = 'small-plane', count = 2},
                {name = 'coin', count = 20000},
                {name = 'rocket-part', count = 2},
                {name = 'computer', count = 2}
            }
        }
    },
    -- spawns more units when one dies
    hail_hydra = {
        enabled = false,
        -- at which scale the evolution will increase the additional hydra spawns
        -- to disable scaling with evolution, set to 0.
        -- the formula: chance = hydra_chance + (evolution_factor * evolution_scale)
        -- example: small spitter has 0.2, which is 20% at 0% and 120% at an evolution_factor of 1
        evolution_scale = 1,
        -- any non-rounded number will turn into a chance to spawn an additional alien
        -- example: 2.5 would spawn 2 for sure and 50% chance to spawn one additionally
        hydras = {
            -- spitters
            ['small-spitter'] = {['small-worm-turret'] = 0.2},
            ['medium-spitter'] = {['medium-worm-turret'] = 0.2},
            ['big-spitter'] = {['big-worm-turret'] = 0.2},
            ['behemoth-spitter'] = {['big-worm-turret'] = 0.4},
            -- biters
            ['medium-biter'] = {['small-biter'] = 1.2},
            ['big-biter'] = {['medium-biter'] = 1.2},
            ['behemoth-biter'] = {['big-biter'] = 1.2},
            -- worms
            ['small-worm-turret'] = {['small-biter'] = 2.5},
            ['medium-worm-turret'] = {['small-biter'] = 2.5, ['medium-biter'] = 0.6},
            ['big-worm-turret'] = {['small-biter'] = 3.8, ['medium-biter'] = 1.3, ['big-biter'] = 1.1}
        }
    },
    -- grants reward coins for certain actions
    player_rewards = {
        enabled = true,
        -- the token to use for rewards
        token = currency,
        -- rewards players for looking through the info tabs
        info_player_reward = true
    },
    -- makes manual stuff cumbersome
    lazy_bastard = {
        enabled = false
    },
    -- automatically marks miners for deconstruction when they are depleted (currently compatible with hard mods that add miners)
    autodeconstruct = {
        enabled = true
    },
    -- when a player dies, leaves a map marker until the corpse expires or is looted
    corpse_util = {
        enabled = true
    },
    -- adds many commands for users and admins alike
    redmew_commands = {
        enabled = true
    },
    -- adds many commands for admins
    admin_commands = {
        enabled = true
    },
    player_colors = {
        enabled = true
    },
    -- adds a command that switches a player to the enemy force and teleports them far away for some time to calm down
    walkabout = {
        enabled = true
    },
    -- adds a command to generate a popup dialog box for players to see, useful for important announcements
    popup = {
        enabled = true
    },
    -- adds a camera to watch another player
    camera = {
        enabled = true
    },
    -- adds small quality of life tweaks for multiplayer play
    redmew_qol = {
        enabled = true,
        -- restricts placed chests to 1 square of inventory
        restrict_chest = false,
        -- gives entities with backer names a chance to be named after a player or redmew regular
        backer_name = true,
        -- gives locos placed a random color
        random_train_color = true,
        -- gives players entity ghosts (from destruction like biter attacks) before the required research is complete
        ghosts_before_research = true,
        -- adds craftable loaders.
        loaders = true
    },
    -- adds a useless button with the biter percentage
    evolution_progress = {
        enabled = true
    },
    -- sets the day/night cycle or a fixed light level. use_day_night_cycle and use_fixed_brightness are mutually exclusive
    day_night = {
        -- enables/disables the module
        enabled = false,
        -- for info on day/night cycles see https://github.com/Refactorio/RedMew/wiki/Day-Night-cycle
        use_day_night_cycle = false,
        day_night_cycle = {
            ticks_per_day = 25000,
            dusk = 0.25,
            evening = 0.45,
            morning = 0.55,
            dawn = 0.75
        },
        -- brightness is a number between 0.15 and 1
        use_fixed_brightness = false,
        fixed_brightness = 0.5
    },
    -- enables a command which allows for an end-game event
    apocalypse = {
        enabled = true
    }
}

return global.config
