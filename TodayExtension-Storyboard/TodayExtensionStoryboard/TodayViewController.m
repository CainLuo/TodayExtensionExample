//
//  TodayViewController.m
//  TodayExtensionStoryboard
//
//  Created by Cain on 5/18/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.preferredContentSize = CGSizeMake(0, 150);
    
    //Label1
    self.tipsLabel.textColor = [UIColor colorWithRed:66.0/255 green:145.0/255 blue:211.0/255 alpha:1];
    self.tipsLabel.text = @"这是一个测试代码";
    
    
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.todayExtensionStoryboardExample"];
    
    NSString *nickName = [userDefault objectForKey:@"group.todayExtensionStoryboardExample.tips"];
    
    if (nickName) {
        
        NSString *message = @"今天XX又给你准备了很多惊喜哦，快去看看吧！";
        
        self.tipsLabel.text = [NSString stringWithFormat:@"%@,%@", nickName, message];
    }    
}

/**
 *  切换按钮的点击事件
 *
 *  @param sender 切换按钮
 */
- (IBAction)toggleLineChartViewVisible:(UIButton *)sender {
    
    UIButton* button = (UIButton*)sender;
    
    if (button.tag == 1) {
        
        [self.extensionContext openURL:[NSURL URLWithString:@"todayExtensionStoryboard://action=GotoHomePage"] completionHandler:^(BOOL success) {
            
            NSLog(@"open url result:%d",success);
        }];
    }
    else if(button.tag == 2) {
        
        [self.extensionContext openURL:[NSURL URLWithString:@"todayExtensionStoryboard://action=GotoOrderPage"] completionHandler:^(BOOL success) {
            
            NSLog(@"open url result:%d",success);
        }];
    }
}

/**
 *  设置Today Extension View的偏移位置
 *
 *  @param defaultMarginInsets UIEdgeInsets
 *
 *  @return UIEdgeInsets
 */
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    
    return UIEdgeInsetsZero;
}

/**
 *  该刚发是用来自动更新Today Extension插件数据
 *
 *  @param completionHandler
 */
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
