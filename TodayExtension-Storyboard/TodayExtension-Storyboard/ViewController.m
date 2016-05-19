//
//  ViewController.m
//  TodayExtension-Storyboard
//
//  Created by Cain on 5/18/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.todayExtensionStoryboardExample"];
    
    [userDefault setObject:@"tips" forKey:@"group.todayExtensionStoryboardExample.tips"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
