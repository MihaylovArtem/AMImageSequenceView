//
//  ImageSequenceView.h
//
//  Created by Artem on 27.03.17.
//  Copyright © 2017 Artem Mihaylov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageSequenceView : UIView
/**
 * Sensitivity of image sequence rotation
 
 * Higher sensitivity means slower rotation
 
 * Default value is 0.8
 */
@property (nonatomic) CGFloat sensivity;

/**
 * Posibility of image zoom
 
 * You can't rotate image, if zoom scale is more then 1.0 (normal image size)
 
 * Default value is FALSE
 */
@property (nonatomic) BOOL zoomEnabled;

/**
 * Turning on / off  inertia on image rotating
 
 * If this property is true, image will continue rotating for some time with deceleration
 after you end rotating gesture (similarly as scrolling of UITableView)
 
 * Default value is FALSE
 */
@property (nonatomic) BOOL inertiaEnabled;

/**
 * Content mode of image
 
 * Default value is UIViewContentModeScaleAspectFit
 */
@property (nonatomic) UIViewContentMode contentMode;


/**
 init of ImageSequenceView

 @param images Array of images for sequence. Be careful, images array can't be nil or empty, otherwise init will return nil
 @param frame frame of ImageSequenceView
 @return UIView with 1 subview - UIScrollView (for zooming), UIScrollView contains 1 subview - UIImageView with gesture recognizer for rotating image
 */
-(nullable instancetype) initWithImages:(nonnull NSArray<UIImage *> *)images frame:(CGRect)frame;

@end
