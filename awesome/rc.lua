Gvicious = require("vicious")
-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

-- Load Debian menu entries
require("debian.menu")

-- Override awesome.quit when we're using GNOME
_awesome_quit = awesome.quit
awesome.quit = function()
    if os.getenv("DESKTOP_SESSION") == "awesome-gnome" then
        os.execute("/usr/bin/gnome-session-quit")
    else
        _awesome_quit()
    end
end

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor
shutdown = "/usr/bin/gnome-session-quit --power-off"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
-- modkey = "Mod1"
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.floating,
    awful.layout.suit.max.fullscreen
    -- awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
-- tags = {
  -- names = { "term", "www", "vim", "im", 5, 6, 7, 8, 9},
  -- layout = { layouts[0], layouts[
  -- }  
-- }
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Debian", debian.menu.Debian_menu.Debian },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))


-- Create memory text widget
memwi_t = widget({ type = "textbox" })
-- Register widget
vicious.register(memwi_t, vicious.widgets.mem, " $4/$3 MB ", 13)

-- Create memory bar widget
memwi_b = awful.widget.progressbar()
-- Progressbar properties
memwi_b:set_width(8)
memwi_b:set_height(16)
memwi_b:set_vertical(true)
memwi_b:set_background_color("#494B4F")
memwi_b:set_border_color(nil)
memwi_b:set_color("#AECF96")
memwi_b:set_gradient_colors({ "#AECF96", "#88A175", "#FF5656" })
vicious.register(memwi_b, vicious.widgets.mem, "$1", 13)

-- Create cpy text widget
-- cpuwi_t = widget({ type = "textbox", width = 20 })
-- cpuwi_t.width = 30
-- Register widget
-- vicious.register(cpuwi_t, vicious.widgets.cpu, "$1%")

-- Create cpy text widget
oskern_t = widget({ type = "textbox" })
vicious.register(oskern_t, vicious.widgets.os, "$1 $2")

-- Create CPU bar (Core 0) widget
cpu0wi_b = awful.widget.graph()
cpu0wi_b:set_width(50)
cpu0wi_b:set_background_color("#494B4F")
cpu0wi_b:set_color("#FF5656")
cpu0wi_b:set_gradient_colors({ "#FF5656", "#88A175", "#AECF96" })
vicious.register(cpu0wi_b, vicious.widgets.cpu, "$2")

-- Create CPU bar (Core 1) widget
cpu1wi_b = awful.widget.graph()
cpu1wi_b:set_width(50)
cpu1wi_b:set_background_color("#494B4F")
cpu1wi_b:set_color("#FF5656")
cpu1wi_b:set_gradient_colors({ "#FF5656", "#88A175", "#AECF96" })
vicious.register(cpu1wi_b, vicious.widgets.cpu, "$3")

-- Create CPU bar (Core 2) widget
cpu2wi_b = awful.widget.graph()
cpu2wi_b:set_width(50)
cpu2wi_b:set_background_color("#494B4F")
cpu2wi_b:set_color("#FF5656")
cpu2wi_b:set_gradient_colors({ "#FF5656", "#88A175", "#AECF96" })
vicious.register(cpu2wi_b, vicious.widgets.cpu, "$4")

-- Create CPU bar (Core 3) widget
cpu3wi_b = awful.widget.graph()
cpu3wi_b:set_width(50)
cpu3wi_b:set_background_color("#494B4F")
cpu3wi_b:set_color("#FF5656")
cpu3wi_b:set_gradient_colors({ "#FF5656", "#88A175", "#AECF96" })
vicious.register(cpu3wi_b, vicious.widgets.cpu, "$5")

-- Create Battery widgetfor BAT0
batwi_t = widget({ type = "textbox" })
vicious.register(batwi_t, vicious.widgets.bat, "$1 $2%", 61, "BAT0")

-- Create Battery widget for BAT1
batw2_t = widget({ type = "textbox" })
vicious.register(batw2_t, vicious.widgets.bat, "$1 $2%", 61, "BAT1")

-- Create separator widget
separator = widget({ type = "textbox" })
separator.text = " :: "

-- Volume indicator
-- Load the widget.

-- Keyboard map indicator and changer
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.cmdmodmap = "xmodmap $HOME/.Xmodmap"
kbdcfg.layout = { "se", "us" }
kbdcfg.current = 1  -- us is our default layout
kbdcfg.widget = widget({ type = "textbox", align = "right" })
kbdcfg.widget.text = " " .. kbdcfg.layout[kbdcfg.current] .. " "
kbdcfg.switch = function ()
   kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
   local t = " " .. kbdcfg.layout[kbdcfg.current] .. " "
   kbdcfg.widget.text = t
   os.execute( kbdcfg.cmd .. t )
   os.execute( kbdcfg.cmdmodmap )
end

-- Mouse bindings keyboard layout changer
kbdcfg.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () kbdcfg.switch() end)
))

