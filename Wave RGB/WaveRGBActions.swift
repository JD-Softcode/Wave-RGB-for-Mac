//
//  WaveRGBActions.swift
//  Wave RGB
//
//  Created by Jeff on 1/12/19.
//  Copyright © 2019 J∆•Softcode. All rights reserved.
//

import Foundation
import Cocoa

class WaveRGBActions: NSObject {
	
	let KeyboardBackgroundImageFilename = "keysBackground"
	var animationTimer: Timer? = nil
	var noSleep: NSObjectProtocol?
	
	var animationInterval = 1.0 / 15.0
	let theCircles: AnimatedCircleGroup = AnimatedCircleGroup()
	var drawCanvas: artCanvasView? = nil
	
	// these next five values set by LoadCanvasBackgroundImage
	var renderWidth = 0
	var renderHeight = 0
	var renderScaleHoriz = 0.0
	var renderScaleVert = 0.0
	var backingRenderScaleHoriz = 0.0
	var backingRenderScaleVert = 0.0
	
	let mult8bitToPercent = 100.0 / 255.0
	
	func startUp() -> String {
		if jLogiLedInit() {
			Thread.sleep(until: Date().addingTimeInterval(0.250)) //wait for LGS to wake up
			//loadPreferences()
			var vers1:Int32 = 0
			var vers2:Int32 = 0
			var vers3:Int32 = 0
			jLogiLedGetSdkVersion(&vers1, &vers2, &vers3)
			return "Connected to LGS version \(vers1).\(vers2).\(vers3)."
		} else {
			return "Failed to connect to LGS."
		}
	}
	
	func stopLGS() {
		appSleep(prevented: false)
		jLogiLedShutdown()
	}
	
	func appSleep(prevented arg: Bool) {
		if arg {
			if noSleep == nil {
			noSleep = ProcessInfo.processInfo.beginActivity(options: .idleSystemSleepDisabled, reason:"animating keyboard lights")
			}
		} else {
			if noSleep != nil {
				ProcessInfo.processInfo.endActivity(noSleep!)
				noSleep = nil
			}
		}
	}
	
	func loadCanvasBackgroundImage(for theCanvas: artCanvasView) {
		theCanvas.setBackground(withImage: KeyboardBackgroundImageFilename)
		let theImage = NSImage(named: KeyboardBackgroundImageFilename)
		renderWidth  = Int(theImage?.size.width ?? 274)
		renderHeight = Int(theImage?.size.height ?? 100)
		renderScaleHoriz = Double(renderWidth) / Double(designWidth)
		renderScaleVert  = Double(renderHeight) / Double(designHeight)
		backingRenderScaleHoriz = renderScaleHoriz * Double((NSScreen.main?.backingScaleFactor)!)
		backingRenderScaleVert  = renderScaleVert  * Double((NSScreen.main?.backingScaleFactor)!)
	}
	
	func loadPreferences(interface theUI: AppDelegate) {
		let appPrefs = UserDefaults.standard
		
		if !appPrefs.bool(forKey: "prefsInited") {
			initializeDefaults(appPrefs: appPrefs)
			appPrefs.set(true, forKey: "prefsInited")
		}
		
		// load the framerate from preferences and ready for display
		let frameRate = appPrefs.integer(forKey: "framerate")
		setAnimationInterval(secs: 1.0 / Double(frameRate))
		theUI.populateSettingsValues(ring: 0, settings: [frameRate])
		
		// load all 5 rings settings from preferences and ready for display
		var values = Array<Int>(repeating: 0, count: 11)
		for i in 1...5 {
			values[0] = appPrefs.integer(forKey: "ring\(i)active")
			values[1] = appPrefs.integer(forKey: "ring\(i)life")
			values[2] = appPrefs.integer(forKey: "ring\(i)delay")
			values[3] = appPrefs.integer(forKey: "ring\(i)sizeStart")
			values[4] = appPrefs.integer(forKey: "ring\(i)sizeEnd")
			values[5] = appPrefs.integer(forKey: "ring\(i)thickness")
			values[6] = appPrefs.integer(forKey: "ring\(i)vizStart")
			values[7] = appPrefs.integer(forKey: "ring\(i)vizEnd")
			values[8] = appPrefs.integer(forKey: "ring\(i)red")
			values[9] = appPrefs.integer(forKey: "ring\(i)green")
			values[10] = appPrefs.integer(forKey: "ring\(i)blue")
			theUI.populateSettingsValues(ring: i, settings: values)
			
			ringActive[i-1] = values[0] == 1 ? true : false
			ringLife[i-1] = Double(values[1])
			ringDelay[i-1] = Double(values[2])
			ringSizeStart[i-1] = Double(values[3])
			ringSizeEnd[i-1] = Double(values[4])
			ringThickness[i-1] = Double(values[5])
			ringOpacityStart[i-1] = Double(values[6])
			ringOpacityEnd[i-1] = Double(values[7])
			ringColor[i-1] = NSColor(red: CGFloat(values[8])/100, green: CGFloat(values[9])/100, blue: CGFloat(values[10])/100, alpha: 1.0)
		}
	}
	
