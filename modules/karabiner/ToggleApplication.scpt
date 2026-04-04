on run argv
set appName to (item 1 of argv)
tell application "Hammerspoon" to execute lua code "ToggleApplication(\"" & appName & "\")"
end run
