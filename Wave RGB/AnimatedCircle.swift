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
			let diameter = abs (radius * 2)
					// some shrinking circles create negative radius on last frame, and NSBezierPath/lineWidth will complain
			let circPath = NSBezierPath(ovalIn: NSRect(x: Double(center.x) - radius,
													   y: Double(center.y) - radius,
													   width: diameter,
													   height: diameter))
			circPath.lineWidth = CGFloat(thickness <= diameter ? thickness : diameter)
				//must limit stroke width to 2x radius to prevent hole in center due to drawing's destructive overlap
			// if need to reduce rendering cycles, introduce:  circPath.flatness = 20   // bigger = rougher
			color.withAlphaComponent(CGFloat(opacity/100.0)).setStroke()
			circPath.stroke()		// note that stroke straddles the path with a given thickness, does not keep inside it
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

