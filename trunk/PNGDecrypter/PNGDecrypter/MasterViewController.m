//
//  MasterViewController.m
//  PNGDecrypter
//
//  Created by Pacess HO on 23/10/11.
//  Copyright (c) 2011 Pacess HO. All rights reserved.
//

//---------------------------------------------------------------------------------------------------------------------
//  0    1         2         3         4         5         6         7         8         9         0
//  5678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

#import <QuartzCore/QuartzCore.h>

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"

//---------------------------------------------------------------------------------------------------------------------
#define MASTERVIEW_HEADER_HEIGHT				50

//---------------------------------------------------------------------------------------------------------------------
typedef enum  {
	MASTERVIEW_TAG_UNDEFINED = 0,
	MASTERVIEW_TAG_DECRYPTALL,
	MASTERVIEW_TAG_ABORT,
}  MASTERVIEW_TAG;

//=====================================================================================================================
@implementation MasterViewController

//---------------------------------------------------------------------------------------------------------------------
@synthesize detailViewController = _detailViewController;
@synthesize tableView = _tableView;
@synthesize fileArray = _fileArray;

//---------------------------------------------------------------------------------------------------------------------
- (id)init  {
	NSLog(@"[MasterViewController init]");

	self = [super init];
	if (self == nil)  {return nil;}

	CGRect rect = [AppDelegate getApplicationFrame];

	//  Get file list
	self.fileArray= [MasterViewController getFileList];

	//---------------------------------------------------------------------------------------------------------------------
	//  Master view
	UIView *uiview = [[[UIView alloc] initWithFrame:rect] autorelease];
	[uiview setBackgroundColor:[UIColor whiteColor]];
	self.view = uiview;

	//---------------------------------------------------------------------------------------------------------------------
	//  Application name label
	CGRect childRect = CGRectMake(10, 0, rect.size.width-10-10, 30);

	UILabel *label = [[UILabel alloc] initWithFrame:childRect];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor redColor]];
	[label setFont:[UIFont boldSystemFontOfSize:24.0f]];
	[label setShadowColor:[UIColor blackColor]];
	[label setShadowOffset:CGSizeMake(0.8f, 0.8f)];
	[label setAdjustsFontSizeToFitWidth:YES];
	[label setTextAlignment:UITextAlignmentLeft];
	[label setText:@"PNG Decrypter"];
	[self.view addSubview:label];
	[label release];

	//  Image count label
	childRect.origin.y += 30-2;
	childRect.size.height = 20;
	NSString *string = [NSString stringWithFormat:@"File count: %d", [self.fileArray count]];

	label = [[UILabel alloc] initWithFrame:childRect];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor redColor]];
	[label setFont:[UIFont boldSystemFontOfSize:14.0f]];
	[label setAdjustsFontSizeToFitWidth:YES];
	[label setTextAlignment:UITextAlignmentLeft];
	[label setText:string];
	[self.view addSubview:label];
	[label release];

	//  Export all button
	int y = MASTERVIEW_HEADER_HEIGHT/2;
	CGPoint point = CGPointMake(rect.size.width-y, y);

	UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
	[button setTag:MASTERVIEW_TAG_DECRYPTALL];
	[button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[button setCenter:point];
	[self.view addSubview:button];
	decryptAllButton = button;

	//---------------------------------------------------------------------------------------------------------------------
	//  Table view
	rect.origin.y += MASTERVIEW_HEADER_HEIGHT;
	rect.size.height -= MASTERVIEW_HEADER_HEIGHT;

	UITableView *tableView = [[UITableView alloc] initWithFrame:rect];
	[tableView setDelegate:self];
	[tableView setDataSource:self];
	[self.view addSubview:tableView];
	
	//---------------------------------------------------------------------------------------------------------------------
	//  Loading view
	int width = 200;
	int height = 120;
	childRect = CGRectMake(0, 0, width, height);
	uiview = [[UIView alloc] initWithFrame:childRect];
	[uiview setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.75f]];
	[uiview setHidden:YES];
	[uiview setCenter:self.view.center];
	[uiview.layer setCornerRadius:10];
	[self.view addSubview:uiview];
	[uiview release];
	loadingView = uiview;
	
	//  Loading indicator
	point = CGPointMake(width/2, 30);

	UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[indicatorView setCenter:point];
	[loadingView addSubview:indicatorView];
	[indicatorView startAnimating];
	[indicatorView release];

	//  Loading label
	childRect = loadingView.frame;
	childRect.origin.x = 0;
	childRect.origin.y = 50;
	childRect.size.height = 30;

	label = [[UILabel alloc] initWithFrame:childRect];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor whiteColor]];
	[label setFont:[UIFont boldSystemFontOfSize:14.0f]];
	[label setAdjustsFontSizeToFitWidth:YES];
	[label setTextAlignment:UITextAlignmentCenter];
	[label setText:@"Please wait..."];
	[loadingView addSubview:label];
	[label release];
	loadingLabel = label;

	//  Abort button
	childRect = CGRectMake(20, 85, (width-40), 20);

	button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setTag:MASTERVIEW_TAG_ABORT];
	[button setFrame:childRect];
	[button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[button setTitle:@"Abort" forState:UIControlStateNormal];
	[loadingView addSubview:button];

	return self;
}

