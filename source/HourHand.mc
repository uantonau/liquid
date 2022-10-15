using Toybox.Graphics;
using Toybox.Application;

class HourHand {
	private var sinAH;
	private var cosAH;
	private var sinAM;
	private var cosAM;
	
	private var bgColor = Application.getApp().getProperty("BackgroundColor");
   	private var handColor = Util.getHandColor(bgColor);
   	private var zzzSmall = Application.loadResource(Rez.Fonts.ZzzSmall);
	
   	private var hand = [[0,7],[-4,5],[-2,-40],[0,-42],[2,-40],[4,5]];
   	private var handCenter = [0, 45];
   	private var secondHandCenter = [60, -30];
   	private var secondHandTick = [[0,-30],[0,-36]];
   	private var smallLabel = [0, 50];
	
	private var transformedHand;
	private var transformedHandCenter;
	private var transformedSecondHandCenter;
	
	function initialize(width, height) {
		hand = Util.normPts(hand, width, height);
		handCenter = Util.normPt(handCenter, width, height);
		secondHandCenter = Util.normPt(secondHandCenter, width, height);
		secondHandTick = Util.normPts(secondHandTick, width, height);
		smallLabel = Util.normPt(smallLabel, width, height);
	}
	
	public function set(angleHour, angleMinute) {
		sinAH = Math.sin(angleHour);
   		cosAH = Math.cos(angleHour);
   		sinAM = Math.sin(angleMinute);
   		cosAM = Math.cos(angleMinute);
   		transformedHandCenter = Util.transformRound(handCenter, centerPoint[0], centerPoint[1], sinAM, cosAM);
   		transformedSecondHandCenter = Util.transformRound(secondHandCenter, centerPoint[0], centerPoint[1], sinAM, cosAM);
   		transformedHand = Util.transformPolygonRound(hand, transformedHandCenter[0], transformedHandCenter[1], sinAH, cosAH);
	}

   	public function draw(dc) {
    	dc.setColor(handColor, Graphics.COLOR_TRANSPARENT);
    	dc.fillPolygon(transformedHand);
   	}
   	
	public function drawLabels(dc) {
    	for (var i = 0; i < 12; i++) {
    		var ang = i.toFloat() / 12 * 2 * Math.PI + Math.PI;
    		
    		var sinA = Math.sin(ang);
    		var cosA = Math.cos(ang);
    		
            drawLabel(dc, i + "", zzzSmall, handColor, sinA, cosA, smallLabel);

    	}
    }
    
    public function drawSecondLabels(dc) {
    	for (var i = 0; i < 8; i++) {
    		var ang = i.toFloat() / 8 * 2 * Math.PI;
    		
    		var sinA = Math.sin(ang);
    		var cosA = Math.cos(ang);
    		
            drawTick(dc, handColor, sinA, cosA, transformedSecondHandCenter, secondHandTick);
    	}
    }
    
    private function drawTick(dc, tickColor, sinA, cosA, ticksCenterPoint, tick) {
    	dc.setColor(tickColor, Graphics.COLOR_TRANSPARENT);
		dc.setPenWidth(2);
    	var transformedTick = Util.transformPolygon(tick, ticksCenterPoint[0], ticksCenterPoint[1], sinA, cosA);
    	Util.drawPolygon(dc, transformedTick);
    }
    
    private function drawLabel(dc, label, font, color, sinA, cosA, point) {
		dc.setColor(color, Graphics.COLOR_TRANSPARENT);
		var fontHeight = Graphics.getFontHeight(font);
		var transformedPoint = Util.transform([point[0],point[1]], transformedHandCenter[0], transformedHandCenter[1] - fontHeight / 2, sinA, cosA);
		dc.drawText(transformedPoint[0], transformedPoint[1], font, label + "", Graphics.TEXT_JUSTIFY_CENTER);
    }
   	
   	public static function refreshColors() {
   	   	bgColor = Application.getApp().getProperty("BackgroundColor");
   	   	handColor = Util.getHandColor(bgColor);
   	}
}