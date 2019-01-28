//
//  AnimatedCircle.swift
//  Wave RGB
//
//  Created by Jeff on 1/12/19.
//  Copyright © 2019 J∆•Softcode. All rights reserved.
//

import Foundation
import Cocoa

class AnimatedCircle: Hashable {
	
	//these next functions are required to make this class Hashable i.e. usable as a Set
	static func == (lhs: AnimatedCircle, rhs: AnimatedCircle) -> Bool {
		return lhs.uniqueID == rhs.uniqueID
	}
	var hashValue: Int {
		return uniqueID
	}
	
	static private var nextID = 0
	
	// every animated circle has these attributes:
	var radius: 	Double
	var radiusStep: Double
	var center: 	NSPoint
	var opacity: 	Double
	var opacityStep:Double
	var thickness: 	Double
	var color: 		NSColor
	var endLife: 	Double
	var currentLife:Double
	var birthDelay: Double
	var uniqueID: 	Int
	
	enum AnimationResult
	{
		case nothing
		case animationRunning
		case animationDone
		case animationHidden
	}
	
	init(buildOn source: Int, at doWhere: NSPoint) {  // constructor method
		radius 		= ringSizeStart[source]
		radiusStep 	= (ringSizeEnd[source] - ringSizeStart[source]) / ringLife[source]
		center 		= doWhere
		opacity 	= ringOpacityStart[source]
		opacityStep = (ringOpacityEnd[source] - ringOpacityStart[source]) / ringLife[source]
		thickness 	= ringThickness[source]
		color 		= ringColor[source]
		endLife 	= ringLife[source]
		currentLife = 0
		birthDelay 	= ringDelay[source]
		
		AnimatedCircle.nextID += 1
		uniqueID 	= AnimatedCircle.nextID
	}
	
	func drawACircle() {  //called within context of View:draw
		if currentLife > birthDelay {
			let circPath = NSBezierPath(ovalIn: NSRect(x: Double(center.x) - radius,
													   y: Double(center.y) - radius,
													   width: radius * 2,
													   height: radius * 2))
			circPath.lineWidth = CGFloat(thickness)
			color.withAlphaComponent(CGFloat(opacity/100.0)).setStroke()
			circPath.stroke()
		}
	}
	
	func animateCircle() -> AnimationResult {
		var result: AnimationResult = .animationRunning;
		if (currentLife > (endLife + birthDelay)) {
			result = .animationDone
		} else if (currentLife > birthDelay) {
			radius += radiusStep
			opacity += opacityStep
		//} else {
		//    result =  .animationHidden;   Not currently used
		}
		currentLife += 1
		return result
	}
}