-- Example: Add to wibox. Here to the right. Do it the way you like it.
--right_layout:add(APW)

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 20 })
    -- Add widgets to the wibox - order matters
    --local APW = require("apw/widget")
    mywibox[s].widgets = {
            {
                mylauncher,
                mytaglist[s],
                mypromptbox[s],
                layout = awful.widget.layout.horizontal.leftright
            },
            mylayoutbox[s],
            mytextclock,
            --APW,
            s == 1 and mysystray or nil,
            separator,
            batwi_t,
            batw2_t,
            separator,
            kbdcfg.widget,
            separator,
            memwi_t,
            memwi_b.widget,
            separator,
            cpu3wi_b.widget,
            separator,
            cpu2wi_b.widget,
            separator,
            cpu1wi_b.widget,
            separator,
            cpu0wi_b.widget,
            separator,
            oskern_t,
            mytasklist[s],
            layout = awful.widget.layout.horizontal.rightleft
    }
    --APWTimer = timer({ timeout = 0.5 }) -- set update interval in s
    --APWTimer:connect_signal("timeout", APW.Update)
    --APWTimer:start()
--[[
    mywibox[s].widgets = {
        {
            {
                mylauncher,
                mytaglist[s],
                mypromptbox[s],
                layout = awful.widget.layout.horizontal.leftright
            },
            mylayoutbox[s],
            mytextclock,
            s == 1 and mysystray or nil,
            mytasklist[s],
            layout = awful.widget.layout.horizontal.rightleft
        },
        {
            {
                memwi_t,
                memwi_b,
                separator,
                cpuwi_t,
                cpuwi_b,
                layout = awful.widget.layout.horizontal.rightleft,
                height = 12
            }
        },
        layout = awful.widget.layout.vertical.flex,
        height = mywibox[s].height
    }
--]]
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    -- awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "p", function ()
        awful.util.spawn("dmenu_run -i -p 'Run command:' -nb '" ..
            beautiful.bg_normal .. "' -nf '" .. beautiful.fg_normal ..
            "' -sb '" .. beautiful.bg_focus ..
            "' -sf '" .. beautiful.fg_focus ..
            "' -fn '-*-terminus-medium-*-*-*-12-*-*-*-*-*-*-*" .. "'")
        end),
    -- function () awful.util.spawn("dmenu_run") end), -- without customization

    -- Change monitor setting
    -- awful.key({ modkey,           }, "F12",   function () awful.util.spawn("monitor_above.sh toggle") end),
    awful.key({ modkey,           }, "F12",   function () awful.util.spawn("autorandr --change") end),
    awful.key({ modkey,           }, "F4",   function () awful.util.spawn("dbus-send --system --print-reply --dest='org.freedesktop.UPower' /org/freedesktop/UPower org.freedesktop.UPower.Hibernate") end),
    awful.key({ modkey,           }, "s",   function () awful.util.spawn_with_shell("( slock && xset dpms 0 0 300 ) & xset dpms 0 0 2; xset dpms force off") end),

    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({ modkey, "Shift"   }, "p", function () os.execute(shutdown) end),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    --awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),
    -- Change Prompt to Change keyboard layout.
    awful.key({ modkey },            "r",     function () kbdcfg.switch() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false} },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "Skype" },
      properties = { floating = true, tag = tags[1][2] } },
    { rule = { class = "Pidgin" },
      properties = { floating = true, tag = tags[1][2] } },
    { rule = { class = "org-gtdfree-GTDFree" },
      properties = { floating = true, tag = tags[1][8] } },
    { rule = { class = "com-cosylab-timespent-TimeSpentMain" },
      properties = { floating = true, tag = tags[1][8] } },
    { rule = { class = "Spotify" },
      properties = { tag = tags[1][9] } },
    { rule = { class = "Thunderbird" },
      properties = { tag = tags[1][1] } },
    { rule = { class = "Pavucontrol" },
      properties = { floating = true } },
    { rule = { class = "x2goclient" },
      properties = { floating = true } },
    { rule = { class = "Personal.bin" }, -- BankID
      properties = { floating = true } }
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Autostart
-- awful.util.spawn_with_shell("xrdb -merge $HOME/.Xresources")
-- awful.util.spawn_with_shell("run_once.sh /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1")
-- awful.util.spawn_with_shell("xfce4-power-manager")
-- awful.util.spawn_with_shell("eval `run_once.sh ssh-agent`")
-- awful.util.spawn_with_shell("run_once.sh pidgin")
-- awful.util.spawn_with_shell("run_once.sh thunderbird")
-- awful.util.spawn_with_shell("run_once.sh nm-applet")
-- awful.util.spawn_with_shell("pulseaudio -D")
-- awful.util.spawn_with_shell("autorandr --change")
-- awful.util.spawn_with_shell("run_once.sh xautolock -time 10 -locker 'slock'")
awful.util.spawn_with_shell("xset dpms 0 0 300")
