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
		local appExists = hs.application.launchOrFocus(app_name)
		if not appExists then
			hs.alert.show("Could not find app: " .. app_name)
		end
	end
end
