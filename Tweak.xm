#import "Tweak.h"

// Disable ads
%hook YTAdsInnerTubeContextDecorator
- (void)decorateContext:(id)arg1 {
    %orig(nil);
}
%end

// Enable background playback
%hook YTIPlayerResponse
- (BOOL)isPlayableInBackground {
    return YES;
}
%end
%hook YTSingleVideo
- (BOOL)isPlayableInBackground {
    return YES;
}
%end
%hook YTSingleVideoMediaData
- (BOOL)isPlayableInBackground {
    return YES;
}
%end
%hook YTPlaybackData
- (BOOL)isPlayableInBackground {
    return YES;
}
%end
%hook YTIPlayabilityStatus
- (BOOL)isPlayableInBackground {
    return YES;
}
%end
%hook YTPlaybackBackgroundTaskController
- (BOOL)isContentPlayableInBackground {
    return YES;
}
- (void)setContentPlayableInBackground:(BOOL)arg1 {
    arg1 = 1;
	%orig;
}
%end

// Hide download button under the player 
%hook YTTransferButton
- (void)setVisible:(BOOL)arg1 dimmed:(BOOL)arg2 {
    arg1 = 0;
    %orig;
}
%end

// Disable related videos in overlay 
%hook YTRelatedVideosViewController
- (BOOL)isEnabled {
    return 0;
}
- (void)setEnabled:(BOOL)arg1 {
    arg1 = 0;
	%orig;
}
%end
%hook YTFullscreenEngagementOverlayView
- (BOOL)isEnabled {
    return 0;
}
- (void)setEnabled:(BOOL)arg1 {
    arg1 = 0;
    %orig;
}
%end
%hook YTFullscreenEngagementOverlayController
- (BOOL)isEnabled {
    return 0;
}
- (void)setEnabled:(BOOL)arg1 {
    arg1 = 0;
    %orig;
}
%end
%hook YTMainAppVideoPlayerOverlayView
- (void)setInfoCardButtonHidden:(BOOL)arg1 {
    arg1 = 1;
    %orig;
}
- (void)setInfoCardButtonVisible:(BOOL)arg1 {
    arg1 = 0;
    %orig;
}
%end
%hook YTMainAppVideoPlayerOverlayViewController
- (void)adjustPlayerBarPositionForRelatedVideos {
}
%end

// Disable YT kids popup 
%hook YTWatchMetadataAppPromoCell
- (id)initWithFrame:(CGRect)arg1 {
    return NULL;
}
%end
%hook YTHUDMessageView
- (id)initWithMessage:(id)arg1 dismissHandler:(id)arg2 {
    return NULL;
}
%end

// Disable Hints 
%hook YTSettings
- (BOOL)areHintsDisabled {
	return 1;
}
- (void)setHintsDisabled:(BOOL)arg1 {
    arg1 = 1;
    %orig;
}
%end
%hook YTUserDefaults
- (BOOL)areHintsDisabled {
	return 1;
}
- (void)setHintsDisabled:(BOOL)arg1 {
    arg1 = 1;
    %orig;
}
%end

// Disable Voice Search 
%hook YTSearchTextField
- (void)setVoiceSearchEnabled:(BOOL)arg1 {
    arg1 = 0;
    %orig;
}
%end

// Hide shorts tab and create video button 
%hook YTPivotBarView
- (void)setItemView2:(YTPivotBarItemView *)argument {
    argument.navigationButton.hidden = YES;
}
- (void)setItemView3:(YTPivotBarItemView *)argument {
    argument.navigationButton.hidden = YES;
}
- (YTPivotBarItemView *)itemView2 {
    YTPivotBarItemView *orig = %orig;
    orig.navigationButton.hidden = YES;
    return nil;
}
- (YTPivotBarItemView *)itemView3 {
    YTPivotBarItemView *orig = %orig;
    orig.navigationButton.hidden = YES;
    return nil;
}
%end

// Disable Double Tap to Skip 
%hook YTDoubleTapToSeekController
- (void)enableDoubleTapToSeek:(BOOL)arg1 {
    arg1 = 0;
    %orig;
}
- (void)showDoubleTapToSeekEducationView:(BOOL)arg1 {
    arg1 = 0;
    %orig;
}
%end
%hook YTSettings
- (BOOL)doubleTapToSeekEnabled {
    return NO;
}
%end

// Disable end screen creator pop ups
%hook YTCreatorEndscreenView
- (id)initWithFrame:(CGRect)arg1 {
    return NULL;
}
%end

// Hide Previous and Next buttons in Overlay
%hook YTMainAppSkipVideoButton
- (void)layoutSubviews {
	%orig();
	if(![[self imageView] isHidden]) [[self imageView] setHidden: YES];
}
- (BOOL)isHidden {
	return YES;
}
%end

// Restore classic video quality menu
%hook YTVideoQualitySwitchControllerFactory

- (id)videoQualitySwitchControllerWithParentResponder:(id)responder {
    Class originalClass = %c(YTVideoQualitySwitchOriginalController);
    return originalClass ? [[originalClass alloc] initWithParentResponder:responder] : %orig;
}

%end

// Remember Caption Settings
%hook YTColdConfig
- (BOOL)respectDeviceCaptionSetting {
    return NO;
}
%end

// Use system theme
%hook YTColdConfig
- (BOOL)shouldUseAppThemeSetting {
    return YES;
}
%end