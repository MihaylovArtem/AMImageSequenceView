//
//  AMImageSequenceView.m
//
//  Created by Artem Mihaylov on 27.03.17.
//  Copyright © 2017 Artem Mihaylov. All rights reserved.
//

#import "AMImageSequenceView.h"

@interface AMImageSequenceView () <UIScrollViewDelegate>

@end

@implementation AMImageSequenceView {
    UIImageView *imageView;
    UIScrollView *scrollView;
    NSArray <UIImage *> *imagesArray;
    NSUInteger currentIndex;
}

#pragma mark - Init

-(instancetype) initWithImages:(nonnull NSArray<UIImage *> *)images frame:(CGRect)frame {
    if (!images) {
        NSLog(@"Error! Can't init AMImageSequenceView with nil array of images");
        return nil;
    }
    
    if (!images.count) {
        NSLog(@"Error! Can't init AMImageSequenceView with empty array of images");
        return nil;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        imagesArray = images;
        currentIndex = 0;
        
        //Default values
        self.sensivity = 0.8;
        self.zoomEnabled = NO;
        self.zoomBouncesEnabled = NO;
        self.maximumZoomScale = 1.0;
        self.inertiaEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
        
        //UIScrollView for zooming
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:scrollView];
        scrollView.scrollEnabled = NO;
        scrollView.delegate = self;
        scrollView.bounces = NO;
        scrollView.bouncesZoom = self.zoomBouncesEnabled;
        scrollView.minimumZoomScale = self.minimumZoomScale;
        scrollView.maximumZoomScale = self.maximumZoomScale;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        
        //UIImageView for image sequence
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        imageView.image = imagesArray[currentIndex];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        UIPanGestureRecognizer *rec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        [imageView addGestureRecognizer:rec];
        [scrollView addSubview:imageView];
    }
    return self;
}

#pragma mark - Swipes

- (void)handleSwipe:(UIPanGestureRecognizer *)swipe {
    if (scrollView.zoomScale > self.minimumZoomScale) {
        return;
    }
    if (swipe.state == UIGestureRecognizerStateBegan || swipe.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [swipe translationInView:imageView];
        if (fabs(translation.x / 10*self.sensivity) > 1) {
            if (translation.x > 0) {
                [self setPrevious];
            } else {
                [self setNext];
            }
            [swipe setTranslation:CGPointZero inView:imageView];
        }
    }
    if (swipe.state == UIGestureRecognizerStateEnded && self.inertiaEnabled) {
        CGPoint velocity = [swipe velocityInView:imageView];
        CGFloat x = velocity.x;
        if (x > 0) {
            [self onTickPrevWithRemaningX:fabs(x)];
        } else {
            [self onTickNextWithRemaningX:fabs(x)];
        }
    }
}

-(void)setNext {
    currentIndex = (currentIndex + 1) % imagesArray.count;
    imageView.image = imagesArray[currentIndex];
}

-(void)setPrevious {
    currentIndex = (currentIndex + imagesArray.count - 1) % imagesArray.count;
    imageView.image = imagesArray[currentIndex];
}

#pragma mark - Inertia

-(void)onTickNextWithRemaningX:(CGFloat) x {
    [self setNext];
    if ((1-((x-10*self.sensivity)/x)) < 0.03) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((1-((x-10*self.sensivity)/x)) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self onTickNextWithRemaningX:(x - 10*self.sensivity)];
        });
    }
}

-(void)onTickPrevWithRemaningX:(CGFloat) x {
    [self setPrevious];
    if ((1-((x-10*self.sensivity)/x)) < 0.03) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((1-((x-10*self.sensivity)/x)) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self onTickPrevWithRemaningX:(x - 10*self.sensivity)];
        });
    }
}

#pragma mark - Zoom

-(void)setZoomEnabled:(BOOL)zoomEnabled {
    _zoomEnabled = zoomEnabled;
    scrollView.scrollEnabled = zoomEnabled;
}

-(void)setZoomBouncesEnabled:(BOOL)zoomBouncesEnabled {
    _zoomBouncesEnabled = zoomBouncesEnabled;
    scrollView.bouncesZoom = zoomBouncesEnabled;
}

-(void)setMaximumZoomScale:(CGFloat)maximumZoomScale {
    _maximumZoomScale = maximumZoomScale;
    scrollView.maximumZoomScale = maximumZoomScale;
}

-(CGFloat)minimumZoomScale {
    return 1.0;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageView;
}

- (void)centerScrollViewContents {
    CGSize boundsSize = scrollView.bounds.size;
    CGRect contentsFrame = imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    imageView.frame = contentsFrame;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollViewContents];
}

#pragma mark - Other

-(void)setContentMode:(UIViewContentMode)contentMode {
    _contentMode = contentMode;
    imageView.contentMode = contentMode;
}

@end
