//
//  AppDelegate.swift
//  Wave RGB
//
//  Created by Jeff on 1/12/19.
//  Copyright © 2019 J∆•Softcode. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!
	@IBOutlet weak var settingsWindow: NSWindow!
	@IBOutlet weak var permissionSheet: NSWindow!
	@IBOutlet weak var statusTextField: NSTextField!
	@IBOutlet weak var bottomInfoTextField: NSTextField!
	@IBOutlet weak var artCanvas: artCanvasView!
	
	@IBOutlet weak var ring1settingsView: NSView!
	@IBOutlet weak var ring2settingsView: NSView!
	@IBOutlet weak var ring3settingsView: NSView!
	@IBOutlet weak var ring4settingsView: NSView!
	@IBOutlet weak var ring5settingsView: NSView!
	
	
	let activeTag 		= 1
	let lifeTag 		= 10
	let delayTag 		= 11
	let radiusStartTag 	= 12
	let radiusEndTag 	= 13
	let colorTag 		= 2
	let thickTag 		= 14
	let vizStartTag 	= 15
	let vizEndTag 		= 16
	let stepper🔼		= 10
	let framerateTag 	= 100
	
	let theApp = WaveRGBActions()
	let theListener = KeyListener()
	
	@IBAction func resyncPrefsBtn(_ sender: NSButton) {
		theApp.loadPreferences(interface: self)
		settingsWindow.setIsVisible(true)
	}
	
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		statusTextField.stringValue = theApp.startUp()
		if !theListener.startUp(callbackTo: theApp) {
			window.beginSheet(permissionSheet, completionHandler: nil)
		}
		bottomInfoTextField.stringValue = appVersionString + " " + bottomInfoTextField.stringValue
		theApp.loadCanvasBackgroundImage(for: artCanvas)
		artCanvas.setCallback(target: self)
		theApp.initializeAnimation(for: artCanvas)
		theApp.loadPreferences(interface: self)
	}
	
	@IBAction func closePermSheet(_ sender: NSButton) {
		window.endSheet(permissionSheet)
	}
	
	
	func clickInCanvas(where loc: NSPoint) {	//called by artCanvasView
		theApp.addNewAnimatedCircle(where: loc)
	}
	
	func drawOverlay() {		//called by artCanvasView
		theApp.drawAllCircles()
	}

	func populateSettingsValues(ring theRing:Int, settings valueArray:[Int]) {
		if theRing == 0 {
			let topControls = settingsWindow.contentView?.subviews
			for control in topControls! {
				if control.tag == framerateTag {
					(control as! NSTextField).stringValue = String(valueArray[0])
					stepperWithTag(search: topControls!, forTag: framerateTag + stepper🔼).intValue = Int32(valueArray[0])
				}
			}
		} else {
			let viewsArray: [NSView] = [ring1settingsView, ring2settingsView, ring3settingsView, ring4settingsView, ring5settingsView]
			let theControls = viewsArray[theRing-1].subviews
			
			func setPrefCell(tag: Int, tField: NSView, value: Int) {
				(tField as! NSTextField).stringValue = String(value)
				stepperWithTag(search: theControls, forTag: tag + stepper🔼).intValue = Int32(value)
			}
			
			for control in theControls {
				switch control.tag {
				case activeTag:
					(control as! NSButton).state = valueArray[0] == 1 ? .on : .off
				case lifeTag:
					setPrefCell(tag: lifeTag, 		 tField: control, value: valueArray[1])
				case delayTag:
					setPrefCell(tag: delayTag, 		 tField: control, value: valueArray[2])
				case radiusStartTag:
					setPrefCell(tag: radiusStartTag, tField: control, value: valueArray[3])
				case radiusEndTag:
					setPrefCell(tag: radiusEndTag, 	 tField: control, value: valueArray[4])
				case thickTag:
					setPrefCell(tag: thickTag, 		 tField: control, value: valueArray[5])
				case vizStartTag:
					setPrefCell(tag: vizStartTag, 	 tField: control, value: valueArray[6])
				case vizEndTag:
					setPrefCell(tag: vizEndTag, 	 tField: control, value: valueArray[7])
				case colorTag:
					(control as! NSColorWell).color = NSColor(red: CGFloat(valueArray[8])/100, green: CGFloat(valueArray[9])/100, blue: CGFloat(valueArray[10])/100, alpha: 1.0)
				default:  // a label or stepper
					break
				}
			}
		}
	}
	
	
	func stepperWithTag(search theControls: [NSView], forTag theTag: Int) -> NSStepper {
		// this is a search routine to return the Stepper matching the given tag# from an array of subviews
		var result = NSStepper()
		for control in theControls {
			if control.tag == theTag && control.isKind(of: NSStepper.self){
				result = control as! NSStepper
			}
		}
		return result
	}
	
	@IBAction func textChanged(_ sender: NSTextField) {
		// keeps the stepper internal value the same as the text view next to it. Called on when enter is pressed
		// note the associated NSFormatter prevents non-numeric or out-of-bounds values from getting this far
		let theControls = sender.superview!.subviews
		stepperWithTag(search: theControls, forTag: sender.tag + stepper🔼).intValue = sender.intValue
		// assumes there is always a stepper associated with each textfield
	}
	
	
	@IBAction func savePrefsButton(_ sender: NSButton) {
		theApp.savePreferences(interface: self)
		settingsWindow.setIsVisible(false)
	}
	
	func getUserFramerate() -> Int {
		var result: Int = 30
		let theControls = settingsWindow.contentView?.subviews
		for control in theControls! {
			if control.tag == framerateTag {
				result = Int((control as! NSTextField).stringValue) ?? 30
			}
		}
		return result
	}
	
	func getUserValue(forRing ring: Int, value index: Int) -> Int {
		var result: Int = 11
		let viewsArray: [NSView] = [ring1settingsView, ring2settingsView, ring3settingsView, ring4settingsView, ring5settingsView]
		let theControls = viewsArray[ring-1].subviews
		for control in theControls {
			if control.tag == activeTag && index == 0 {
				result = (control as! NSButton).state == .on ? 1 : 0
			}
			else if control.tag == lifeTag && index == 1 {
				result = Int((control as! NSTextField).stringValue) ?? 15
			}
			else if control.tag == delayTag && index == 2 {
				result = Int((control as! NSTextField).stringValue) ?? 0
			}
			else if control.tag == radiusStartTag && index == 3 {
				result = Int((control as! NSTextField).stringValue) ?? 10
			}
			else if control.tag == radiusEndTag && index == 4 {
				result = Int((control as! NSTextField).stringValue) ?? 100
			}
			else if control.tag == thickTag && index == 5 {
				result = Int((control as! NSTextField).stringValue) ?? 10
			}
			else if control.tag == vizStartTag && index == 6 {
				result = Int((control as! NSTextField).stringValue) ?? 100
			}
			else if control.tag == vizEndTag && index == 7 {
				result = Int((control as! NSTextField).stringValue) ?? 0
			}
			else if control.tag == colorTag {
				if index == 8 {
					result = Int(100 * (control as! NSColorWell).color.redComponent)
				}
				else if index == 9 {
					result = Int(100 * (control as! NSColorWell).color.greenComponent)
				}
				else if index == 10 {
					result = Int(100 * (control as! NSColorWell).color.blueComponent)
				}
			}
			//if result != 11 {break}
		}
		return result
	}
	
	
	@IBAction func cancelPrefsButton(_ sender: NSButton) {
		settingsWindow.setIsVisible(false)
	}
	
	func grabSettingsValues(ring theRing:Int, settings valueArray:inout [Int]) {
		if theRing == 0 {
			let topControls = settingsWindow.contentView?.subviews
			for control in topControls! {
				if control.tag == framerateTag {
					valueArray[0] = Int((control as! NSTextField).stringValue) ?? 15
				}
			}
		} else {
			let viewsArray: [NSView] = [ring1settingsView, ring2settingsView, ring3settingsView, ring4settingsView, ring5settingsView]
			let theControls = viewsArray[theRing-1].subviews
			for control in theControls {
				switch control.tag {
				case activeTag:
					valueArray[0] = (control as! NSButton).state == .on ? 1 : 0
				case lifeTag:
					valueArray[1] = Int((control as! NSTextField).stringValue) ?? 15
				case delayTag:
					valueArray[2] = Int((control as! NSTextField).stringValue) ?? 0
				case radiusStartTag:
					valueArray[3] = Int((control as! NSTextField).stringValue) ?? 10
				case radiusEndTag:
					valueArray[4] = Int((control as! NSTextField).stringValue) ?? 100
				case thickTag:
					valueArray[5] = Int((control as! NSTextField).stringValue) ?? 10
				case vizStartTag:
					valueArray[6] = Int((control as! NSTextField).stringValue) ?? 100
				case vizEndTag:
					valueArray[7] = Int((control as! NSTextField).stringValue) ?? 0
				case colorTag:
					let userColor = (control as! NSColorWell).color
					valueArray[ 8] = Int(100 * userColor.redComponent)
					valueArray[ 9] = Int(100 * userColor.greenComponent)
					valueArray[10] = Int(100 * userColor.blueComponent)
				default:  // a label or stepper
					break
				}
			}
		}
	}
	

	func applicationWillTerminate(_ aNotification: Notification) {
		theListener.stop()
		theApp.haltAnimation()
		theApp.stopLGS()
	}

	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		return true
	}

}

