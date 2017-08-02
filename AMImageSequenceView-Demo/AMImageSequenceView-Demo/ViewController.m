//
//  ViewController.m
//  AMImageSequenceView-Demo
//
//  Created by Artem on 02.08.17.
//  Copyright © 2017 Artem Mihaylov. All rights reserved.
//

#import "ViewController.h"
#import "AMImageSequenceView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    NSMutableArray <UIImage *>*imagesArray = [[NSMutableArray alloc] init];
    for (int i=0; i<73 ; i++) {
        NSString *imageName = [NSString stringWithFormat:@"circular_%02i", i];
        UIImage *image = [UIImage imageNamed:imageName];
        [imagesArray addObject:image];
    }
    
    AMImageSequenceView *view = [[AMImageSequenceView alloc] initWithImages:imagesArray frame:frame];
    view.zoomEnabled = YES;
    view.zoomBouncesEnabled = YES;
    view.maximumZoomScale = 3.0;
    view.inertiaEnabled = YES;
    view.sensivity = 0.6;
    view.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
