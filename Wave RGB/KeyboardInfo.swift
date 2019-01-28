//
//  KeyboardInfo.swift
//  Wave RGB
//
//  Created by Jeff on 1/12/19.
//  Copyright © 2019 J∆•Softcode. All rights reserved.
//

import Foundation

let designWidth = 963;   // size of the original pixelmap the coordinates below are based upon
let designHeight = 352;

let key_HIDcode = 0;
let key_MacCode = 1;
let key_X = 2;
let key_Y = 3;

let specialLogiKey = 999;
let mediaKey = 0xace;

let row1 = 57;
let row2 = 107;
let row3 = 145;
let row4 = 185;
let row5 = 224;
let row6 = 263;

let keyLocations = [[Int]] ([
	//HID_code, WindowsKeyCode, x, y of key center
	[0x29,53,80, row1],//esc
	[0x3A,122,146,row1],//f1
	[0x3B,120,185,row1],//f2
	[0x3C,99,222,row1],//f3
	[0x3D,118,256,row1],//f4
	[0x3E,96,330,row1],//f5
	[0x3F,97,370,row1],//f6
	[0x40,98,408,row1],//f7
	[0x41,99,447,row1],//f8  GUESS
	[0x42,101,512,row1],//f9
	[0x43,109,552,row1],//f10
	[0x44,103,591,row1],//f11
	[0x45,104,631,row1],//f12  GUESS
	[0x46,105,683,row1],//print screen
	[0x47,106,722,row1],//scroll lock  GUESS
	[0x48,107,761,row1],//pause     GUESS
	
	[0x35,50,80,row2],//~
	[0x1E,18,120,row2],//1
	[0x1F,19,159,row2],//2
	[0x20,20,198,row2],//3
	[0x21,21,238,row2],//4
	[0x22,23,276,row2],//5
	[0x23,22,316,row2],//6
	[0x24,26,355,row2],//7
	[0x25,28,396,row2],//8
	[0x26,25,434,row2],//9
	[0x27,29,474,row2],//0
	[0x2D,27,512,row2],//-
	[0x2E,24,552,row2],//=
	[0x2A,51,610,row2],//<-
	[0x49,114,683,row2],//INS
	[0x4A,115,722,row2],//HOME
	[0x4B,116,761,row2],//PAGEUP
	[0x53,71,815,row2],//NUMLOCK
	[0x54,75,854,row2],// /
	[0x55,67,893,row2],// *
	[0x56,78,933,row2],//-
	
	[0x2B,48,90,row3],//Tab
	[0x14,12,139,row3],//q
	[0x1A,13,179,row3],//w
	[0x08,14,218,row3],//e
	[0x15,15,257,row3],//r
	[0x17,17,297,row3],//t
	[0x1C,16,337,row3],//y
	[0x18,32,375,row3],//u
	[0x0C,34,415,row3],//i
	[0x12,31,454,row3],//o
	[0x13,35,492,row3],//p
	[0x2F,33,532,row3],//[
	[0x30,30,571,row3],//]
	[0x31,42,620,row3],// \
	[0x4C,117,684,row3],//Del
	[0x4D,119,721,row3],//End
	[0x4E,121,762,row3],//PageD
	[0x5F,89,815,row3],//7
	[0x60,91,854,row3],//8
	[0x61,92,893,row3],//9
	[0x57,69,933,167],//+
	
	[0x39,57,90,row4],//Caps
	[0x04,0,149,row4],//a
	[0x16,1,190,row4],//s
	[0x07,2,227,row4],//d
	[0x09,3,268,row4],//f
	[0x0A,5,306,row4],//g
	[0x0B,4,346,row4],//h
	[0x0D,38,385,row4],//j
	[0x0E,40,424,row4],//k
	[0x0F,37,463,row4],//l
	[0x33,41,502,row4],//;
	[0x34,39,542,row4],//'
	//[0x??,???,582,row4],//     European extra key
	[0x28,36,606,row4],//enter
	[0x5C,86,815,row4],//4
	[0x5D,87,854,row4],//5
	//[0x5D,12,854,row4],//keypad 5 w/o NUM LOCK on Windows
	[0x5E,88,893,row4],//6
	
	[0xE1,56,107,row5],//LShift
	//[0x??,???,130,row5],//     European extra key
	[0x1D,6,170,row5],//z
	[0x1B,7,208,row5],//x
	[0x06,8,248,row5],//c
	[0x19,9,287,row5],//v
	[0x05,11,326,row5],//b
	[0x11,45,366,row5],//n
	[0x10,46,405,row5],//m
	[0x36,43,444,row5],//,
	[0x37,47,483,row5],//.
	[0x38,44,522,row5],// /
	[0xE5,60,597,row5],//RShift
	[0x52,126,721,row5],//up
	[0x59,83,815,row5],//1
	[0x5A,84,854,row5],//2
	[0x5B,85,893,row5],//3
	[0x58,76,933,245],//kp_enter
	
	[0xE0,59,90,row6],//Lctrl
	[0xE3,58,147,row6],//Lwin
	[0xE2,55,194,row6],//Lalt
	[0x2C,49,332,row6],//space
	[0xE6,54,468,row6],//Ralt
	[0xE7,61,517,row6],//Rwin
	[0x65,110,566,row6],//context
	[0xE4,62,618,row6],//Rctrl
	[0x50,123,684,row6],//left
	[0x51,125,721,row6],//down
	[0x4F,124,762,row6],//right
	[0x62,82,833,row6],//0
	[0x63,65,893,row6],//.
	
	[0xFFFF1,specialLogiKey,32,row1],//"G"     Windows does not detect these keys but included here for lighting
	[0xFFFF2,specialLogiKey,226,331],//"G910"
	[0xFFF1,specialLogiKey,32,row2],//g1
	[0xFFF2,specialLogiKey,32,row3],//g2
	[0xFFF3,specialLogiKey,32,row4],//g3
	[0xFFF4,specialLogiKey,32,row5],//g4
	[0xFFF5,specialLogiKey,32,row6],//g5
	[0xFFF6,specialLogiKey,146,20],//g6
	[0xFFF7,specialLogiKey,185,20],//g7
	[0xFFF8,specialLogiKey,222,20],//g8
	[0xFFF9,specialLogiKey,256,20],//g9
	
	[mediaKey,00+mediaKey,893,row1],//media   Windows sends codes when media keys pressed but no logitech API to change media key light colors
	[mediaKey,01+mediaKey,893,row1],//media            These x,y coordinates make lights eminate from above the keypad
	[mediaKey,07+mediaKey,893,row1],//media
	[mediaKey,16+mediaKey,893,row1],//media
	[mediaKey,18+mediaKey,893,row1],//media
	[mediaKey,17+mediaKey,893,row1],//media
])

let keysCount = keyLocations.count

