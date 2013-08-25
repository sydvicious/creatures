//
//  DetailViewController.m
//  creatures-ios-storyboard
//
//  Created by Syd Polk on 8/8/13.
//  Copyright (c) 2013 Bone Jarring Games and Software. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)updateDocument:(CreatureDocument *)newDocument
{
    if (_document != newDocument) {
        // Save old document.
        if (_document) {
            [self updateFields];
            [_document saveToURL:_document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {

                // Notify master view controller that document was saved.
                [[NSNotificationCenter defaultCenter] postNotificationName:@"characterNameChanged" object:_document];
            }];
        }
        
        // Set view controller to new document
        _document = newDocument;
        
        // Update the view.
        [self configureView];
    }
}
- (void)setDocument:(CreatureDocument *)newDocument
{
    [self updateDocument:newDocument];
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)clearDocument
{
    [self updateDocument:nil];
}

- (IBAction)done:(id)sender {
    [self updateFields];
    CreatureDocument *document = self.document;
    [document saveToURL:document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.document && self.document.creature) {
        Creature *creature = self.document.creature;
        self.detailDescriptionLabel.text = creature.characterName;
        self.characterNameField.text = creature.characterName;
    } else {
        self.detailDescriptionLabel.text = @"";
        self.characterNameField.text = @"";
    }
}

- (void)updateFields
{
    CreatureDocument *document = self.document;
    Creature *creature = document.creature;

    creature.characterName = self.characterNameField.text;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    //If in portrait mode, display the master view
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        // See http://stackoverflow.com/questions/10426622/uisplitviewcontroller-how-force-to-show-master-popover-in-app-launch-portrait
        // See http://www.learningipadprogramming.com/2012/04/03/how-to-ignore-performselector-leak-warning/
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.navigationItem.leftBarButtonItem.target performSelector:self.navigationItem.leftBarButtonItem.action withObject:self.navigationItem afterDelay:0];
        #pragma clang diagnostic pop
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self updateFields];
    [self.document saveToURL:self.document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"characterNameChanged" object:_document];
    }];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.document) {
        return YES;
    } else {
        return NO;
    }
}


@end
