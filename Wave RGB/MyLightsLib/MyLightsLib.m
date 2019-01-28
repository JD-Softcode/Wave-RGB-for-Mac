//
//  MyLightsLib.m
//  MyLightsLib
//
//  Created by Jeff on 11/20/15.
//  Copyright (c) 2015 J∆•Softcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <LogitechLED/LogitechLED.h>
#include <LogitechLED/LogitechLEDSDK.h>


bool jLogiLedInit() {
	return LogiLedInit();
}

bool jLogiLedGetSdkVersion(int *majorNum, int *minorNum, int *buildNum) {
	return LogiLedGetSdkVersion(majorNum, minorNum, buildNum);
}

bool jLogiLedSetTargetDevice(int targetDevice) {
	return LogiLedSetTargetDevice(targetDevice);
}

bool jLogiLedSaveCurrentLighting() {
	return LogiLedSaveCurrentLighting();
}

bool jLogiLedSetLighting(int redPercentage, int greenPercentage, int bluePercentage) {
	return LogiLedSetLighting(redPercentage, greenPercentage, bluePercentage);
}

bool jLogiLedRestoreLighting() {
	return LogiLedRestoreLighting();
}

bool jLogiLedFlashLighting(int redPercentage, int greenPercentage, int bluePercentage, int milliSecondsDuration, int milliSecondsInterval) {
	return LogiLedFlashLighting(redPercentage, greenPercentage, bluePercentage, milliSecondsDuration, milliSecondsInterval);
}

bool jLogiLedPulseLighting(int redPercentage, int greenPercentage, int bluePercentage, int milliSecondsDuration, int milliSecondsInterval) {
	return LogiLedPulseLighting(redPercentage, greenPercentage, bluePercentage, milliSecondsDuration, milliSecondsInterval);
}

bool jLogiLedStopEffects() {
	return LogiLedStopEffects();
}

bool jLogiLedSetLightingFromBitmap(UInt8* bitmap) {
	return LogiLedSetLightingFromBitmap(bitmap);
}

bool jLogiLedSetLightingForKeyWithScanCode(int keyCode, int redPercentage, int greenPercentage, int bluePercentage) {
	return LogiLedSetLightingForKeyWithScanCode(keyCode, redPercentage, greenPercentage, bluePercentage);
}

bool jLogiLedSetLightingForKeyWithHidCode(int keyCode, int redPercentage, int greenPercentage, int bluePercentage) {
	return LogiLedSetLightingForKeyWithHidCode(keyCode, redPercentage, greenPercentage, bluePercentage);
}

bool jLogiLedSetLightingForKeyWithQuartzCode(int keyCode, int redPercentage, int greenPercentage, int bluePercentage) {
	return LogiLedSetLightingForKeyWithQuartzCode(keyCode, redPercentage, greenPercentage, bluePercentage);
}

bool jLogiLedSetLightingForKeyWithKeyName(enum KeyName keyName, int redPercentage, int greenPercentage, int bluePercentage) {
	return LogiLedSetLightingForKeyWithKeyName(keyName, redPercentage, greenPercentage, bluePercentage);
}

bool jLogiLedSaveLightingForKey(enum KeyName keyName) {
	return LogiLedSaveLightingForKey(keyName);
}

bool jLogiLedRestoreLightingForKey(enum KeyName keyName) {
	return LogiLedRestoreLightingForKey(keyName);
}

bool jLogiLedExcludeKeysFromBitmap(enum KeyName *keyList, int listCount) {	// new in 8.87
	return LogiLedExcludeKeysFromBitmap(keyList, listCount);
}

bool jLogiLedFlashSingleKey(enum KeyName keyName, int redPercent, int greenPercent, int bluePercent,
							int msDuration, int msInterval) {
	return LogiLedFlashSingleKey(keyName, redPercent, greenPercent, bluePercent, msDuration, msInterval);
}

bool jLogiLedPulseSingleKey(enum KeyName keyName, int startRedPercent, int startGreenPercent, int startBluePercent,
							int finishRedPercent, int finishGreenPercent, int finishBluePercent,
							int msDuration, bool isInfinite) {
	return LogiLedPulseSingleKey(keyName, startRedPercent, startGreenPercent, startBluePercent, finishRedPercent, finishGreenPercent, finishBluePercent, msDuration, isInfinite);
}

bool jLogiLedStopEffectsOnKey(enum KeyName keyName) {
	return LogiLedStopEffectsOnKey(keyName);
}

bool jLogiLedGetConfigOptionNumber(const wchar_t *configPath, double *defaultValue) {	// new in 8.87
	return LogiLedGetConfigOptionNumber(configPath, defaultValue);
}

bool jLogiLedGetConfigOptionBool(const wchar_t *configPath, bool *defaultValue) {	// new in 8.87
	return LogiLedGetConfigOptionBool(configPath, defaultValue);
}

bool jLogiLedGetConfigOptionColor(const wchar_t *configPath, int *defaultRed, int *defaultGreen, int *defaultBlue) {	// new in 8.87
	return LogiLedGetConfigOptionColor(configPath, defaultRed, defaultGreen, defaultBlue);
}
								  
bool jLogiLedGetConfigOptionKeyInput(const wchar_t *configPath, wchar_t *defaultValue, int bufferSize) {	// new in 8.87
	return LogiLedGetConfigOptionKeyInput(configPath, defaultValue, bufferSize);
}

bool jLogiLedSetConfigOptionLabel(const wchar_t *configPath, wchar_t *label) {	// new in 8.87
	return LogiLedSetConfigOptionLabel(configPath, label);
}

void jLogiLedShutdown() {
	return LogiLedShutdown();
}
