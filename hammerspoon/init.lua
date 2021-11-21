-- https://github.com/ashfinal/awesome-hammerspoon/blob/master/init.lua





hsreload_keys = hsreload_keys or {{"cmd", "shift", "ctrl"}, "R"}
if string.len(hsreload_keys[2]) > 0 then
    hs.hotkey.bind(hsreload_keys[1], hsreload_keys[2], "Reload Configuration", function() hs.reload() end)
end

-- ModalMgr Spoon must be loaded explicitly, because this repository heavily relies upon it.
hs.loadSpoon("ModalMgr")

if not hspoon_list then
    hspoon_list = {
        "AClock",
      --  "ClipShow", -- 剪切板
      --  "KSheet", -- 快捷键
      --  "CountDown", -- 倒计时
      --  "WinWin", -- 窗口管理
      --  "SpeedMenu", -- 菜单栏显示网速
        "HSearch"
    }
end

-- 加载 Spoons
for _, v in pairs(hspoon_list) do
    hs.loadSpoon(v)
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.alert.show("Hello World!")
end)

----------------------------------------------------------------------------------------------------
-- Register AClock
if spoon.AClock then
    hsaclock_keys = hsaclock_keys or {"alt", "T"}
    if string.len(hsaclock_keys[2]) > 0 then
        spoon.ModalMgr.supervisor:bind(hsaclock_keys[1], hsaclock_keys[2], "Toggle Floating Clock",
          function() spoon.AClock:toggleShow() end)
    end
end

--hs.hotkey.bind({"cmd", "alt", "ctrl"}, "t", function()
--  spoon.AClock:toggleShow()
--end)

----------------------------------------------------------------------------------------------------
-- Finally we initialize ModalMgr supervisor
spoon.ModalMgr.supervisor:enter()
