//
//  LeRUITableViewWithRefreshControl.h
//  apple
//
//  Created by sangfor on 17/5/6.
//  Copyright © 2017年 com.sangfor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeRrefreshControl.h"

@interface LeRUITableViewWithRefreshControl : UITableView

@property (nonatomic , readonly ,strong) LeRrefreshControl *refreshControl;

@end
