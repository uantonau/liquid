using Toybox.Graphics;
using Toybox.Application;

class DayOfMonth {
	private var sinA;
	private var cosA;
	
	private var accentColor = Application.getApp().getProperty("AccentColor");
	private var bgColor = Application.getApp().getProperty("BackgroundColor");
  	private var hand = [[0,120],[-8,106],[8,106]];
  	private var handShadow = [[0,122],[-9,105],[9,105]];
	
	private var transformedHand;
	private var transformedHandShadow;
	
	function initialize(width, height) {
		hand = Util.normPts(hand, width, height);
		handShadow = Util.normPts(handShadow, width, height);
	}
	
	public function set(angle) {
		sinA = Math.sin(angle);
   		cosA = Math.cos(angle);
   		transformedHand = Util.transformPolygonRound(hand, centerPoint[0], centerPoint[1], sinA, cosA);
   		transformedHandShadow = Util.transformPolygonRound(handShadow, centerPoint[0], centerPoint[1], sinA, cosA);
	}

   	public function draw(dc) {
   		dc.setColor(bgColor, Graphics.COLOR_TRANSPARENT);
   		dc.fillPolygon(transformedHandShadow);
    	dc.setColor(accentColor, Graphics.COLOR_TRANSPARENT);
    	Util.drawPolygon(dc, transformedHand);
   	}
   	
   	public static function refreshColors() {
   		accentColor = Application.getApp().getProperty("AccentColor");
   		bgColor = Application.getApp().getProperty("BackgroundColor");
   	}
}