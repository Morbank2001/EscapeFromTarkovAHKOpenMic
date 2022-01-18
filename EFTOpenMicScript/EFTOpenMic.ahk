#SingleInstance, Force
#include VA.ahk

;User Settings || Hotkeys at the bottom
;Toggle key output: CTRL+ALT+M
;Toggle TesingMode: CTRL+ALT+T
;Change Threshold: CTRL+ALT+MWHEEL
VOIPKey := "j" ;set equal to voip key in-game
voipDownTime := 500 ;how long voip key is held for in ms
threshold := 0.6 ;default threshold

boolEnableTestingMode := false
boolThresholdChange := false
boolEnableMute := true
boolKeyDown := false
SetStoreCapsLockMode, Off

audiomic := VA_GetDevice("capture")
audioMeter := VA_GetAudioMeter(audiomic)

VA_IAudioMeterInformation_GetMeteringChannelCount(audioMeter, channelCount)

; "The peak value for each channel is recorded over one device
;  period and made available during the subsequent device period."
VA_GetDevicePeriod("capture", devicePeriod)

Loop
{
    ; Get the peak value across all channels.
    VA_IAudioMeterInformation_GetPeakValue(audioMeter, peakValue)    
    meter := peakValue
	
	if (boolEnableTestingMode){
		if (!boolThresholdChange){
			ToolTip, %meter% ;Show tooltip with mic level
		}

		if (peakValue >= threshold){
			SoundBeep, 300, 100
		}
	}
	
	if (peakValue >= threshold && !boolEnableMute && !boolKeyDown){
	boolKeyDown := true
	Send {%VOIPKey% down}
	SetTimer, VOIPdown, -%voipDownTime%
	}

    Sleep, %deviceperiod%
}

^!T:: ;LCTRL + ALT + T: Enable Testing Mode. Shows mic level and beeps when triggering threshold
boolEnableTestingMode := !boolEnableTestingMode
Tooltip
return

^!M:: ;LCTRL + ALT + M: Toggle AHK input to computer
boolEnableMute := !boolEnableMute
if (boolEnableMute){
SoundBeep, 200, 50
SoundBeep, 100, 50
}else{
SoundBeep, 400, 50
SoundBeep, 500, 50
}
return

^!WheelUp:: ;LCTRL + ALT + MWHEEL: Change threshold
boolThresholdChange := true
threshold += 0.05
if (threshold > 1.0){
threshold := 1.0
}
ToolTip, %threshold% ;Show tooltip with threshold level
SetTimer, tooltipTimer, 500
return

^!WheelDown::
boolThresholdChange := true
threshold -= 0.05
if (threshold < 0.05){
threshold := 0.05
}
ToolTip, %threshold% ;Show tooltip with threshold level
SetTimer, tooltipTimer, 500
return

tooltipTimer:
ToolTip
boolThresholdChange := false
return

VOIPdown:
Send {%VOIPKey% up}
boolKeyDown := false
return
