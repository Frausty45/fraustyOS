local terminal = "kitty"

hl.bind("SUPER + Q",
    hl.dsp.exec_cmd(terminal)
)

hl.bind("SUPER + C",
    hl.dsp.window.close()
)

hl.bind("Alt + F4",
    hl.dsp.window.kill()
)

hl.bind("SUPER + F",
    hl.dsp.window.fullscreen()
)

hl.bind("SUPER + V",
    hl.dsp.window.float({ action = "toggle" })
)

hl.bind("SUPER + Left",
    hl.dsp.focus({ direction = "l" })
)

hl.bind("SUPER + Down",
    hl.dsp.focus({ direction = "d" })
)

hl.bind("SUPER + Up",
    hl.dsp.focus({ direction = "u" })
)

hl.bind("SUPER + Right",
    hl.dsp.focus({ direction = "r" })
)