#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import "Tweaks/YouTubeHeader/YTVideoQualitySwitchOriginalController.h"
#import "Tweaks/YouTubeHeader/YTPivotBarItemView.h"
#import "Tweaks/YouTubeHeader/YTVideoQualitySwitchOriginalController.h"

@interface YTQTMButton: UIButton
@end

@interface YTPivotBarView: UIView
@end

@interface YTRightNavigationButtons
@property(readonly, nonatomic) YTQTMButton *MDXButton;
@property(readonly, nonatomic) YTQTMButton *creationButton;
@end

@interface YTMainAppControlsOverlayView
@property(readonly, nonatomic) YTQTMButton *playbackRouteButton;
@end

@interface YTMainAppSkipVideoButton
@property(readonly, nonatomic) UIImageView *imageView;
@end

@interface ELMCellNode
@end

@interface _ASCollectionViewCell : UICollectionViewCell
- (id)node;
@end

@interface YTAsyncCollectionView : UICollectionView
- (void)removeShortsCellAtIndexPath:(NSIndexPath *)indexPath;
@end
