local hyper = { "cmd", "alt", "ctrl", "shift" }

hs.window.animationDuration=0

hs.hotkey.bind(hyper, "0", function()
    hs.reload()
    local note = hs.notify.new({title="Hammerspoon", informativeText="Config loaded"})
    local note = note:send()
    note:withdrawAfter(1)
end)


hs.hotkey.bind(hyper, "h", function()
    local win = hs.window.focusedWindow();
    if not win then return end
    win:moveToUnit(hs.layout.left50)
end)

hs.hotkey.bind(hyper, "j", function()
    local win = hs.window.focusedWindow();
    if not win then return end
    win:moveToUnit(hs.layout.maximized)
end)

hs.hotkey.bind(hyper, "k", function()
    local win = hs.window.focusedWindow();
    if not win then return end
    win:moveToScreen(win:screen():next())
end)

hs.hotkey.bind(hyper, "l", function()
    local win = hs.window.focusedWindow();
    if not win then return end
    win:moveToUnit(hs.layout.right50)
end)

hs.hotkey.bind(hyper, "q", function()
    local win = hs.window.focusedWindow();
    if not win then return end
    local app = win:application()
    if app:name() == "Google Chrome" then 
        win:close() 
        return
    end
    if not app then return end
    app:kill()
end)

-- shortcuts for apps
local applicationHotkeys = {
    c = "Google Chrome",
    RETURN = "iTerm",
    t = "Thunderbird",
    s = "Slack",
    SPACE = "IntelliJ IDEA",
    i = "Insomnia"
}

for key, app in pairs(applicationHotkeys) do
    hs.hotkey.bind(hyper, key, function()
        -- hs.application.launchOrFocus(app)
        cycleAppWindows(app)
    end)
end

-- minimize focused window
hs.hotkey.bind(hyper, "M", function()
    win = hs.window.focusedWindow()
    win:minimize()
end)

--minimize all windows
hs.hotkey.bind(hyper, "a", function()
    wins = hs.window.visibleWindows()
    for _,win in pairs(wins) do
        win:minimize()
    end
end)

-- toggle fullscreen for focused window
hs.hotkey.bind(hyper, "f", function()
    win = hs.window.focusedWindow()
    if(win:isFullscreen()) then
        win:setFullScreen(false)
    else
        win:setFullScreen(true)
    end
end)


-- focus foremost window
hs.hotkey.bind(hyper, "y", function()
    win = hs.window.frontmostWindow()
    win:focus()
end)


-- cycle through screens
hs.hotkey.bind(hyper, "n", function()
    focusScreen(hs.window.focusedWindow():screen():next())
end)

function isInScreen(screen, win)
    return win:screen() == screen
end

function focusScreen(screen)
    local win = hs.fnutils.filter(
        hs.window.orderedWindows(),
        hs.fnutils.partial(isInScreen, screen))
    local winToFocus = #win > 0 and win[1] or hs.window.desktop()
    winToFocus:focus()

    -- move mouse cursor to center of screen
    --local mid = hs.geometry.rectMidPoint(screen:fullFrame())
    local mid = hs.geometry.new(screen:fullFrame()).center
    hs.mouse.setAbsolutePosition(mid)
end

-- TODO: get toggling to work correctly for more than 2 windows
function cycleAppWindows(app)
    f = hs.window.filter
    f = f.new(false)
    f:setAppFilter(app, {})

    -- check if app is already open, open otherwise
    wins = f:getWindows(hs.window.filter.sortByFocused)
    if next(wins) == nil or tableSize(wins) == 1 then
        hs.application.launchOrFocus(app)
    else
        win = wins[1]
        if win:screen() ~= hs.screen.primaryScreen() then
            win:moveToScreen(hs.screen.primaryScreen())
        end
        win:focus()
    end
end

function tableSize(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end
