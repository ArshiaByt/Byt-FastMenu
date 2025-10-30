Config = {}

--------------------------------------------------
-- 🔑 GENERAL SETTINGS
--------------------------------------------------

--------------------------------------------------
-- 🖼️ SERVER LOGO / ICON SETTINGS
--------------------------------------------------
-- Place any image URL (png/jpg/webp/svg) resolution 1024x1024 or higher
Config.ServerIcon = "https://cdn.discordapp.com/attachments/1076090217238368286/1433511154705105047/ChatGPT_Image_Oct_30_2025_09_11_15_PM.png?ex=6904f4cc&is=6903a34c&hm=23231f221d1eac2a7001a4289114ff0f1d4775789d1693577623969f5bf210fa&"
-- Leave empty ("") to disable icon display


-- Key to open the FastMenu
Config.OpenKey = 'F2'

-- Cooldown between menu opens (milliseconds)
Config.MenuCooldown = 1000

-- Default message when no announcement is available
Config.DefaultAnnouncement = "No announcements at this time."

--------------------------------------------------
-- 🔊 SOUND SETTINGS
--------------------------------------------------

Config.SoundVolume = 0.55
Config.Sounds = {
    buy     = { name = "Event_Message_Purple", set = "GTAO_FM_Events_Soundset" },
    error   = { name = "Place_Prop_Fail", set = "DLC_Dmod_Prop_Editor_Sounds" },
    click   = { name = "TENNIS_MATCH_POINT", set = "HUD_AWARDS" },
    select  = { name = "NAV_LEFT_RIGHT", set = "HUD_FRONTEND_DEFAULT_SOUNDSET" },
    hit     = { name = "hit", set = "InteractSound_CL" }
}

--------------------------------------------------
-- ⚙️ NUI ACTIONS / EVENTS
--------------------------------------------------

Config.Events = {

    --------------------------------------------------
    -- 🧠 SERVER CALLBACKS
    --------------------------------------------------
    Server = {
        -- Used for getting gang count / info (if needed)
        GetGangCount = 'FastMenu:getGangCount',
    },

    --------------------------------------------------
    -- 🖥️ CLIENT EVENTS (Edit these for your own scripts)
    --------------------------------------------------
    Client = {
        ToggleInventory = 'your_inventory_script:toggle',    -- Example: 'ox:toggleInventory' or 'qs-inventory:client:openInventory'
        OpenCaseSystem  = 'your_case_script:open',           -- Example: 'Byt:Ak4yOpenCaseSystem'
        LACShopMenu     = 'your_shop_script:open',           -- Example: 'Byt:LACShopMenuOpener'
        OpenDocs        = 'your_docs_script:open',           -- Example: 'openDocs'
        FastMenu        = 'your_fastmenu:open',              -- Example: 'fastMenu'
        Billing         = 'your_bills_script:open',          -- Example: 'biling'
    },

    --------------------------------------------------
    -- ⚡ COMMANDS (You can rename to match your server)
    --------------------------------------------------
    Commands = {
        Quests       = 'your_command_for_quests',            -- Example: 'quests'
        TopCriminals = 'your_command_for_topcriminals',      -- Example: 'topcriminals'
        CancelQuest  = 'your_command_for_cancelquest',       -- Example: 'cancelquest'
        GangList     = 'your_command_for_ganglist'           -- Example: 'glist'
    },

    --------------------------------------------------
    -- 🛒 EXTERNAL EXPORTS (if other resources expose functions)
    --------------------------------------------------
    Exports = {
        OpenDonate   = 'your_donate_script:open',            -- Example: 'esx_coins:openCoins'
        OpenBills    = 'your_bills_script:open',             -- Example: 'openBills'
        OpenRanking  = 'your_ranking_script:open',           -- Example: 'esx_billing:OpenRankingMenu'
        Leaderboard  = 'your_leaderboard_script:open'        -- Example: 'esx_advancedgarage:Leaderboard'
    },

    --------------------------------------------------
    -- 🎯 BUTTON BINDINGS (UI → Trigger)
    --------------------------------------------------
    Buttons = {
        announce     = { type = "client_event", trigger = "your_shop_script:open" },
        achievements = { type = "command",      trigger = "your_command_for_quests" },
        jobcenter    = { type = "command",      trigger = "your_command_for_topcriminals" },
        myfamily     = { type = "command",      trigger = "your_command_for_ganglist" },
        mybills      = { type = "command",      trigger = "your_bills_script:open" },
        inventory    = { type = "client_event", trigger = "your_inventory_script:toggle" },
        cancelquest  = { type = "command",      trigger = "your_command_for_cancelquest" },
        casesystem   = { type = "client_event", trigger = "your_case_script:open" },
        commands     = { type = "client_event", trigger = "your_docs_script:open" }
    }
}

--------------------------------------------------
-- ✅ PERMISSIONS / WHITELIST
--------------------------------------------------

Config.AllowedActions = {
    "your_command_for_cancelquest", "your_command_for_quests", "your_command_for_topcriminals",
    "openTopGangs", "your_command_for_ganglist", "your_inventory_script:toggle",
    "openRewardMenu", "your_docs_script:open", "your_fastmenu:open",
    "your_case_script:open", "your_bills_script:open", "your_shop_script:open"
}
