//
//  MasterViewController.m
//  creatures-ios-storyboard
//
//  Created by Syd Polk on 8/8/13.
//  Copyright (c) 2013 Bone Jarring Games and Software. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Creature.h"
#import "CreatureDocument.h"

@interface MasterViewController () {
}
@property (nonatomic, strong) NSMutableArray *urls;
@property (nonatomic, strong) id observer;
@property (nonatomic, strong) NSMutableDictionary *documents;
@property (nonatomic, strong) CreatureDocument *currentCreature;

@end

@implementation MasterViewController

- (NSURL *) URLforDocuments {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (Creature *) creatureFromURL:(NSURL *) url
{
    Creature *creature = nil;
    
    CreatureDocument *document = [self.documents objectForKey:url];
    if (document) {
        creature = document.creature;
    }
    return creature;
}

- (NSString *) labelFromURL:(NSURL *) url {
    NSString *returnString = nil;
    Creature *creature = [self creatureFromURL:url];
    
    if (creature) {
        returnString = creature.characterName;
    } else {
        NSString *path = [url path];
        NSString *component = [path lastPathComponent];
        returnString = [component stringByDeletingPathExtension];
    }
    return returnString;
}

- (void) updateFileList {
    // Save currently selected document.
    NSIndexPath *indexPath;
    NSURL *selectedUrl = nil;
    if ([self.urls count] > 0) {
        indexPath = [self.tableView indexPathForSelectedRow];
        if (indexPath) {
            selectedUrl = [self.urls objectAtIndex:indexPath.row];
        }
    }

    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[self URLforDocuments] includingPropertiesForKeys:nil options:0 error:nil];
    self.urls = [[NSMutableArray alloc] init];
    if (files) {
        for (NSURL *url in files) {
            NSString *filename = [url lastPathComponent];
            NSString *extension = [filename pathExtension];
            if ([extension isEqualToString:@"character"]) {
                [self.urls insertObject:url atIndex:0];
                [self setCreatureFromURL:url];
            }
        }
    }
    [self.urls sortWithOptions:NSSortStable usingComparator:^NSComparisonResult(NSURL *url1, NSURL *url2) {
        NSString *file1 = [self labelFromURL:url1];
        NSString *file2 = [self labelFromURL:url2];
        return [file1 caseInsensitiveCompare:file2];
    }];
    [self.tableView reloadData];
    // Now, find table cell matching previous selection.
    if (selectedUrl) {
        int row = [self.urls indexOfObject:selectedUrl];
        indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
}

- (void) setCreatureFromURL:(NSURL *)url
{
    CreatureDocument *document = [self.documents objectForKey:url];
    if (!document) {
        document = [[CreatureDocument alloc] initWithFileURL:url];
        [self.documents setObject:document forKey:url];
    }
    if (!document.creature) {
        [document openWithCompletionHandler:^(BOOL success) {
            // TODO: Do this on a background queue.
            [self updateFileList];
        }];
    }
}

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
    self.documents = [[NSMutableDictionary alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateFileList];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

    self.title = NSLocalizedString(@"Characters", @"Characters");
    self.urls = [[NSMutableArray alloc] init];

    __weak MasterViewController *weakSelf = self;
    self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:@"characterNameChanged" object:nil queue:nil usingBlock:^(NSNotification *notification) {
        MasterViewController *strongSelf = weakSelf;
        if (strongSelf) {
            [self updateFileList];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    NSURL *url = nil;
    CreatureDocument *creatureDoc = nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ssZZZ"];
    __block NSString *fileName = [NSString stringWithFormat:@"%@.character", [formatter stringFromDate:[NSDate date]]];

    url = [[self  URLforDocuments] URLByAppendingPathComponent:fileName];
    creatureDoc = [[CreatureDocument alloc] initWithFileURL:url];
    [self.documents setObject:creatureDoc forKey:url];
    [creatureDoc saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
        if (success) {
            [self updateFileList];
            int row = [self.urls indexOfObject:url];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
            [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                [self performSegueWithIdentifier:@"showDetail" sender:[self.tableView cellForRowAtIndexPath:indexPath]];
            }
        }
        else {
            NSLog(@"Could not save %@ in %s", fileName, __PRETTY_FUNCTION__);
        }

    }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.urls count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSURL *url = [self.urls objectAtIndex:indexPath.row];
    cell.textLabel.text = [self labelFromURL:url];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSURL *url = [self.urls objectAtIndex:indexPath.row];
        NSError *error = nil;
        if ([[NSFileManager defaultManager] removeItemAtURL:url error:&error]) {
            [self.urls removeObjectAtIndex:indexPath.row];
            [self.documents removeObjectForKey:url];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            NSLog(@"%s: Error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *url = [self.urls objectAtIndex:indexPath.row];
    self.currentCreature = [self.documents objectForKey:url];
    self.detailViewController.document = self.currentCreature;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSURL *url = [self.urls objectAtIndex:indexPath.row];
        CreatureDocument *document = [self.documents objectForKey:url];
        if (document) {
            [[segue destinationViewController] setDocument:document];
        }
    }
}

@end
