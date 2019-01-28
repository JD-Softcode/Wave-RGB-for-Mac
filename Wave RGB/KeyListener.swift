//
//  KeyListener.swift
//  Wave RGB
//
//  Created by Jeff on 1/12/19.
//  Copyright © 2019 J∆•Softcode. All rights reserved.
//

import Foundation
import Cocoa

class KeyListener {
	
	var theApp: WaveRGBActions? = nil
	
	var monitor1: Any?
	var monitor2: Any?
	var monitor3: Any?
	var monitor4: Any?
	var monitor5: Any?

	func startUp(callbackTo cbt: WaveRGBActions) -> Bool {
		
		// listen for main keys in the background
		monitor1 = NSEvent.addGlobalMonitorForEvents(matching: [.keyDown], handler: self.doKeyDown)
		// listen for modifier keys in the background
		monitor4 = NSEvent.addGlobalMonitorForEvents(matching: [.flagsChanged], handler: self.doModKeyDown)
		
		// listen for media keys in all cases
		monitor2 = NSEvent.addGlobalMonitorForEvents(matching: [.systemDefined], handler: self.doMediaKeyDown)
		
		// listen for main keys in the foreground to allow playing around (Global doesn't provide)
		monitor3 = NSEvent.addLocalMonitorForEvents(matching: [.keyDown])
		{ event in
			self.doKeyDown(evt: event)
			return event
		}
		
		// listen for modifier keys in the foreground to allow playing around (Global doesn't provide)
		monitor5 = NSEvent.addLocalMonitorForEvents(matching: [.flagsChanged])
		{ event in
			self.doModKeyDown(evt: event)
			return event
		}
		
		theApp = cbt
		return AXIsProcessTrusted()
	}
	
	
	func doMediaKeyDown(evt: NSEvent) {
		let keyCode = ((evt.data1 & 0xFFFF0000)>>16)
		let keyState = (((evt.data1 & 0x0000FF00) >> 8)) == 0xA	//down
		let keyRepeat = (evt.data1 & 0x1) > 0
		if keyState && !keyRepeat {
			theApp?.keyDown(whatKey: keyCode + mediaKey)
		}
	}
	
	
	func doKeyDown(evt: NSEvent) {
		//print ("key \(evt.keyCode)")
		if !evt.isARepeat {
			theApp?.keyDown(whatKey: Int(evt.keyCode) )
		}
	}
	
	
	func doModKeyDown(evt: NSEvent) {
		let key = evt.keyCode
		//print ("key \(key)")
		let momentaryModKeyFlags: NSEvent.ModifierFlags = [.command, .control, .option, .shift]
		let isCapsLock = (key == 57)

		if !evt.modifierFlags.isDisjoint(with: momentaryModKeyFlags) || isCapsLock {
			//If the mod key flags are consistent with what mod keys are being held down (or is Caps Lock), we want to show the animation.
			//  If the flags don't match (disjoint), it means the mod key was released and we don't want to show that.
			//  This isn't perfect because it assumes only 1 modifier key is pressed. If 2+ are down, you will see animation upon key up.
			theApp?.keyDown(whatKey: Int(key) )
		}
	}

	
	func stop() {
		NSEvent.removeMonitor(monitor1!)
		NSEvent.removeMonitor(monitor2!)
		NSEvent.removeMonitor(monitor3!)
		NSEvent.removeMonitor(monitor4!)
		NSEvent.removeMonitor(monitor5!)
	}

}
