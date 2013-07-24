//
//  CreatureViewController.m
//  creatures
//
//  Created by Syd Polk on 6/8/13.
//  Copyright (c) 2013 Bone Jarring Games and Software. All rights reserved.
//

#import "CreatureViewController.h"

@interface CreatureViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation CreatureViewController

#pragma mark - Managing the detail item

- (void)setCreature:(id)newCreature
{
    if (_creature != newCreature) {
        _creature = newCreature;
        
        // Update the view.
        if (_creature) {
            _characterNameField.text = [_creature characterName];
            _playerNameField.text = [_creature playerName];
            _campaignNameField.text = [_creature campaignName];
            self.title = [_creature characterName];
        } else {
            _characterNameField.text = @"";
            _playerNameField.text = @"";
            _campaignNameField.text = @"";
            self.title = @"";
        }
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    Creature *creature = self.creature;
    
    // Update the user interface for the detail item.
    if (creature) {
        creature.characterName = self.characterNameField.text;
        creature.playerName = self.playerNameField.text;
        creature.campaignName = self.campaignNameField.text;
        self.title = self.creature.characterName;
    } else {
        self.title = @"";
        self.characterNameField.text = @"";
        self.playerNameField.text = @"";
        self.campaignNameField.text = @"";
    }
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
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
    self.masterPopoverController = nil;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    [self configureView];
}

@end
