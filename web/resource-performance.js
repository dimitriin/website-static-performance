function getClientIP() {
    let xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", "https://www.cloudflare.com/cdn-cgi/trace", false );
    xmlHttp.send( null );
    return xmlHttp.responseText.split("\n").filter(el => el.startsWith("ip"))[0].split("=")[1]
}

window.addEventListener('load', function () {
    let clientIP = getClientIP()

    performance.getEntriesByType("resource").forEach(resource => {
        if (resource.initiatorType === 'img') {
            divolte.signal("resourceLoaded", {
                "clientIP": clientIP,
                "resourceName": resource.name,
                "resourceDuration": resource.duration,
                "resourceTransferSize": resource.transferSize,
                "connectionType": navigator.connection.effectiveType,
                "connectionDownlinkMax": navigator.connection.downlink,
            });
        }
    });
})