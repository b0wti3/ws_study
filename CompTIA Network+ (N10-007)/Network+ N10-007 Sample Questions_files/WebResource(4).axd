DataIntelligenceSubmitScript = {
    _settings: null, 
    _client: null,

    /* --------------------------------- set up and tear down ---------------------------- */

    load: function (settings) {
        if (typeof jQuery !== "undefined") {
            this._settings = settings;
            this._client = new sfDataIntell.Client({
                apiKey: settings.apiKey,
                source: settings.applicationName,
                apiServerUrl: settings.apiServerUrl,
                trackPageVisits: true,
                trackUtmParameters: true,
                instrument: true,
                trackReferrer: true
            });

            if (typeof CustomEvent == "function") {
                var evt = new CustomEvent('decclientready');
                document.dispatchEvent(evt);
            } else if (!document.createEvent) {    // If IE < 9 event won't be fired
                // DO NOTHING!
            } else {    // If CuntomEvent object is not supported (e.g. IE9) -> create polyfil
                // CustomEvent polyfil
                var CustomEvent = function(event, params) {
                    params = params || { bubbles: false, cancelable: false, detail: undefined };
                    var evt = document.createEvent('CustomEvent');
                    evt.initCustomEvent(event, params.bubbles, params.cancelable, params.detail);
                    return evt;
                };
                CustomEvent.prototype = window.Event.prototype;
                window.CustomEvent = CustomEvent;
                // CustomEvent polyfil - END

                var evt = new CustomEvent('decclientready', { bubbles: true, cancelable: true });
                document.dispatchEvent(evt);
            }
        }        
    }
}