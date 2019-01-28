//
//  RingPrefs.swift
//  Wave RGB
//
//  Created by Jeff on 1/12/19.
//  Copyright © 2019 J∆•Softcode. All rights reserved.
//

import Foundation
import Cocoa

let appVersionString = "v1.2.1"

let maxRings = 5

//changing these Strings will localize the interface shown by LGS.

let ringName = "Ring"

var ringRenderFPS = 30.0
let renderFPSName = "Frame Rate"

// these default values will be returned / retained by LGS
// Mac version cannot use the Logitech Config Prefs system; the defaults really appear at end of WaveRGBActions.swift
var ringActive       = [Bool]   ([ true, true, false, false, true] )
var ringLife         = [Double] ([ 15, 15, 15, 30, 30]) //in frames
var ringDelay        = [Double] ([ 0, 0, 0, 0, 0 ])      //in frames
var ringSizeStart    = [Double] ([ 10, 10, 20, 10, 3 ]) //in render pixels
var ringSizeEnd      = [Double] ([100, 100, 200, 100, 3 ])
var ringColor        = [NSColor]([ NSColor.yellow, NSColor.red, NSColor.green, NSColor.blue, NSColor.white])
var ringThickness    = [Double] ([ 20, 4, 10, 4, 6 ])      //in render pixels
var ringOpacityStart = [Double] ([ 100, 100, 100, 100, 100 ])    //in %
var ringOpacityEnd   = [Double] ([ 0, 0, 50, 0, 0 ])             //in %

let activeName = "Active";
let lifeName = "Lifetime";
let delayName = "Render Delay";
let sizeStartName = "Starting Radius";
let sizeEndName = "Ending Radius";
let colorName = "Color";
let thicknessName = "Thickness";
let opacityStartName = "Starting Visibility %";
let opacityEndName = "Ending Visibility %";

