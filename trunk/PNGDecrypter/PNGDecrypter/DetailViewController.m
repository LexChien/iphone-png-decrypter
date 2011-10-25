//
//  DetailViewController.m
//  PNGDecrypter
//
//  Created by Pacess HO on 23/10/11.
//  Copyright (c) 2011 Pacess HO. All rights reserved.
//

//---------------------------------------------------------------------------------------------------------------------
//  0    1         2         3         4         5         6         7         8         9         0
//  5678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

#import "DetailViewController.h"
#import "AppDelegate.h"

//=====================================================================================================================
//@implementation DetailScrollView
//
////---------------------------------------------------------------------------------------------------------------------
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  {	
//	NSLog(@"[DetailScrollView touchesEnded] %d", self.dragging);
//	
//	if (self.dragging == NO)  {
////		[[NSNotificationCenter defaultCenter] postNotificationName:EVENTDETAILSVIEW_NOTIFICATION_TOUCH object:nil userInfo:nil];
//		[self.nextResponder touchesEnded:touches withEvent:event]; 
//		return;
//	}
//	
//	[super touchesEnded:touches withEvent:event];
//}
//
//@end

//=====================================================================================================================
@implementation DetailViewController

//---------------------------------------------------------------------------------------------------------------------
- (id)init  {
	NSLog(@"[DetailViewController init]");
	
	self = [super init];
	if (self == nil)  {return nil;}
	
	CGRect rect = [AppDelegate getApplicationFrame];
	
	//---------------------------------------------------------------------------------------------------------------------
	//  Master view
	UIScrollView *scrollView = [[[UIScrollView alloc] initWithFrame:rect] autorelease];
	[scrollView setDelegate:self];
	[scrollView setBackgroundColor:[UIColor whiteColor]];
	[scrollView setUserInteractionEnabled:YES];
	[scrollView setMaximumZoomScale:4.0f];
	[scrollView setMinimumZoomScale:0.5f];
	[scrollView setZoomScale:1.0f];
	self.view = scrollView;

	//---------------------------------------------------------------------------------------------------------------------
	UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTap:)];
	[recognizer setDelegate:self];
	[self.view addGestureRecognizer:recognizer];

	return self;
}

//---------------------------------------------------------------------------------------------------------------------
- (void)dealloc  {
	NSLog(@"[DetailViewController dealloc]");
	[super dealloc];
}

//---------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning  {
	NSLog(@"[DetailViewController didReceiveMemoryWarning]");
	[super didReceiveMemoryWarning];
	
	//  Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
//---------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad  {
	NSLog(@"[DetailViewController viewDidLoad]");
	[super viewDidLoad];
}

//---------------------------------------------------------------------------------------------------------------------
- (void)viewDidUnload  {
	NSLog(@"[DetailViewController viewDidUnload]");
	[super viewDidUnload];
	
	//  Release any retained subviews of the main view.
	//  e.g. self.myOutlet = nil;
}

//---------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated  {
	NSLog(@"[DetailViewController viewWillAppear]");
	[super viewWillAppear:animated];
}

//---------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated  {
	NSLog(@"[DetailViewController viewDidAppear]");
	[super viewDidAppear:animated];
}

//---------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated  {
	NSLog(@"[DetailViewController viewWillDisappear]");
	[super viewWillDisappear:animated];
}

//---------------------------------------------------------------------------------------------------------------------
- (void)viewDidDisappear:(BOOL)animated  {
	NSLog(@"[DetailViewController viewDidDisappear]");
	[super viewDidDisappear:animated];
}

//---------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation  {
	//  Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait ||
			interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

//---------------------------------------------------------------------------------------------------------------------
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView  {
	NSLog(@"[DetailViewController viewForZoomingInScrollView]");
	return masterView;
}

//---------------------------------------------------------------------------------------------------------------------
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view  {
}

//---------------------------------------------------------------------------------------------------------------------
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView  {
}

#pragma mark - Custom functions
//---------------------------------------------------------------------------------------------------------------------
- (void)loadImage:(UIImage *)image  {
	CGSize frameSize = self.view.frame.size;
	CGSize size = image.size;

	if (size.width < frameSize.width || size.height < frameSize.height)  {

		CGRect rect = CGRectZero;
		rect.size = frameSize;
		UIView *uiview = [[UIView alloc] initWithFrame:rect];
		[self.view addSubview:uiview];
		[uiview release];
		masterView = uiview;

		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		[imageView setCenter:masterView.center];
		[masterView addSubview:imageView];
		[imageView release];
	}  else  {

		//  Image is larger than screen
		CGPoint point = CGPointMake(size.width/2, size.height/2);
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		[imageView setCenter:point];
		[self.view addSubview:imageView];
		[imageView release];
	}
}

//---------------------------------------------------------------------------------------------------------------------
- (void)gestureTap:(id)sender {
	NSLog(@"[DetailViewController gestureTap]");
//	UITapGestureRecognizer *gesture = (UITapGestureRecognizer *)sender;
//	UIView *uiview = [gesture view];

	[self dismissModalViewControllerAnimated:YES];
}

@end