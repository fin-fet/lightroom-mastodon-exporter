return {
    LrSdkVersion = 3.0,
	LrSdkMinimumVersion = 3.0,

	LrToolkitIdentifier = 'net.finfet.exporters.mastodon',
	LrPluginName = LOC "$$$/Mastodon/PluginName=Mastodon",
	
	LrExportServiceProvider = {
		title = LOC "$$$/Mastodon/Mastodon-title=Mastodon",
		file = 'MastodonExportServiceProvider.lua',
	},
	
	--LrMetadataProvider = 'MastodonMetadataDefinition.lua',

	VERSION = { major=1, minor=0, revision=0, },
}