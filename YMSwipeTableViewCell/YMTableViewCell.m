//
//  YMTableViewCell.m
//  YMSwipeTableViewCell
//
//  Created by aluong on 8/26/15.
//  Copyright (c) 2015 Microsoft. All rights reserved.
//

#import "YMTableViewCell.h"
#import "YMTwoButtonSwipeView.h"
#import "YMOneButtonSwipeView.h"
#import "UITableViewCell+Swipe.h"

const NSInteger YMTableViewCellTwoButtonSwipeViewTrashButtonIndex = 1;
const NSInteger YMTableViewCellTwoButtonSwipeViewUndoButtonIndex = 0;
const NSInteger YMTableViewCellHeight = 80;
static const NSInteger kRightSwipeViewWidth = 200;

@interface YMTableViewCell()

@property (nonatomic, strong) UIView *leftSwipeView;
@property (nonatomic, strong) UIView *rightSwipeView;

@end

@implementation YMTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.textLabel.font = [self defaultFont];
        self.textLabel.numberOfLines = 0;
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        // --- Set the background color of the swipe container view --- 
        self.swipeContainerViewBackgroundColor = [UIColor grayColor];

        __weak __typeof(self)weakSelf = self;
        
        // --- Create the right view ---
        YMTwoButtonSwipeView *rightView = [[YMTwoButtonSwipeView alloc] initWithFrame:CGRectMake(0, 0, kRightSwipeViewWidth, YMTableViewCellHeight)];
        rightView.leftButtonTappedActionBlock = ^(void) {
            if (weakSelf.delegate) {
                [weakSelf.delegate swipeableTableViewCell:weakSelf didTriggerRightViewButtonWithIndex:YMTableViewCellTwoButtonSwipeViewUndoButtonIndex];
            }
        };
        
        // Call the didTriggerRightViewButtonWithIndex delegate when one of the right view button is triggered
        rightView.rightButtonTappedActionBlock = ^(void) {
            if (weakSelf.delegate) {
                [weakSelf.delegate swipeableTableViewCell:weakSelf didTriggerRightViewButtonWithIndex:YMTableViewCellTwoButtonSwipeViewTrashButtonIndex];
            }
        };
        
        // --- Create the left view ---
        YMOneButtonSwipeView *leftView = [[YMOneButtonSwipeView alloc] init];
        
        // Call the didTriggerLeftViewButtonWithIndex delegate when the left view button is triggered
        leftView.buttonTappedActionBlock= ^(void) {
            if (weakSelf.delegate) {
                [weakSelf.delegate swipeableTableViewCell:weakSelf didTriggerLeftViewButtonWithIndex:0];
            }
        };
        
        // --- Notify the left and right views during a swipe by setting the swipeBlock ---
        [self setSwipeBlock:^(UITableViewCell *cell, CGPoint translation){
            if (translation.x < 0) {
                [rightView didSwipeWithTranslation:translation];
            }
            else {
                [leftView didSwipeWithTranslation:translation];
            }
        }];
        
        // --- Call the didCompleteSwipe delegate when the the cell mode has changed ---
        [self setModeChangedBlock:^(UITableViewCell *cell, YATableSwipeMode mode){
            [leftView didChangeMode:mode];
            [rightView didChangeMode:mode];
            
            if (weakSelf.delegate) {
                [weakSelf.delegate swipeableTableViewCell:weakSelf didCompleteSwipe:mode];
            }
        }];
        
        self.rightSwipeView = rightView;
        self.leftSwipeView = leftView;
        
        // --- Add the left and right views ---
        [self addLeftView:self.leftSwipeView];
        [self addRightView:self.rightSwipeView];
        
        // --- Enable multipe cells to be swiped at once --- 
        self.allowMultiple = YES;
    }
    return self;
}


- (void)prepareForReuse
{
    [self resetSwipe:nil];
    [super prepareForReuse];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftSwipeView.frame = self.bounds;
    
    // Make some layout adjustments to the image in the left swipe view
    YMOneButtonSwipeView *leftView = (YMOneButtonSwipeView *)self.leftSwipeView;
    leftView.aButton.contentHorizontalAlignment = (self.swipeEffect == YATableSwipeEffectDefault) ? UIControlContentHorizontalAlignmentLeft : UIControlContentHorizontalAlignmentRight;
    CGFloat leftInset = (self.swipeEffect == YATableSwipeEffectDefault) ? 20.0 : 0;
    CGFloat rightInset = (self.swipeEffect == YATableSwipeEffectDefault) ? 0 : 20.0;
    [leftView.aButton setImageEdgeInsets:UIEdgeInsetsMake(0, leftInset, 0, rightInset)];
    
    // Set the snap thresholds
    self.rightSwipeSnapThreshold = self.bounds.size.width * 0.3;
    self.leftSwipeSnapThreshold = self.bounds.size.width * 0.1;
}

- (UIFont *)defaultFont
{
    return [UIFont fontWithName:@"SegoeUI-Semibold" size:12.0];
}

@end
