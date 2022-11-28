-- Lightroom SDK
local LrBinding = import 'LrBinding'
local LrDialogs = import 'LrDialogs'
local LrFileUtils = import 'LrFileUtils'
local LrPathUtils = import 'LrPathUtils'
local LrView = import 'LrView'

-- Common shortcuts
local bind = LrView.bind
local share = LrView.share

require 'MastodonPublishSupport'

-------------------------

local exportServiceProvider = {}

for name, value in pairs( MastodonPublishSupport ) do
	exportServiceProvider[ name ] = value
end

-- Available in export and publish
exportServiceProvider.supportsIncrementalPublish = true

-- Default values
exportServiceProvider.exportPresetFields = {
	{ key = 'server_url', default = "" },
	{ key = 'access_token', default = '' },

	{ key = 'tag_keywords', default = false },
	{ key = 'tag_users', default = false },
	{ key = 'ignored_keywords', default = '' },
	{ key = 'user_mapping', default = '' },
}

-- Hide output "exportLocation"
exportServiceProvider.hideSections = { 'exportLocation' }

-- Allowed formats (can be JPEG, PSD, TIFF, DNG, ORIGINAL)
exportServiceProvider.allowFileFormats = { 'JPEG' }

-- Allowed color spaces (can be sRGB, AdobeRGB, ProPhotoRGB)
exportServiceProvider.allowColorSpaces = { 'sRGB' }

-- Disable Print Resolution controls (reccomended for web-services)
exportServiceProvider.hidePrintResolution = true

-- Video is not supported (TODO: yet)
exportServiceProvider.canExportVideo = false

function exportServiceProvider.startDialog( propertyTable )
    -- If its new, set default values
    if not propertyTable.LR_editingExistingPublishConnection then
        propertyTable.instance_url = nil
        propertyTable.access_token = nil
    end
end

function exportServiceProvider.sectionsForTopOfDialog( f, propertyTable )
    return {
        {
            title = LOC "$$$/Mastodon/ExportDialog/Account=Mastodon Bot Account",
            synopsis = bind 'loginStatus',

            f:row {
                spacing = f:control_spacing(),

                f:static_text {
                    title = bind 'loginStatus',
                    alignment = 'right',
                    fill_horizontal = 1
                },

                f:push_button {
                    width = tonumber(LOC "$$$/locale_metric/Mastodon/ExportDialog/LoginButton/Width=90"),
                    title = bind 'loginButtonTitle',
                    enabled = bind 'loginButtonEnabled',
                    action = function()
                        require 'MastodonUser'
                        MastodonUser.login(propertyTable)
                    end,
                },
            },
        },
        {
            title = LOC "$$$/Mastodon/ExportDialog/Title=Mastodon Post",
            synopsis = 'test synopsis',
            f:column {
                spacing = f:control_spacing(),

                f:row {
                    spacing = f:label_spacing(),

                    f:checkbox {
                        title = LOC "$$$/Mastodon/ExportDialog/Add Caption=Add Caption to post",
                        value = true
                    },
                },

                f:row {
                    spacing = f:label_spacing(),

                    f:checkbox {
                        title = LOC "$$$/Mastodon/ExportDialog/Add Keywords=Add Keywords to post",
                        value = bind 'tag_keywords'
                    },

                    f:static_text {
                        title = LOC "$$$/Mastodon/ExportDialog/Ignore Keywords=Keywords to ignore:",
                        enabled = LrBinding.keyEquals('tag_keywords', true, propertyTable)
                    },

                    f:edit_field {
                        fill_horizontal = 1,
                        width_in_chars = 30,
                        value = bind 'ignored_keywords',
                        enabled = LrBinding.keyEquals('tag_keywords', true, propertyTable)
                    }
                },

                f:row {
                    spacing = f:label_spacing(),

                    f:checkbox {
                        title = LOC "$$$/Mastodon/ExportDialog/Add Ats=Add Ats to post",
                        value = bind 'tag_users'
                    },

                    f:static_text {
                        title = LOC "$$$/Mastodon/ExportDialog/User Map=User Mappings:",
                        enabled = LrBinding.keyEquals('tag_users', true, propertyTable)
                    },

                    f:edit_field {
                        fill_horizontal = 1,
                        width_in_chars = 30,
                        value = bind 'user_mapping',
                        enabled = LrBinding.keyEquals('tag_users', true, propertyTable)
                    },
                },
            },
        }
    }
end

return exportServiceProvider