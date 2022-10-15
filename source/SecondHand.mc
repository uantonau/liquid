using Toybox.Graphics;
using Toybox.Application;

class SecondHand {
	private var sinAS;
	private var cosAS;
	private var sinAM;
	private var cosAM;
	
	private var bgColor = Application.getApp().getProperty("BackgroundColor");
   	private var handColor = Util.getHandColor(bgColor);
	private var zzzSmall = Application.loadResource(Rez.Fonts.ZzzSmall);
	private var accentColor = Application.getApp().getProperty("AccentColor"); 
	
   	private var hand = [[0,6],[-3,4],[-1,-21],[0,-23],[1,-21],[3,4]];
   	private var handBox = [[-5,23],[-5,-23],[5,-23],[5,23]];
   	private var handTip = [0,15];
   	private var handTipRadius = 3;
   	private var handCenter = [60, -30];
   	private var smallLabel = [0, 30];
	
	private var transformedHand;
	private var transformedHandBox;
	private var transformedHandCenter;
	private var transformedHandTip;
	
	function initialize(width, height) {
		hand = Util.normPts(hand, width, height);
		handBox = Util.normPts(handBox, width, height);
		handTip = Util.normPt(handTip, width, height);
		handTipRadius = Util.norm(handTipRadius, width, height);
		handCenter = Util.normPt(handCenter, width, height);
		smallLabel = Util.normPt(smallLabel, width, height);	
	}
	
	public function set(angleSecond, angleMinute) {
		sinAS = Math.sin(angleSecond);
   		cosAS = Math.cos(angleSecond);
   		sinAM = Math.sin(angleMinute);
   		cosAM = Math.cos(angleMinute);
   		transformedHandCenter = Util.transformRound(handCenter, centerPoint[0], centerPoint[1], sinAM, cosAM);
   		transformedHand = Util.transformPolygonRound(hand, transformedHandCenter[0], transformedHandCenter[1], sinAS, cosAS);
   		transformedHandBox = Util.transformPolygonRound(handBox, transformedHandCenter[0], transformedHandCenter[1], sinAS, cosAS);
   		transformedHandTip = Util.transformRound(handTip, transformedHandCenter[0], transformedHandCenter[1], sinAS, cosAS);
	}

   	public function draw(dc) {
    	dc.setColor(handColor, Graphics.COLOR_TRANSPARENT);
    	dc.fillPolygon(transformedHand);
    	dc.setColor(accentColor, Graphics.COLOR_TRANSPARENT);
    	dc.fillCircle(transformedHandTip[0], transformedHandTip[1], handTipRadius);
   	}
    
    public function getBox() {
    	return transformedHandBox;
    }
   	
   	public static function refreshColors() {
   		accentColor = Application.getApp().getProperty("AccentColor");
   		bgColor = Application.getApp().getProperty("BackgroundColor");
   		handColor = Util.getHandColor(bgColor);
   	}
}