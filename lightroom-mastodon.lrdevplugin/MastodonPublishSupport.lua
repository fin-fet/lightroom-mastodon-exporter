local LrDialogs = import 'LrDialogs'

local publishServiceProvider = {}

publishServiceProvider.small_icon = 'small_mastodon.png'

publishServiceProvider.publish_fallbackNameBinding = 'fullname'

publishServiceProvider.titleForPublishedCollection = LOC "$$$/Mastodon/TitleForPublishedCollection=Post"
publishServiceProvider.titleForPublishedCollection_standalone = LOC "$$$/Mastodon/TitleForPublishedCollection/Standalone=Post"
--publishServiceProvider.titleForGoToPublishedCollection = LOC "$$$/Mastodon/TitleForGoToPublishedCollection=Show on Mastodon"
publishServiceProvider.titleForGoToPublishedPhoto = LOC "$$$/Mastodon/TitleForGoToPublishedCollection=Show on Mastodon"

-------

MastodonPublishSupport = publishServiceProvider