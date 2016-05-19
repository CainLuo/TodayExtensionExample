//
//  TodayViewController.m
//  TodayExtensionCode
//
//  Created by Cain on 5/19/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  设置Today Extension的Size
     *
     *  @param 0   Today Extension的宽度是不可变的，所以这里随便给个0就好了
     *  @param 150 高度是可控制的，这里我给了一个固定值150
     *
     *  @return CGSize
     */
    self.preferredContentSize = CGSizeMake(0, 150);
    
    /**
     *  初始化一个UIView，且设置它的属性
     */
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                0,
                                                                self.view.frame.size.width,
                                                                self.view.frame.size.height)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.contentView];

    /**
     *  初始化一个Label，并且设置它的属性
     *
     */
    self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    
    self.tipsLabel.text            = @"这是一个测试代码";
    self.tipsLabel.numberOfLines   = 0;
    self.tipsLabel.textColor       = [UIColor blackColor];
    self.tipsLabel.backgroundColor = [UIColor redColor];

    [self.view addSubview:self.tipsLabel];
    
    /**
     *  获取主应用传过来的数据
     */
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.todayExtensionStoryboardExample"];
    
    NSString *nickName = [userDefault objectForKey:@"group.todayExtensionStoryboardExample.tips"];
    
    if (nickName) {
        
        NSString *message = @"今天XX又给你准备了很多惊喜哦，快去看看吧！";
        
        self.tipsLabel.text = [NSString stringWithFormat:@"%@,%@", nickName, message];
    }
    
    
    /**
     *  设置跳转页面的Button
     */
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    homeButton.frame     = CGRectMake(20, 100, 120, 44);
    homeButton.tag       = 0;
    
    [homeButton setTitle:@"GoHomeButton" forState:UIControlStateNormal];
    
    [self.contentView addSubview:homeButton];
    
    UIButton *OtherButton = [UIButton buttonWithType:UIButtonTypeSystem];
    OtherButton.frame     = CGRectMake(160, 100, 120, 44);
    OtherButton.tag       = 1;
    
    [OtherButton setTitle:@"OtherButton" forState:UIControlStateNormal];
    
    [self.contentView addSubview:OtherButton];
    
    [homeButton addTarget:self action:@selector(buttonActions:) forControlEvents:UIControlEventTouchUpInside];
    [OtherButton addTarget:self action:@selector(buttonActions:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  该方法是用来设置Today Extension的偏移，默认会像左偏移
 *
 *  @param defaultMarginInsets UIEdgeInsets
 *
 *  @return UIEdgeInsets
 */
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    
    return UIEdgeInsetsZero;
}

/**
 *  该方法是用来刷新Today Extension数据的
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

/**
 *  点击Today Extension跳转至App的Button
 *
 *  @param sender UIButton
 */
- (void)buttonActions:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        [self.extensionContext openURL:[NSURL URLWithString:@"todayExtensionCode://action=GotoHome"] completionHandler:^(BOOL success) {
            
            NSLog(@"open url result:%d",success);
        }];
        
    } else if(sender.tag == 1) {
        
        [self.extensionContext openURL:[NSURL URLWithString:@"todayExtensionCode://action=GotoOrder"] completionHandler:^(BOOL success) {
            
            NSLog(@"open url result:%d",success);
        }];
    }
}

@end
