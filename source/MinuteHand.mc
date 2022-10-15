using Toybox.Graphics;
using Toybox.Application;

class MinuteHand {
	private var sinA;
	private var cosA;
	private var scp;  
	
	private var bgColor = Application.getApp().getProperty("BackgroundColor");
   	private var handColor = Util.getHandColor(bgColor);
  	private var hand = [[-2,-20],[-4,-23],[-2,-98],[-1,-103],[1,-103],[2,-98],[4,-23],[2,-20]];
	
	private var transformedHand;
	
	function initialize(width, height) {
		hand = Util.normPts(hand, width, height);
	}
	
	public function set(angle) {
		sinA = Math.sin(angle);
   		cosA = Math.cos(angle);
   		transformedHand = Util.transformPolygonRound(hand, centerPoint[0], centerPoint[1], sinA, cosA);
	}

   	public function draw(dc) {
    	dc.setColor(handColor, Graphics.COLOR_TRANSPARENT);
    	dc.fillPolygon(transformedHand);
   	}
   	
   	public static function refreshColors() {
   	   	bgColor = Application.getApp().getProperty("BackgroundColor");
   	   	handColor = Util.getHandColor(bgColor);
   	}
}