//---------------------------------------------------------------------------------------------------------------------
- (void)dealloc  {
	NSLog(@"[MasterViewController dealloc]");
	self.fileArray = nil;

	[_detailViewController release];
	[super dealloc];
}

//---------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning  {
	NSLog(@"[MasterViewController didReceiveMemoryWarning]");
	[super didReceiveMemoryWarning];

	//  Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
//---------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad  {
	NSLog(@"[MasterViewController viewDidLoad]");
	[super viewDidLoad];
}

//---------------------------------------------------------------------------------------------------------------------
- (void)viewDidUnload  {
	NSLog(@"[MasterViewController viewDidUnload]");
	[super viewDidUnload];

	//  Release any retained subviews of the main view.
	//  e.g. self.myOutlet = nil;
}

//---------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated  {
	NSLog(@"[MasterViewController viewWillAppear]");
	[super viewWillAppear:animated];
}

//---------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated  {
	NSLog(@"[MasterViewController viewDidAppear]");
	[super viewDidAppear:animated];
}

//---------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated  {
	NSLog(@"[MasterViewController viewWillDisappear]");
	[super viewWillDisappear:animated];
}

//---------------------------------------------------------------------------------------------------------------------
- (void)viewDidDisappear:(BOOL)animated  {
	NSLog(@"[MasterViewController viewDidDisappear]");
	[super viewDidDisappear:animated];
}

//---------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation  {
	//  Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

//---------------------------------------------------------------------------------------------------------------------
//  Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView  {
	return 1;
}

//---------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
	return [self.fileArray count];
}

//---------------------------------------------------------------------------------------------------------------------
//  Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	//  Configure the cell.
	cell.textLabel.text = [self.fileArray objectAtIndex:indexPath.row];
	cell.detailTextLabel.text = nil;

	return cell;
}

//---------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {

	//  Deselect table cell
	[tableView deselectRowAtIndexPath:indexPath animated:NO];

	//  Convert image if necessary
	NSString *filename = [self.fileArray objectAtIndex:indexPath.row];
	UIImage *image = [self decryptFile:filename];
	
	CGSize size = image.size;
	NSString *string = [NSString stringWithFormat:@"%.fx%.f", size.width, size.height];

	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	cell.detailTextLabel.text = string;
	
	//  Pop up detail view
	DetailViewController *controller = [[[DetailViewController alloc] init] autorelease];
	[controller loadImage:image];
	[self presentModalViewController:controller animated:YES];
}

