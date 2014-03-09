//
//  mspAppDelegate.h
//  发短信demo
//
//  Created by msp on 14-3-9.
//  Copyright (c) 2014年 msp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SendMessageViewController;

@interface mspAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SendMessageViewController *viewController;

@end
