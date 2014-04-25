//
//  DetailViewController.h
//  creatures-ios-storyboard
//
//  Created by Syd Polk on 8/8/13.
//  Copyright (c) 2013 Bone Jarring Games and Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreatureDocument.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UITextFieldDelegate>

- (void) clearDocument;
- (IBAction)done:(id)sender;
- (IBAction)characterNameChanged:(id)sender;

@property (strong, nonatomic) CreatureDocument *document;

@property (weak, nonatomic) IBOutlet UITextField *characterNameField;
@property (weak, nonatomic) IBOutlet UITextField *playerNameField;
@property (weak, nonatomic) IBOutlet UITextField *campaignNameField;

@end
