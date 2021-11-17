-- https://github.com/ashfinal/awesome-hammerspoon/blob/master/init.lua


hsreload_keys = hsreload_keys or {{"cmd", "shift", "ctrl"}, "R"}


hs.loadSpoon("ModalMgr")

-- 定义默认加载的 Spoons
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

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "t", function()
  spoon.AClock:toggleShow()
end)
