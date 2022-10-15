using Toybox.Application;
using Toybox.WatchUi;

class LiquidApp extends Application.AppBase {
var view;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
    	view = new LiquidAppFaceView();
    	if( Toybox.WatchUi has :WatchFaceDelegate ) {
            return [view, new LiquidAppFaceDelegate()];
        } else {
            return [view];
        }
    }
    
    // New app settings have been received so trigger a UI update
    function onSettingsChanged() {
    	view.refreshColors();
        WatchUi.requestUpdate();
    }

}