YMSwipeTableViewCell
===============

YMSwipeTableViewCell is a lightweight library that enables table view cell swiping (seen in most mail applications). It is implemented as a UITableViewCell class category and can detect left or right horizontal swipes. Upon a left or right swipe, a swipe view is exposed. This library is meant to be flexible, so that any views can be exposed during a swipe and a myriad of actions can be taken during the swipe (e.g., swipe view animations, or cell snap back or destruction at the completion of a swipe). 

The example app shows the right view as two buttons and the left view as a single button with a checkmark's alpha increasing in proportion to the swipe content offset:
                            
<p align="center"><img src="https://github.com/aluong-yammer/YMSwipeTableViewCell/blob/master/github-assets/YMSwipeTableViewCellSampleApp.gif?raw=true"/></p>

##Features

* Users have complete control over the views exposed during a left or right swipe.

* Configurable cell swipe effect:
    - Unmasking 
<p align="center"><img src="https://github.com/aluong-yammer/YMSwipeTableViewCell/blob/master/github-assets/YMSwipeTableViewCellUnmaskingSync.gif?raw=true"/></p>
    - Trailing
<p align="center"><img src="https://github.com/aluong-yammer/YMSwipeTableViewCell/blob/master/github-assets/YMSwipeTableViewCellTrailingSync.gif?raw=true"/></p>
* Block callback for cell swiping or cell mode change so that actions can be taken at any time during the swipe.
* Configurable values for the snap-to-right or snap-to-left views threshold.
* The ability to configure multiple cell swipe.
* Low overhead and memory profile for the following reasons:
    - Swipe views are not added to the view until a swipe actually begins.
    - A cell snapshot, and not the actual cell content view, is used during the swipe animation.

##Usage

* Implement a new cell class using the UITableViewCell class category. In this new cell class, make sure to import the class category:

```objc
#import "UITableViewCell+Swipe.h"
```
* Create the desired swipe views. In this demo app, a two-button view (YMTwoButtonSwipeView) is created for the right swipe view and a single-button view (YMOneButtonSwipeView) is created for the left swipe view. 

* Initialize the left and right views:

```objc
YMTwoButtonSwipeView *rightView = [[YMTwoButtonSwipeView alloc] initWithFrame:CGRectMake(0, 0, kRightSwipeViewWidth, YMTableViewCellHeight)];
YMOneButtonSwipeView *leftView = [[YMOneButtonSwipeView alloc] init];

self.rightSwipeView = rightView;
self.leftSwipeView = leftView;
```

* Set the left or right views by calling addLeftView or addRightView. If no left view is added, then the left to right swipe is disabled. If no right view is added, then the right to left swipe is disabled.

```objc
[self addLeftView:self.leftSwipeView];
[self addRightView:self.rightSwipeView];
```

* Set the swipe effect (the default value is YATableSwipeEffectUnmask):

```objc
[cell setSwipeEffect:YATableSwipeEffectUnmask];
```

* Set the allowMultiple flag to enable multiple cells to be swiped at once if desired (default is NO):

```objc
self.allowMultiple = YES;
```

* Set the swipeContainerViewBackgroundColor to change the default swipe container view background color (default color is grayColor).

```objc
self.swipeContainerViewBackgroundColor = [UIColor grayColor];
```

* Set the right and left swipe snap threshold values (the default value is 0, so right or left snaps will always occur when a swipe is initiated):

```objc
self.rightSwipeSnapThreshold = self.bounds.size.width * 0.3;
self.leftSwipeSnapThreshold = self.bounds.size.width * 0.1;
```

* Set the swipeBlock to notify the subviews and/or the view controller that a swipe is occurring:

```objc
[self setSwipeBlock:^(UITableViewCell *cell, CGPoint translation){
    if (translation.x < 0) {
        [rightView didSwipeWithTranslation:translation];
    }
    else {
        [leftView didSwipeWithTranslation:translation];
    }
}];
```

* Set the modeChangedBlock to notify the subviews and/or view controller that a swipe mode has changed:

```objc
[self setModeChangedBlock:^(UITableViewCell *cell, YATableSwipeMode mode){
    [leftView didChangeMode:mode];
    [rightView didChangeMode:mode];
    
    if (weakSelf.delegate) {
        [weakSelf.delegate swipeableTableViewCell:weakSelf didCompleteSwipe:mode];
    }
}];
```

* Optionally set the modeWillChangeBlock to notify the subviews and/or view controller that a swipe mode will change.

* In your view controller's cellForRowAtIndexPath delegate, instantiate the table view cell.

```objc
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
```

## Installation
###Option 1
Clone repo and manually add source to project. 

###Option 2
Carthage:
<pre>github "yammer/YMSwipeTableViewCell"</pre>

###Option 3 
CocoaPods:
<pre>pod 'YMSwipeTableViewCell', '~> 1.1.2'</pre>

##Contributing

Use [Github issues](https://github.com/aluong-yammer/YMSwipeTableViewCell/issues) to track bugs and feature requests.

##Contact

Alda Luong
- https://github.com/aluong-yammer/

Sumit Kumar
- https://github.com/appdios/

##License

YMSwipeTableViewCell is available under the MIT license. See the LICENSE file for more info.





