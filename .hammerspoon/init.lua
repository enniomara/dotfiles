hs.allowAppleScript(true)

function ToggleApplication(app_name)
  local app = hs.application.find(app_name)
  if app ~= nil then
    if app:isFrontmost() then
      app:hide()
    else
      app:activate()
    end
  else
    hs.application.open(app_name)
  end
end
