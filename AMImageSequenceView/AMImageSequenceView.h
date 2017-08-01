//
//  AMImageSequenceView.h
//
//  Created by Artem on 27.03.17.
//  Copyright © 2017 Artem Mihaylov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMImageSequenceView : UIView
/**
 * Sensitivity of image sequence rotation
 
 * Higher sensitivity means slower rotation
 
 * The default value is 0.8
 */
@property (nonatomic) CGFloat sensivity;

/**
 * Posibility of image zoom
 
 * You can't rotate image, if zoom scale is more then 1.0 (normal image size)
 
 * The default value is FALSE
 */
@property (nonatomic) BOOL zoomEnabled;

/**
 * Posibility of image zoom bounces
 
 * The default value is FALSE
 */
@property (nonatomic) BOOL zoomBouncesEnabled;

/**
 * Maximum scale factor for zooming. It must be greater than the minimum zoom scale for zooming to be enabled.
 
 * This value determines how large the content can be scaled.
 
 * The default value is 1.0.
 
 */
@property (nonatomic) CGFloat maximumZoomScale;

/**
 * Minimum scale factor for zooming.
 
 * This value determines how small the content can be scaled.
 
 * This property is readonly and the value is always 1.0. It needs for correct working of image sequence mechanics.
 
 */
@property (nonatomic, readonly) CGFloat minimumZoomScale;

/**
 * Turning on / off  inertia on image rotating
 
 * If this property is true, image will continue rotating for some time with deceleration
 after you end rotating gesture (similarly as scrolling of UITableView)
 
 * The default value is FALSE
 */
@property (nonatomic) BOOL inertiaEnabled;

/**
 * Content mode of image
 
 * The default value is UIViewContentModeScaleAspectFit
 */
@property (nonatomic) UIViewContentMode contentMode;


/**
 init of AMImageSequenceView

 @param images Array of images for sequence. Be careful, images array can't be nil or empty, otherwise init will return nil
 @param frame frame of AMImageSequenceView
 @return UIView with 1 subview - UIScrollView (for zooming), UIScrollView contains 1 subview - UIImageView with gesture recognizer for rotating image
 */
-(nullable instancetype) initWithImages:(nonnull NSArray<UIImage *> *)images frame:(CGRect)frame;

@end
