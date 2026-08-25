for i = 1, 10 do
    local key = tostring(i % 10)

    hl.bind(
        "SUPER + " .. key,
        hl.dsp.focus({ workspace = i })
    )

    hl.bind(
        "SUPER + SHIFT + " .. key,
        hl.dsp.window.move_to_workspace({ workspace = i })
    )
end