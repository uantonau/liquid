using Toybox.Graphics;
using Toybox.Application;
using Toybox.Math;

class Battery {

	private var sinAB;
	private var cosAB;
	private var sinAM;
	private var cosAM;
	private var batteryLevel;
	
	private var bgColor = Application.getApp().getProperty("BackgroundColor");
   	private var handColor = Util.getHandColor(bgColor);
	private var accentColor = Application.getApp().getProperty("AccentColor");
	private var zzzSmall = Application.loadResource(Rez.Fonts.ZzzSmall);
	
   	private var hand = [[0,3],[-2,2],[-1,-10],[0,-11],[1,-10],[2,2]];
   	private var handCenter = [79, 28];
   	private var smallLabel = [0, 16];
   	private var tick = [[0,-15],[0,-18]];
   	private var arcRadius = 15;
	
	private var transformedHand;
	private var transformedHandCenter;
	
	function initialize(width, height) {
		hand = Util.normPts(hand, width, height);
		handCenter = Util.normPt(handCenter, width, height);
		smallLabel = Util.normPt(smallLabel, width, height);
		tick = Util.normPts(tick, width, height);
		arcRadius = Util.norm(arcRadius, width, height);
	}
	
	public function set(newBatteryLevel, angleMinute) {
		batteryLevel = newBatteryLevel;
		var batteryAngle = -batteryLevel.toFloat() / 100 * 2 * Math.PI;
		sinAB = Math.sin(batteryAngle);
   		cosAB = Math.cos(batteryAngle);
   		sinAM = Math.sin(angleMinute);
   		cosAM = Math.cos(angleMinute);
   		transformedHandCenter = Util.transformRound(handCenter, centerPoint[0], centerPoint[1], sinAM, cosAM);
   		transformedHand = Util.transformPolygonRound(hand, transformedHandCenter[0], transformedHandCenter[1], sinAB, cosAB);
	}

   	public function draw(dc) {
   	    drawLabels(dc);
    	dc.setColor(handColor, Graphics.COLOR_TRANSPARENT);
    	dc.fillPolygon(transformedHand);
   	}
   	
	public function drawLabels(dc) {
	   	var ang100 = 90;
		var ang75 = 90 + 360 * 0.75;
		var ang50 = 90 + 360 * 0.5;
	    var ang25 = 90 + 360 * 0.25;
	
    	drawArc(dc, handColor, 4, ang75+5, ang100-5, transformedHandCenter);
    	drawArc(dc, handColor, 3, ang50+5, ang75-5, transformedHandCenter);
    	drawArc(dc, handColor, 2, ang25+5, ang50-5, transformedHandCenter);
    	if (System.getClockTime().sec%2 == 0 ||  batteryLevel > 25) {
    		drawArc(dc, accentColor, 2, ang100+5, ang25-5, transformedHandCenter);
    	}
    }
    
    private function drawTick(dc, tickColor, tickWidth, sinA, cosA, ticksCenterPoint, tick) {
    	dc.setColor(tickColor, Graphics.COLOR_TRANSPARENT);
		dc.setPenWidth(tickWidth);
    	var transformedTick = Util.transformPolygon(tick, ticksCenterPoint[0], ticksCenterPoint[1], sinA, cosA);
    	Util.drawPolygon(dc, transformedTick);
    }
    
    private function drawArc(dc, arcColor, arcWidth, degreeStart, degreeEnd, arcCenterPoint) {
    	dc.setColor(arcColor, Graphics.COLOR_TRANSPARENT);
		dc.setPenWidth(arcWidth);
		dc.drawArc(arcCenterPoint[0], arcCenterPoint[1], arcRadius, Graphics.ARC_COUNTER_CLOCKWISE ,degreeStart, degreeEnd);
    }
   	
   	public static function refreshColors() {
   		accentColor = Application.getApp().getProperty("AccentColor");
   		bgColor = Application.getApp().getProperty("BackgroundColor");
   		handColor = Util.getHandColor(bgColor);
   	}
}