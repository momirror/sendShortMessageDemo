//
//  mspViewController.h
//  发短信demo
//
//  Created by msp on 14-3-9.
//  Copyright (c) 2014年 msp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface SendMessageViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate,MFMessageComposeViewControllerDelegate>
{
    
}

@end
