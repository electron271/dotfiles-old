-- vim: syntax=haskell foldmarker={{{,}}} foldmethod=marker

-- Imports {{{
import XMonad
import Data.Text.Encoding (encodeUtf8BuilderEscaped)

-- Utils
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Loggers
import XMonad.Util.Ungrab
import XMonad.Util.SpawnOnce

-- Layouts
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier

-- Hooks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import Retrie.Pretty (ColoriseFun)

-- Actions
import XMonad.Actions.DynamicWorkspaces


-- Colors
      -- Possible choices are:
      -- DoomOne
      -- Dracula
      -- GruvboxDark
      -- MonokaiPro
      -- Nord
      -- OceanicNext
      -- Palenight
      -- SolarizedDark
      -- SolarizedLight
      -- TomorrowNight

import Colors.GruvboxDark

-- }}}

-- Layout Hook {{{
myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol 
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes
-- }}}

-- Xmobar PP {{{
myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = gray " | "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Bottom" color07 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor color14 ""
    blue     = xmobarColor color13 ""
    white    = xmobarColor colorFore ""
    yellow   = xmobarColor color04 ""
    red      = xmobarColor color01 ""
    lowWhite = xmobarColor color08 ""
    gray     = xmobarColor color09 ""

-- }}}

-- Main {{{
main :: IO ()
main = xmonad 
     . ewmhFullscreen 
     . ewmh 
     . withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)) toggleStrutsKey
     $ myConfig
  where
    toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
    toggleStrutsKey XConfig{ modMask = m } = (m, xK_b)

-- }}}

-- Startup Hook {{{
myStartupHook :: X ()
myStartupHook = do
      spawn "killall trayer"
      
      spawnOnce "nitrogen --restore &"
      spawnOnce "picom &"

      spawn ("sleep 2 && trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 --tint 0x232443 --height 22")
 
-- }}}

-- Config {{{
myTerminal = "kitty"    -- Sets terminal to kitty, but you can use any terminal you want
myModMask = mod4Mask    -- Sets modkey to super/windows key
myBorderWidth = 3       -- Sets border width for windows
myWorkspaces = ["www","dev","chat","mus","misc"]  -- Sets workspaces
myNormalBorderColor  = colorFore
myFocusedBorderColor = color14

myConfig = def
    { modMask = myModMask
    , terminal = myTerminal
    , layoutHook = myLayout
    , manageHook = myManageHook
    , startupHook = myStartupHook
    , normalBorderColor = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , borderWidth = myBorderWidth
    , workspaces = myWorkspaces
    }
    `additionalKeysP`
    [ ("M-S-z", spawn "xscreensaver-command -lock")
    , ("M-C-s", unGrab *> spawn "scrot -s"        )
    , ("M-f"  , spawn "firefox"                   )
    , ("M-p"  , spawn "rofi -show drun"           )
    , ("M-S-p", spawn "rofi -show run"            )
    , ("M-o"  , spawn "rofi -show window"         )
    , ("M-i"  , spawn "rofi -modi emoji -show emoji"          )
    , ("<XF86AudioMute>", spawn "pamixer -t"      )
    , ("<XF86AudioLowerVolume>", spawn "pamixer -d 5")
    , ("<XF86AudioRaiseVolume>", spawn "pamixer -i 5")
    , ("<XF86AudioPlay>", spawn "playerctl play-pause")
    , ("<XF86AudioNext>", spawn "playerctl next")
    , ("<XF86AudioPrev>", spawn "playerctl previous")
    ]
-- }}}

-- Manage Hook {{{
myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Gimp" --> doFloat
    , isDialog            --> doFloat
    ]

