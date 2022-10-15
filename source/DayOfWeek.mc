using Toybox.Graphics;
using Toybox.Application;

class DayOfWeek {
	private var sinADW;
	private var cosADW;
	private var sinAM;
	private var cosAM;
	
	private var bgColor = Application.getApp().getProperty("BackgroundColor");
   	private var handColor = Util.getHandColor(bgColor);
	private var accentColor = Application.getApp().getProperty("AccentColor");
	private var zzzSmall = Application.loadResource(Rez.Fonts.ZzzSmall);
	
   	private var hand = [[0,6],[-3,4],[-1,-21],[0,-23],[1,-21],[3,4]];
   	private var handCenter = [-60, -30];
   	private var smallLabel = [0, 33];
   	private var tick = [[0,-30],[0,-36]];
   	private var arcRadius = 30;
	
	private var transformedHand;
	private var transformedHandCenter;
	
	function initialize(width, height) {
		hand = Util.normPts(hand, width, height);
		handCenter = Util.normPt(handCenter, width, height);
		smallLabel = Util.normPt(smallLabel, width, height);
		tick = Util.normPts(tick, width, height);
		arcRadius = Util.norm(arcRadius, width, height);
	}
	
	public function set(angleDayOfWeek, angleMinute) {
		sinADW = Math.sin(angleDayOfWeek);
   		cosADW = Math.cos(angleDayOfWeek);
   		sinAM = Math.sin(angleMinute);
   		cosAM = Math.cos(angleMinute);
   		transformedHandCenter = Util.transformRound(handCenter, centerPoint[0], centerPoint[1], sinAM, cosAM);
   		transformedHand = Util.transformPolygonRound(hand, transformedHandCenter[0], transformedHandCenter[1], sinADW, cosADW);
	}

   	public function draw(dc) {
   	    drawLabels(dc);
    	dc.setColor(handColor, Graphics.COLOR_TRANSPARENT);
    	dc.fillPolygon(transformedHand);
   	}
   	
	public function drawLabels(dc) {
    	for (var i = 0; i < 7; i++) {
    		var angStart = i.toFloat() / 7 * 360 + 90 + 10;
    		var angEnd = angStart + 360 / 7 - 10;
    		
    		if( i >= 2 ) {
   				drawArc(dc, handColor, 2, angStart, angEnd, transformedHandCenter);
   			} else {
   				drawArc(dc, accentColor, 6, angStart, angEnd, transformedHandCenter);
   				drawArc(dc, bgColor, 2, angStart+5, angEnd-5, transformedHandCenter);
   			}
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