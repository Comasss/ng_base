Config = {
    Debug = false,
    Framework = 'esx', --[[ 
        Valid options:
        'esx' (es_extended)
        'qb' (qb-core)
    ]]
    Language = 'es', --[[
        Valid options:

        'es' (Español / Spanish)
        'en' (Ingles / English)
        'custom' (Custom)
    ]]
    Command = {
        Enabled = true,
        Keybind = false,
        Name = 'togglestreet',
        DefaultKey = '' -- Input Parameter: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
    },
    Notification = 'esx' --[[
        Valid options:

        't-notify' -- https://github.com/TasoOneAsia/t-notify
        'mythic_notify' -- https://github.com/wowpanda/mythic_notify
        'okokNotify' -- https://forum.cfx.re/t/okoknotify-standalone-paid/3907758
        'esx' -- Default esx
        'qb' -- Default qbcore
    ]]
}

Locales = {
    ['es'] = { -- Spanish locale
        ['activated_command'] = 'Has activado el hud de las calles',
        ['desactivated_command'] = 'Has desactivado el hud de las calles',
        ['keybind_command'] = 'Desactivar/activar hud de las calles'
    },
    ['en'] = { -- English locale
        ['activated_command'] = 'You have enabled the street hud',
        ['desactivated_command'] = 'You have disabled the street hud',
        ['keybind_command'] = 'Disable/enable street hud'
    },
    ['custom'] = { -- Custom locale
        ['activated_command'] = '',
        ['desactivated_command'] = '',
        ['keybind_command'] = ''
    }
}