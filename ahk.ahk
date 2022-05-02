SetTitleMatchMode, 2

; This function opens all my support tickets in separate tabs, since the
; portal design doesn't allow for middle-clicking links:
populate_support_tickets()
{
    Run "C:\Users\cyphercon.skid\place\Desktop\ticket_builder.py"
    WinWait, C:\Windows\py.exe
    WinMove, 0, 0
    WinMove, 0, 0
}

; Function to call Mouse wiggler:
autopilot()
{
    Run "C:\Users\cyphercon.skid\place\Desktop\automation_test.py"
    WinWait, C:\Windows\py.exe
    WinMove, 0, 0
    WinMove, 0, 0
}

; This function takes a program in question and makes it active if inactive and
; vice versa
toggle_app(app, location)
{
    if WinExist(app)
    {
        if !WinActive(app)
        {
            WinActivate
        }
        else
        {
            WinMinimize
        }
    }
    else if location != ""
    {
        Run, %location%
    }
}

; I think this one maximizes apps, but I think it runs via relative
; arguments, not concrete application locations.  Pay attention to how this
; gets used with F8: Super handy for dismissing outlook reminders!
max_app(app)
{
    if WinExist(app)
    {
        if !WinActive(app)
        {
            WinActivate
        }
        else
        {
            WinMinimize
        }
    }
}

; Wherever I type "pdpd", it replaces it with cyphercon.skid@email.com
:?*:pdpd::cyphercon.skid@email.com

; Wherever I type "ubub", it replaces it with my downloads folder
:?*:ubub::/mnt/c/Users/cyphercon.skid/Downloads/

; I don't use these on my current system, but they were handy for typing
; matching parens, braces, etc. and moving the carat within.
;:?*:()::(){left}
;:?*:[]::[]{left}
;:?*:""::""{left}
;:?*:''::''{left}


; Typing "datedd" types out today's current date like this "12/22/2022"
:?*:datedd::
FormatTime, CurrentDateTime,, MM/dd/yy
SendInput %CurrentDateTime%
return

; Typing "dateff" types out today's date like this:  "12_22_2022" - useful for
; filename prefixes
:?*:dateff::
FormatTime, CurrentDateTime,, MM_dd_yy
SendInput %CurrentDateTime%
return

; Types yesterday's date - great for airflow tasks testing
:?*:dateyy::
today = %a_now%
today += -1, days
FormatTime, today, %today%, MM/dd/yy
SendInput %today%
return

; Very specific vim search/replace for UTF-8 style space character
:?*:visvis::%s/\xa0/ /g{enter}

; Ctrl + q bounces autohotkey file for refreshed performance.
^q:: ; press control+q to reload
Reload
return

; Sets coordinate reference relative to window in question:
CoordMode, Mouse, Window

; Pause/Break key opens new file in notepad++ or composes new email in outlook,
; if on the home window.  First macro I ever made, but surprisingly still
; useful.
Pause::Click 25,70

; ^F1 = "Ctrl + F1" - opens MS Teams
^F1::toggle_app("Microsoft Teams [QSP]", "C:\Users\cyphercon_skid\AppData\Local\Microsoft\Teams\current\Teams.exe")

; Opens Outlook
^F2::max_app("Outlook")

; Kicks off mouse wiggler
^F3::autopilot()

; I run this via new keyboard now, but this was useful.  YMMV
;^F4 = Alt + F4

^F5::max_app("Visual Studio Code")

; Specific Purpose:  Builds/sets appointments in outlook
^F6::Click 50,260

; Something really oblique with outlook - can't remember.
^F7::Click 460,92

; Maximizes outlook reminders:
;  alt + j = open teams meeting
;  alt + d = dismisses currently-highlighted appointment
;  alt + a = dismisses all appointment reminders
^F8::max_app("Reminder(s)")


^F9::toggle_app("Notepad++", "C:\Program Files (x86)\Notepad++\notepad++.exe")
^F10::populate_support_tickets()

; Loads WSL2 instance of Ubuntu terminal
F9::max_app("Ubuntu-18.04")
F10::max_app("Google Chrome")