#pragma mark - Custom functions
//---------------------------------------------------------------------------------------------------------------------
//  YES = Saved
//  NO = Not saved
- (BOOL)saveData  {
	NSLog(@"[MasterViewController saveData]");
	return YES;
}

//---------------------------------------------------------------------------------------------------------------------
- (void)startApp  {
	NSLog(@"[MasterViewController startApp]");
}

//---------------------------------------------------------------------------------------------------------------------
- (void)stopApp  {
	NSLog(@"[MasterViewController stopApp]");
}

//---------------------------------------------------------------------------------------------------------------------
- (void)buttonClicked:(id)sender  {
	UIButton *button = (UIButton *)sender;
	MASTERVIEW_TAG buttonTag = button.tag;

	switch (buttonTag)  {
		default:  break;

		case MASTERVIEW_TAG_DECRYPTALL:  {
			//---------------------------------------------------------------------------------------------------------------------
			[decryptAllButton setUserInteractionEnabled:NO];
			[loadingView setHidden:NO];
			
			//  Start decryption
			abortFlag = NO;
			decryptionStep = 0;
			decryptionCount = [self.fileArray count];

			[NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(decryptNow) userInfo:nil repeats:NO];
		}  break;

		case MASTERVIEW_TAG_ABORT:  {
			//---------------------------------------------------------------------------------------------------------------------
			abortFlag = YES;
		}  break;
	}
}

//---------------------------------------------------------------------------------------------------------------------
- (void)decryptNow  {
	NSString *filename = [self.fileArray objectAtIndex:decryptionStep];
	decryptionStep++;

	//  Decrypt image
	[self decryptFile:filename];

	//---------------------------------------------------------------------------------------------------------------------
	//  Update label text
	NSString *string = [NSString stringWithFormat:@"Decrypting...%d/%d", decryptionStep, decryptionCount];
	[loadingLabel setText:string];

	if (decryptionStep >= decryptionCount || abortFlag == YES)  {
		[decryptAllButton setUserInteractionEnabled:YES];
		[loadingView setHidden:YES];
		return;
	}

	[NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(decryptNow) userInfo:nil repeats:NO];
}

//---------------------------------------------------------------------------------------------------------------------
- (UIImage *)decryptFile:(NSString *)filename  {
	NSString *documentsDirectory = [MasterViewController getDocumentsDirectory];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:filename];
	
	NSString *outputDirectory = [documentsDirectory stringByAppendingPathComponent:@"output"];
	NSString *filePathOutput = [outputDirectory stringByAppendingPathComponent:filename];
	if ([[NSFileManager defaultManager] isReadableFileAtPath:filePathOutput] == YES)  {
		UIImage *image = [[[UIImage alloc] initWithContentsOfFile:filePathOutput] autorelease];
		return image;
	}
		
	//  Output file not found, decrypt now
	[[NSFileManager defaultManager] createDirectoryAtPath:outputDirectory withIntermediateDirectories:YES attributes:nil error:nil];
	
	//---------------------------------------------------------------------------------------------------------------------
	//  Avoid loading @2x image automatically
	NSData *data = [NSData dataWithContentsOfFile:filePath];
	if (data == nil)  {return nil;}

	UIImage *image = [[[UIImage alloc] initWithData:data] autorelease];
	
	filePath = [outputDirectory stringByAppendingPathComponent:filename];
	[UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
	return image;
}

#pragma mark - Static functions
//---------------------------------------------------------------------------------------------------------------------
+ (NSString *)getDocumentsDirectory  {
	NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [pathArray objectAtIndex:0];
	return documentsDirectory;
}

//---------------------------------------------------------------------------------------------------------------------
+ (NSArray *)getFileList  {
	NSFileManager *manager = [NSFileManager defaultManager];
	NSString *documentsDirectory = [self getDocumentsDirectory];
    NSArray *array = [manager contentsOfDirectoryAtPath:documentsDirectory error:nil];
	return array;
}

@end