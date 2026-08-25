hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl set +5%"),
    { repeating = true }
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl set 5%-"),
    { repeating = true }
)

hl.bind(
    "SUPER + SHIFT + L",
    hl.dsp.exec_cmd("hyprlock")
)

hl.bind(
    "Print",
    hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]])
)

hl.bind(
    "SUPER + Print",
    hl.dsp.exec_cmd(
        [[mkdir -p "$HOME/Pictures/Screenshots"; grim "$HOME/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"]]
    )
)