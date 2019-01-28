//
//  AnimatedCircleGroup.swift
//  Wave RGB
//
//  Created by Jeff on 1/12/19.
//  Copyright © 2019 J∆•Softcode. All rights reserved.
//

import Foundation
import Cocoa

class AnimatedCircleGroup {
	
	var theCirclesStore = Set<AnimatedCircle>()
	
	func add(circle newCircle: AnimatedCircle) {
		theCirclesStore.insert(newCircle)
	}
	
	func animate() {
		if (theCirclesStore.count > 0) {
			for circ in theCirclesStore {
				// trigger animation step for each circle and assess the result
				if (circ.animateCircle() == AnimatedCircle.AnimationResult.animationDone) {
					theCirclesStore.remove(circ)
				}
			}
		}
	}
	
	func drawAll() -> Bool {  //called within context of View:draw
		if theCirclesStore.count > 0 {
			for circ in theCirclesStore {
				circ.drawACircle()
			}
			return true
		} else {
			return false
		}
	}
	
}
