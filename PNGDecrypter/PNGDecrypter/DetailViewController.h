//
//  DetailViewController.h
//  PNGDecrypter
//
//  Created by Pacess HO on 23/10/11.
//  Copyright (c) 2011 Pacess HO. All rights reserved.
//

//---------------------------------------------------------------------------------------------------------------------
//  0    1         2         3         4         5         6         7         8         9         0
//  5678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

#import <UIKit/UIKit.h>

//=====================================================================================================================
@interface DetailViewController : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate>  {
	UIView *masterView;
}

//---------------------------------------------------------------------------------------------------------------------
- (id)init;
- (void)dealloc;

//  View lifecycle
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation;

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;

//  Custom functions
- (void)loadImage:(UIImage *)image;

@end