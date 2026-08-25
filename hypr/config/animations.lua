hl.curve("fraustyEase", {
    type = "bezier",
    points = {
        { 0.16, 1.0 },
        { 0.30, 1.0 },
    },
})

hl.curve("fraustySoft", {
    type = "bezier",
    points = {
        { 0.25, 0.10 },
        { 0.25, 1.00 },
    },
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 4,
    bezier = "fraustyEase",
    style = "popin 90%",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 4,
    bezier = "fraustySoft",
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 4,
    bezier = "fraustySoft",
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 5,
    bezier = "fraustyEase",
    style = "slidefade 20%",
})