hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        layout = "dwindle",

        ["col.active_border"] = "rgba(89b4faff)",
        ["col.inactive_border"] = "rgba(313244aa)",
    },

    decoration = {
        rounding = 12,

        blur = {
            enabled = true,
            size = 6,
            passes = 2,
        },

        shadow = {
            enabled = true,
            range = 12,
            render_power = 3,
            color = "rgba(00000055)",
        },
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        animate_manual_resizes = true,
        animate_mouse_windowdragging = true,
        focus_on_activate = true,
    },
})