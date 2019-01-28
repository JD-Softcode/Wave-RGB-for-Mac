//
//  MyLightsLib.h
//  MyLightsLib
//
//  Created by Jeff on 11/20/15.
//  Copyright (c) 2015 J∆•Softcode. All rights reserved.
//

#ifndef MyLightsLib_MyLightsLib_h
#define MyLightsLib_MyLightsLib_h

#import <Foundation/Foundation.h>

#include "commonLED.h"


bool jLogiLedInit();
bool jLogiLedGetSdkVersion(int *majorNum, int *minorNum, int *buildNum);

bool jLogiLedSetTargetDevice(int targetDevice);

bool jLogiLedSaveCurrentLighting();
bool jLogiLedSetLighting(int redPercentage, int greenPercentage, int bluePercentage);
bool jLogiLedRestoreLighting();
bool jLogiLedFlashLighting(int redPercentage, int greenPercentage, int bluePercentage, int milliSecondsDuration, int milliSecondsInterval);
bool jLogiLedPulseLighting(int redPercentage, int greenPercentage, int bluePercentage, int milliSecondsDuration, int milliSecondsInterval);
bool jLogiLedStopEffects();

bool jLogiLedSetLightingFromBitmap(UInt8* bitmap);
bool jLogiLedSetLightingForKeyWithScanCode(int keyCode, int redPercentage, int greenPercentage, int bluePercentage);
bool jLogiLedSetLightingForKeyWithHidCode(int keyCode, int redPercentage, int greenPercentage, int bluePercentage);
bool jLogiLedSetLightingForKeyWithQuartzCode(int keyCode, int redPercentage, int greenPercentage, int bluePercentage);
bool jLogiLedSetLightingForKeyWithKeyName(enum KeyName keyName, int redPercentage, int greenPercentage, int bluePercentage);

bool jLogiLedSaveLightingForKey(enum KeyName keyName);
bool jLogiLedRestoreLightingForKey(enum KeyName keyName);

bool jLogiLedExcludeKeysFromBitmap(enum KeyName *keyList, int listCount);	// new in 8.87

bool jLogiLedFlashSingleKey(enum KeyName keyName, int redPercent, int greenPercent, int bluePercent,
						   int msDuration, int msInterval);
bool jLogiLedPulseSingleKey(enum KeyName keyName, int startRedPercent, int startGreenPercent, int startBluePercent,
						   int finishRedPercent, int finishGreenPercent, int finishBluePercent,
						   int msDuration, bool isInfinite);
bool jLogiLedStopEffectsOnKey(enum KeyName keyName);

bool jLogiLedGetConfigOptionNumber(const wchar_t *configPath, double *defaultValue);	// new in 8.87
bool jLogiLedGetConfigOptionBool(const wchar_t *configPath, bool *defaultValue);	// new in 8.87
bool jLogiLedGetConfigOptionColor(const wchar_t *configPath, int *defaultRed, int *defaultGreen, int *defaultBlue);	// new in 8.87
bool jLogiLedGetConfigOptionKeyInput(const wchar_t *configPath, wchar_t *defaultValue, int bufferSize);	// new in 8.87
bool jLogiLedSetConfigOptionLabel(const wchar_t *configPath, wchar_t *label);	// new in 8.87

void jLogiLedShutdown();

#endif