	func savePreferences(interface theUI: AppDelegate) {
		let appPrefs = UserDefaults.standard
		appPrefs.set(theUI.getUserFramerate(), forKey: "framerate")
		for i in 1...5 {
			appPrefs.set(theUI.getUserValue(forRing: i, value: 0), forKey: "ring\(i)active")
			appPrefs.set(theUI.getUserValue(forRing: i, value: 1), forKey: "ring\(i)life")
			appPrefs.set(theUI.getUserValue(forRing: i, value: 2), forKey: "ring\(i)delay")
			appPrefs.set(theUI.getUserValue(forRing: i, value: 3), forKey: "ring\(i)sizeStart")
			appPrefs.set(theUI.getUserValue(forRing: i, value: 4), forKey: "ring\(i)sizeEnd")
			appPrefs.set(theUI.getUserValue(forRing: i, value: 5), forKey: "ring\(i)thickness")
			appPrefs.set(theUI.getUserValue(forRing: i, value: 6), forKey: "ring\(i)vizStart")
			appPrefs.set(theUI.getUserValue(forRing: i, value: 7), forKey: "ring\(i)vizEnd")
			appPrefs.set(theUI.getUserValue(forRing: i, value: 8), forKey: "ring\(i)red")
			appPrefs.set(theUI.getUserValue(forRing: i, value: 9), forKey: "ring\(i)green")
			appPrefs.set(theUI.getUserValue(forRing: i, value: 10), forKey: "ring\(i)blue")
		}
		loadPreferences(interface: theUI)	// now apply everything to the rings
	}
	
	
	func keyDown(whatKey theKey: Int) {
		//print("Key: \(theKey)")
		var origin = NSPoint(x: 0, y: 0)
		for i in 0...keysCount-1 {
			if keyLocations[i][key_MacCode] == theKey {
				origin.x = CGFloat(Double(keyLocations[i][key_X]) * renderScaleHoriz)
				origin.y = 100 - CGFloat(Double(keyLocations[i][key_Y]) * renderScaleVert)
				//print ("triggered by \(theKey) to draw at \(Int(origin.x)),\(Int(origin.y))")
				addNewAnimatedCircle(where: origin)
				break
			}
		}
	}
	
	func addNewAnimatedCircle(where loc: NSPoint) {
		for i in 0...maxRings-1 {
			if ringActive[i] {
				theCircles.add(circle: AnimatedCircle(buildOn: i,at: loc))
			}
		}
	}

	func initializeAnimation(for theCanvas: artCanvasView) {
		setAnimationInterval(secs: animationInterval)
		drawCanvas = theCanvas
		triggerSingleBackgroundUpdate(delay: animationInterval)
			// needed because v1.3 code to stop light updates with no circles meant the keyboard doesn't change on app start
	}
	
	func setAnimationInterval(secs newVal: Double) {
		animationInterval = newVal
		if animationTimer != nil {
			animationTimer?.invalidate()
		}
		animationTimer = Timer.scheduledTimer(timeInterval: animationInterval,
											  target: self,
											  selector: #selector(animationStep),
											  userInfo: nil,
											  repeats: true)
	}
	
