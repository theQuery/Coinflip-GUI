#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
#NoTrayIcon ; Disables the tray icon.
#SingleInstance, Ignore ; Disables the ability to run multiple scripts.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir, %A_ScriptDir% ; Ensures a consistent starting directory.

if WinExist("ahk_exe Discord.exe")
    WinActivate

Gui, Font, s10, Verdana

Gui, Add, Text, y20 x15, Bet Amount:
Gui, Add, Edit, Number Limit10 h20
Gui, Add, UpDown, Range0-2147483647 vAmount, 2000

Gui, Add, Text, y+20, Currency Type:
Gui, Add, Radio, vCurrency, Skulls
Gui, Add, Radio, x+5, Bones

Gui, Font, Bold
Gui, Add, Button, Default y+25 x17 w80 h40 vBet, Bet
Gui, Add, Button, Disabled x+5 w60 h40 vStop, Stop

Gui, Font
Image = %A_Temp%/coinfliptwo.png
FileInstall, Assets/coinfliptwo.png, %Image%, 1
Gui, Add, Picture, y10 x+22, %Image%
Gui, Add, Text, y+10 w100, • Have Discord open behind this window.`n• Press Bet to start auto-coinflipping.`n• Press Stop to stop auto-coinflipping.

Gui, Color, F7DAFA
Gui, +AlwaysOnTop
Gui, Show, w300 h210, Coinflip GUI
return

ButtonBet:
    Gui, Submit

    if (Currency = 1) {
        MaxBet := 10000
        Currency := "Skulls"
        Letter := "s"
    } else if (Currency = 2) {
        MaxBet := 2000
        Currency := "Bones"
        Letter := "b"
    } else {
        MsgBox,, Bet Denied, You need to choose either Skulls or Bones as the currency type.
        Gui, Show
        return
    }

    if (Amount > 0 and Amount <= MaxBet) {
        GuiControl, Disable, Bet
        GuiControl, Enable, Stop
        Gui, Show, NoActivate
        Coinflip := 1

        while (Coinflip) {
            SendInput .cf %Amount% %Letter%
            SendInput {Enter}
            Sleep 3300
        }
    } else {
        MsgBox,, Bet Denied, Your bet needs to be an amount between 1 and %MaxBet% %Currency%.
    }
    Gui, Show
return

ButtonStop:
    Coinflip := 0
    GuiControl, Disable, Stop
    GuiControl, Enable, Bet
return

GuiClose:
ExitApp