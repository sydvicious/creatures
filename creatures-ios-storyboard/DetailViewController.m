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

- (void)setDetailItem:(id)newDetailItem
{
    if (self.document != newDetailItem) {
        self.document = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.document && self.document.creature) {
        Creature *creature = self.document.creature;
        self.characterNameField.text = creature.characterName;
        if (creature.characterName && !([creature.characterName isEqualToString:@""])) {
            self.title = creature.characterName;
        } else {
            self.title = @"Character";
        }
    } else {
        self.characterNameField.text = @"";
        self.title = @"Character";
    }
}

- (void)updateFields
{
    CreatureDocument *document = self.document;
    Creature *creature = document.creature;

    creature.characterName = self.characterNameField.text;
    [self configureView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Characters", @"Characters");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    [self saveDocument];
    self.masterPopoverController = nil;
}

- (void) saveDocument {
    [self updateFields];
    [self.document saveToURL:self.document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"characterNameChanged" object:_document];
    }];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self saveDocument];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.document) {
        return YES;
    } else {
        return NO;
    }
}

- (IBAction)characterNameChanged:(id)sender {
    [self updateFields];
    CreatureDocument *document = self.document;
    Creature *creature = document.creature;
    self.characterNameField.text = creature.characterName;
    if (creature.characterName && !([creature.characterName isEqualToString:@""])) {
        self.title = creature.characterName;
    } else {
        self.title = @"Character";
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self saveDocument];
    [super viewWillDisappear:animated];
}

@end
