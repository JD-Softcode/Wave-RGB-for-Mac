//
//  artCanvasView.swift
//  Wave RGB
//
//  Created by Jeff on 1/12/19.
//  Copyright © 2019 J∆•Softcode. All rights reserved.
//

import Foundation
import Cocoa

class artCanvasView: NSView {
	
	var backgroundImage = NSImage()
	var callback: AppDelegate? = nil
	
	func setCallback(target input: AppDelegate) {
		callback = input
	}
	
	override func draw(_ dirtyRect: NSRect) {
		backgroundImage.draw(in: dirtyRect, from: NSZeroRect, operation: .copy, fraction: 1.0)
		callback?.drawOverlay()
	}
	
	override func mouseDown(with event: NSEvent) {
		let canvasOrigin = convert(self.bounds.origin, to: self.superview)
		let clickLocation = event.locationInWindow.applying(CGAffineTransform(translationX: -canvasOrigin.x, y: -canvasOrigin.y))
		callback?.clickInCanvas(where: clickLocation)
	}
	
	func setBackground(withImage image: String) {
		let myFilePath = Bundle.main.path(forResource: image, ofType: "png")
		if (myFilePath != nil) {
			backgroundImage = NSImage(contentsOfFile: myFilePath!)!
		} else {
			backgroundImage = NSImage(named: NSImage.cautionName)!
		}
	}
	
}
