mapping {
    map duplicate() onto 'detectedDuplicate'
    map corrupt() onto 'detectedCorruption'

    map firstInSession() onto 'firstInSession'
    map timestamp() onto 'timestamp'
    map clientTimestamp() onto 'clientTimestamp'
    map remoteHost() onto 'remoteHost'
    map referer() onto 'referer'

    def locationUri = parse location() to uri
    map location() onto 'location'
    map locationUri.scheme() onto 'locationScheme'
    map locationUri.host() onto 'locationHost'
    map locationUri.port() onto 'locationPort'
    map locationUri.path() onto 'locationPath'
    map locationUri.decodedQueryString() onto 'locationQuery'
    map locationUri.decodedFragment() onto 'locationFragment'

    map viewportPixelWidth() onto 'viewportPixelWidth'
    map viewportPixelHeight() onto 'viewportPixelHeight'
    map screenPixelWidth() onto 'screenPixelWidth'
    map screenPixelHeight() onto 'screenPixelHeight'
    map devicePixelRatio() onto 'devicePixelRatio'

    map partyId() onto 'partyId'
    map sessionId() onto 'sessionId'
    map pageViewId() onto 'pageViewId'
    map eventId() onto 'eventId'
    map eventType() onto 'eventType'

    map userAgentString() onto 'userAgent'
    def ua = userAgent()
    map ua.name() onto 'userAgentName'
    map ua.family() onto 'userAgentFamily'
    map ua.vendor() onto 'userAgentVendor'
    map ua.type() onto 'userAgentType'
    map ua.version() onto 'userAgentVersion'
    map ua.deviceCategory() onto 'userAgentDeviceCategory'
    map ua.osFamily() onto 'userAgentOsFamily'
    map ua.osVersion() onto 'userAgentOsVersion'
    map ua.osVendor() onto 'userAgentOsVendor'

    map eventParameters().value('clientIP') onto 'clientIP'

    def resourceUri = parse eventParameters().value('resourceName') to uri
    map eventParameters().value('resourceName') onto 'resourceName'
    map resourceUri.scheme() onto 'resourceScheme'
    map resourceUri.host() onto 'resourceHost'
    map resourceUri.port() onto 'resourcePort'
    map resourceUri.path() onto 'resourcePath'
    map resourceUri.decodedQueryString() onto 'resourceQuery'
    map resourceUri.decodedFragment() onto 'resourceFragment'
    map { parse eventParameters().value('resourceDuration') to double } onto 'resourceDuration'
    map { parse eventParameters().value('resourceTransferSize') to double } onto 'resourceTransferSize'

    map eventParameters().value('connectionType') onto 'connectionType'
    map { parse eventParameters().value('connectionDownlinkMax') to double } onto 'connectionDownlinkMax'
}
