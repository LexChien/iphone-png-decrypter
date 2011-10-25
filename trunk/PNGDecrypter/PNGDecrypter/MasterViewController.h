//
//  MasterViewController.h
//  PNGDecrypter
//
//  Created by Pacess HO on 23/10/11.
//  Copyright (c) 2011 Pacess HO. All rights reserved.
//

//---------------------------------------------------------------------------------------------------------------------
//  0    1         2         3         4         5         6         7         8         9         0
//  5678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

#import <UIKit/UIKit.h>

//---------------------------------------------------------------------------------------------------------------------
@class DetailViewController;

//=====================================================================================================================
@interface MasterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>  {
	UITableView *_tableView;
	UIButton *decryptAllButton;

	NSArray *_fileArray;
	int decryptionCount;
	int decryptionStep;

	UIView *loadingView;
	UILabel *loadingLabel;
	BOOL abortFlag;
}

//---------------------------------------------------------------------------------------------------------------------
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *fileArray;

//---------------------------------------------------------------------------------------------------------------------
- (id)init;
- (void)dealloc;

//  View lifecycle
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

//  Custom functions
- (BOOL)saveData;
- (void)startApp;
- (void)stopApp;

- (void)buttonClicked:(id)sender;
- (void)decryptNow;
- (UIImage *)decryptFile:(NSString *)filename;

//  Static functions
+ (NSString *)getDocumentsDirectory;
+ (NSArray *)getFileList;

@end