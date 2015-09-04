//
//  ViewController.m
//  YMSwipeTableViewCell
//
//  Created by Sumit Kumar on 4/8/15.
//  Copyright (c) 2015 Microsoft Inc. All rights reserved.
//

#import "ViewController.h"

static NSString * const kYMSwipeTableViewCellHeaderTitle = @"YMSwipeTableViewCell";
static NSString * const kYMSwipeTableViewCell0Title = @"Unmasking Effect";
static NSString * const kYMSwipeTableViewCell1Title = @"Trailing Effect";
static NSString * const kYMSwipeTableViewCellDetailTitleSwipeLeftRight = @"Swipe Left or Right";
static const NSInteger kYMTableViewNumberOfRows = 50;

@interface ViewController ()
@property (nonatomic, assign) NSInteger numberOfRows;
@end

@implementation ViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _numberOfRows = kYMTableViewNumberOfRows;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[YMTableViewCell class] forCellReuseIdentifier:NSStringFromClass([YMTableViewCell class])];
    self.tableView.rowHeight = YMTableViewCellHeight;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload:)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.numberOfRows;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YMTableViewCell *cell = (YMTableViewCell*)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YMTableViewCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.row % 2 == 0) {
        [cell setSwipeEffect:YATableSwipeEffectDefault];
        cell.textLabel.text = kYMSwipeTableViewCell0Title;
        cell.detailTextLabel.text = kYMSwipeTableViewCellDetailTitleSwipeLeftRight;
        cell.backgroundColor = [self unmaskingCellColor];
    } else {
        [cell setSwipeEffect:YATableSwipeEffectTrail];
        cell.textLabel.text = kYMSwipeTableViewCell1Title;
        cell.detailTextLabel.text = kYMSwipeTableViewCellDetailTitleSwipeLeftRight;
        cell.backgroundColor = [self trailingCellColor];
    }

    return cell;
}


#pragma mark - YMTableViewCellDelegate

- (void)swipeableTableViewCell:(YMTableViewCell *)cell didTriggerLeftViewButtonWithIndex:(NSInteger)index {
    if (index == 0) {
        [cell resetSwipe:nil];
    }
}

- (void)swipeableTableViewCell:(YMTableViewCell *)cell didTriggerRightViewButtonWithIndex:(NSInteger)index {
    if (index == YMTableViewCellTwoButtonSwipeViewUndoButtonIndex) {
        [cell resetSwipe:nil];
    } else if (index == YMTableViewCellTwoButtonSwipeViewTrashButtonIndex) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        self.numberOfRows--;
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)swipeableTableViewCell:(YMTableViewCell *)cell didCompleteSwipe:(YATableSwipeMode)swipeMode {
    // do something after swipe completion
}

# pragma mark - Helper Methods
- (void)reload:(id)sender {
    self.numberOfRows = kYMTableViewNumberOfRows;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

- (UIColor *)unmaskingCellColor
{
    return [UIColor colorWithRed:0xf3/255.0f
                           green:0xf5/255.0f
                            blue:0xf8/255.0f
                           alpha:1.0f];
}

- (UIColor *)trailingCellColor
{
    return [UIColor whiteColor];
}
@end