local hl = hl

--TODO: split config

--------------------------------------------------------------------------------
-- Data
--------------------------------------------------------------------------------

-- Programs
local terminal = "alacritty"
local menu = "hyprlauncher"
local fileManager = "nautilus"

--TODO: use theme switcher

-- Colours
-- local cols = {
--   border_active1 = "#33ccff",
--   border_active2 = "#00ff99",
--   border_inactive = "#595959",
--   blue1 = "#99c1f1",
--   green1 = "#8ff0a4",
--   light1 = "#ffffff",
--   light2 = "#f6f5f4",
--   dark2 = "#5e5c64",
--   dark3 = "#3d3846",
--   dark4 = "#241f31",
-- }

local cols_gnome = {
  blue = {
    [1] = "#99c1f1",
    [2] = "#62a0ea",
    [3] = "#3584e4",
    [4] = "#1c71d8",
    [5] = "#1a5fb4",
  },

  green = {
    [1] = "#8ff0a4",
    [2] = "#57e389",
    [3] = "#33d17a",
    [4] = "#2ec27e",
    [5] = "#26a269",
  },

  yellow = {
    [1] = "#f9f06b",
    [2] = "#f8e45c",
    [3] = "#f6d32d",
    [4] = "#f5c211",
    [5] = "#e5a50a",
  },

  orange = {
    [1] = "#ffbe6f",
    [2] = "#ffa348",
    [3] = "#ff7800",
    [4] = "#e66100",
    [5] = "#c64600",
  },

  red = {
    [1] = "#f66151",
    [2] = "#ed333b",
    [3] = "#e01b24",
    [4] = "#c01c28",
    [5] = "#a51d2d",
  },

  purple = {
    [1] = "#dc8add",
    [2] = "#c061cb",
    [3] = "#9141ac",
    [4] = "#813d9c",
    [5] = "#613583",
  },

  brown = {
    [1] = "#cdab8f",
    [2] = "#b5835a",
    [3] = "#986a44",
    [4] = "#865e3c",
    [5] = "#63452c",
  },

  light = {
    [1] = "#ffffff",
    [2] = "#f6f5f4",
    [3] = "#deddda",
    [4] = "#c0bfbc",
    [5] = "#9a9996",
  },

  dark = {
    [1] = "#77767b",
    [2] = "#5e5c64",
    [3] = "#3d3846",
    [4] = "#241f31",
    [5] = "#000000",
  },
}

--------------------------------------------------------------------------------
-- Monitor
--------------------------------------------------------------------------------
hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = 1,
})

--------------------------------------------------------------------------------
-- Environment
--------------------------------------------------------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

--------------------------------------------------------------------------------
-- Input
--------------------------------------------------------------------------------
hl.config({
  input = {
    kb_layout    = "us",
    kb_options   = "compose:caps",
    follow_mouse = 1,
    sensitivity  = 0, -- mouse default
    touchpad     = {
      natural_scroll = true,
      tap_to_click = true,
      drag_lock = false,
    },
    repeat_rate  = 25,
    repeat_delay = 150,
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

--------------------------------------------------------------------------------
-- Windows/Workspaces
--------------------------------------------------------------------------------

-- Ignore maximize requests from all apps
hl.window_rule({
  name           = "suppress-maximize-events",
  match          = { class = ".*" },
  suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },
  move  = "20 monitor_h-120",
  float = true,
})

--------------------------------------------------------------------------------
-- Misc
--------------------------------------------------------------------------------
hl.config({
  misc = {
    force_default_wallpaper    = 0,
    disable_hyprland_logo      = true,
    disable_splash_rendering   = true,
    mouse_move_enables_dpms    = true,
    animate_manual_resizes     = false,
    initial_workspace_tracking = false,
  },
  render = {
    direct_scanout = true, -- performance thing
  },
  debug = {
    disable_logs = false,
    vfr = true, -- variable refresh rate
  }
})

--------------------------------------------------------------------------------
-- Visual/Animations
--------------------------------------------------------------------------------
hl.config({
  general = {
    gaps_in          = 4,
    gaps_out         = 10,
    border_size      = 2,
    col              = {
      active_border   = { colors = { cols_gnome.blue[1], cols_gnome.blue[3], cols_gnome.green[1] }, angle = 45 },
      inactive_border = { colors = { cols_gnome.dark[3], cols_gnome.dark[4] }, angle = 45 },
    },
    resize_on_border = false, -- border and gaps a "part of the windows" when resizing
    allow_tearing    = true,
    layout           = "dwindle",
  },

  decoration = {
    rounding         = 8,
    rounding_power   = 2,
    active_opacity   = 1.0,
    inactive_opacity = 1.0,
    shadow           = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = 0xee1a1a1a,
    },
    blur             = {
      enabled  = true,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })

hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "popin 90%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "easeOutQuint", style = "popin 90%" })

hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "quick" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1, bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1, bezier = "easeOutQuint" })

hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 2, bezier = "easeOutQuint", style = "popin 30%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "easeInOutCubic", style = "popin 90%" })
hl.animation({ leaf = "fadeLayersIn", enabled = false, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2, bezier = "almostLinear" })

-- hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "easeInOutCubic", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "easeInOutCubic", style = "slide" })

hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
  dwindle = {
    preserve_split = true, -- You probably want this
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
  master = {
    new_status = "master",
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

--------------------------------------------------------------------------------
-- Keybindings
--------------------------------------------------------------------------------

local mod = "SUPER"

-- Program shortcuts
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + Space", hl.dsp.exec_cmd(menu))

-- Window actions
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + C", function()
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
  hl.dispatch(hl.dsp.window.center())
end)

-- Quit hyprland
hl.bind(mod .. " + SHIFT + Q",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Manually reload config
hl.bind(mod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Move focus
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + TAB", hl.dsp.window.cycle_next())

-- Move window within the current workspace
hl.bind(mod .. " + CTRL + H", hl.dsp.window.move({ direction = "left", group_aware = true, }))
hl.bind(mod .. " + CTRL + L", hl.dsp.window.move({ direction = "right", group_aware = true, }))
hl.bind(mod .. " + CTRL + K", hl.dsp.window.move({ direction = "up", group_aware = true, }))
hl.bind(mod .. " + CTRL + J", hl.dsp.window.move({ direction = "down", group_aware = true, }))

-- Resize window
--TODO: make this a 10th of the screen size hor. and ver.
local resize_step = 120
hl.bind(mod .. " + equal", hl.dsp.window.resize({ x = resize_step, y = 0, relative = true, }))
hl.bind(mod .. " + minus", hl.dsp.window.resize({ x = -resize_step, y = 0, relative = true, }))
hl.bind(mod .. " + SHIFT + equal", hl.dsp.window.resize({ x = 0, y = resize_step, relative = true, }))
hl.bind(mod .. " + SHIFT + minus", hl.dsp.window.resize({ x = 0, y = -resize_step, relative = true, }))

-- Move window to the next/prev workspace
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ workspace = "r-1", group_aware = true, }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ workspace = "r+1", group_aware = true, }))

-- Move/resize windows with super+click
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Scroll through workspaces
-- hl.bind(mod .. " + CTRL + L", hl.dsp.focus({ workspace = "r+1" }))
-- hl.bind(mod .. " + CTRL + H", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mod .. " + TAB", function()
  local curr_wsp = hl.get_active_workspace()
  local next_wsp = hl.get_workspace(curr_wsp.id + 1)
  if (curr_wsp and #hl.get_workspace_windows(curr_wsp) > 0) or next_wsp then
    hl.dispatch(hl.dsp.focus({ workspace = "r+1" }))
  end
end)
hl.bind(mod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })




--------------------------------------------------------------------------------
-- Autostart
--------------------------------------------------------------------------------

hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("hyprpaper")
  -- set gtk dark theme
  --TODO: check errors
  hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
  hl.exec_cmd("hyprlauncher -d")
end)