	@objc func animationStep(_ timer: Timer) {
		theCircles.animate()
		drawCanvas?.display()
		if theCircles.theCirclesStore.count > 0 {
			updateKeyLights()		// to save processing cycles, only update key lights when changing.
		}
		//print("tick \(NSDate())")
	}
	
	func triggerSingleBackgroundUpdate(delay theDelay: Double) {
		Timer.scheduledTimer(timeInterval: theDelay,
							 target: self,
							 selector: #selector(updateKeyLights),
							 userInfo: nil,
							 repeats: false)
	}

	
	
	func drawAllCircles() {	//called within context of View:draw
		if theCircles.drawAll() {
			appSleep(prevented: true)	// if there are circles animating, don't let the app sleep
		} else {
			appSleep(prevented: false)
		}
	}
	
	func haltAnimation() {
		animationTimer?.invalidate()
	}
	
	@objc func updateKeyLights() {
		let rep = drawCanvas!.bitmapImageRepForCachingDisplay(in: drawCanvas!.bounds)!
		drawCanvas?.cacheDisplay(in: (drawCanvas?.bounds)!, to: rep)
		for i in 0...keysCount-1 {
			let keyLocationX = Int(Double(keyLocations[i][key_X]) * backingRenderScaleHoriz)
			let keyLocationY = Int(Double(keyLocations[i][key_Y]) * backingRenderScaleVert)
			let theColor = rep.colorAt(x: keyLocationX, y: keyLocationY)
			switch keyLocations[i][key_MacCode] {
			case specialLogiKey:
				jLogiLedSetLightingForKeyWithKeyName(KeyName(rawValue: UInt32(keyLocations[i][key_HIDcode])),
													 Int32((theColor?.redComponent)! * 100),
													 Int32((theColor?.greenComponent)! * 100),
													 Int32((theColor?.blueComponent)! * 100))
			case mediaKey:
				break	// media key lights on G910 are not controllable
			default:
				jLogiLedSetLightingForKeyWithHidCode(Int32(keyLocations[i][key_HIDcode]),
													 Int32((theColor?.redComponent)! * 100),
													 Int32((theColor?.greenComponent)! * 100),
													 Int32((theColor?.blueComponent)! * 100))
			}
		}
	}
	
	func initializeDefaults(appPrefs: UserDefaults) {
		appPrefs.set(30, forKey: "framerate")
		let defaultRings: [[Int]] = [ [1, 15, 0, 10, 100, 20, 100,  0, 100, 100,   0],
									  [1, 15, 0, 10, 100,  4, 100,  0, 100,   0,   0],
									  [0, 15, 0, 20, 200, 10, 100, 50,   0, 100,   0],
									  [0, 30, 0, 10, 100,  4, 100,  0,   0,   0, 100],
									  [1, 30, 0,  5,   5,  5, 100,  0, 100, 100, 100]	]
		for i in 1...5 {
			appPrefs.set(defaultRings[i-1][0], forKey: "ring\(i)active")
			appPrefs.set(defaultRings[i-1][1], forKey: "ring\(i)life")
			appPrefs.set(defaultRings[i-1][2], forKey: "ring\(i)delay")
			appPrefs.set(defaultRings[i-1][3], forKey: "ring\(i)sizeStart")
			appPrefs.set(defaultRings[i-1][4], forKey: "ring\(i)sizeEnd")
			appPrefs.set(defaultRings[i-1][5], forKey: "ring\(i)thickness")
			appPrefs.set(defaultRings[i-1][6], forKey: "ring\(i)vizStart")
			appPrefs.set(defaultRings[i-1][7], forKey: "ring\(i)vizEnd")
			appPrefs.set(defaultRings[i-1][8], forKey: "ring\(i)red")
			appPrefs.set(defaultRings[i-1][9], forKey: "ring\(i)green")
			appPrefs.set(defaultRings[i-1][10], forKey: "ring\(i)blue")
		}
	}
	

}

//extension String {
//	func withWcharString<T>(handler: (UnsafePointer<wchar_t>) -> T) -> T {
//		return self.withCString { handler(UnsafeRawPointer($0).assumingMemoryBound(to: Int32.self)) }
//	}
//}


