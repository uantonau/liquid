using Toybox.Graphics;
using Toybox.Application;
using Toybox.WatchUi;

class Face {
	var bitmap;
	var size;
	var currentDay;
	
    var accentColor = Application.getApp().getProperty("AccentColor");
    var bgColor = Application.getApp().getProperty("BackgroundColor");
    var ticksColor = Util.getHandColor(bgColor);
	
	var mark = [[-4,-114],[-4,-118],[4,-118],[4,-114]];
	var smallLabel = [0, -113];
	var tick = [[0,-108],[0,-118]];
	var tickCircle = [0,-113];
	var bottomTriangle = [[110,225],[120,240],[130,225]];
	var bottomTriangleCircle = [120,230];
	var bottomTriangleCircleRad = 4;
	
    var zzzSmall = Application.loadResource(Rez.Fonts.ZzzSmall);
    
    function initialize(width, height) {
    	size = [width, height];
    	mark = Util.normPts(mark, width, height);
    	smallLabel = Util.normPt(smallLabel, width, height);
    	tick = Util.normPts(tick, width, height);
    	tickCircle = Util.normPt(tickCircle, width, height);
    	bottomTriangle = Util.normPts(bottomTriangle, width, height);
    	bottomTriangleCircle = Util.normPt(bottomTriangleCircle, width, height);
    	bottomTriangleCircleRad = Util.norm(bottomTriangleCircleRad, width, height);
    }
    
    function draw(dc) {
    	dc.setColor(bgColor,bgColor);
    	dc.clear();
        drawTicks(dc);
    }

	private function drawTicks(dc) {
    	for (var i = 0; i < 60; i++) {
    		var ang = i.toFloat() / 60 * 2 * Math.PI;
    		
    		var sinA = Math.sin(ang);
    		var cosA = Math.cos(ang);
    		
    		if ((i + 5) % 10 == 0) {
                drawLabel(dc, i + "", zzzSmall, ticksColor, sinA, cosA, smallLabel);
    		} else if ( i % 10 == 0) {
    			if (i == 0) {
    				drawTickCircle(dc, sinA, cosA, accentColor);
    			} else if (i == 30) {
    				dc.setColor(accentColor,bgColor);
    				dc.fillPolygon(bottomTriangle);
    				dc.setColor(bgColor,bgColor);
    				dc.fillCircle(bottomTriangleCircle[0], bottomTriangleCircle[1], bottomTriangleCircleRad);
    			} else {
    		    	drawTickCircle(dc, sinA, cosA, ticksColor);
    		    }
    		} else {
    			drawTick(dc, sinA, cosA);
    		}
    	}
    }
    
    private function drawLabel(dc, label, font, color, sinA, cosA, point) {
		dc.setColor(color, Graphics.COLOR_TRANSPARENT);
		var fontHeight = Graphics.getFontHeight(font);
		var transformedPoint = Util.transform([point[0],point[1]], centerPoint[0], centerPoint[1] - fontHeight / 2, sinA, cosA);
		dc.drawText(transformedPoint[0], transformedPoint[1], font, label + "", Graphics.TEXT_JUSTIFY_CENTER);
    }
    
    private function drawTick(dc, sinA, cosA) {
    	dc.setColor(ticksColor, Graphics.COLOR_TRANSPARENT);
		dc.setPenWidth(2);
    	var transformedTick = Util.transformPolygon(tick, centerPoint[0], centerPoint[1], sinA, cosA);
    	Util.drawPolygon(dc, transformedTick);
    }
    
    private function drawTickCircle(dc, sinA, cosA, circleColor) {
		dc.setColor(circleColor, Graphics.COLOR_TRANSPARENT);
		dc.setPenWidth(2);
    	var transformedTickCircle = Util.transform(tickCircle, centerPoint[0], centerPoint[1], sinA, cosA);
    	dc.drawCircle(transformedTickCircle[0], transformedTickCircle[1], 5);
    }
    
    function getAsBitmap() {
    	if (bitmap == null) {
    		bitmap = new Graphics.BufferedBitmap({
                :width=>size[0],
                :height=>size[1],
                :palette=> [
					bgColor,
					ticksColor,
					accentColor
		        ]
            });
            draw(bitmap.getDc());
    	} else if (currentDay != Util.getCurrentDay()) {
    		draw(bitmap.getDc());
    	}
    	return bitmap;
    }
    
    public function refreshColors() {
    	accentColor = Application.getApp().getProperty("AccentColor");
    	bgColor = Application.getApp().getProperty("BackgroundColor");
    	ticksColor = Util.getHandColor(bgColor);

    	bitmap.setPalette([
			bgColor,
			ticksColor,
			accentColor
	    ]);
		draw(bitmap.getDc());
    }
}