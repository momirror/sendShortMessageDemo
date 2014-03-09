//
//  mspViewController.m
//  发短信demo
//
//  Created by msp on 14-3-9.
//  Copyright (c) 2014年 msp. All rights reserved.
//

#import "SendMessageViewController.h"
#import "mspAppDelegate.h"


@interface SendMessageViewController ()

@end

@implementation SendMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self addContact];
}


- (void)addContact
{
    NSLog(@"adding contact");
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];
    picker.peoplePickerDelegate = self;
//    [self presentModalViewController:picker animated:YES];
//    [self presentViewController:picker animated:YES completion:NULL];
    [self.view addSubview:picker.view];
//    [self.navigationController pushViewController:picker animated:YES];
    mspAppDelegate *appDelegate= [[UIApplication sharedApplication] delegate];
    
}


#pragma mark - 选取联系人的回调方法


- (void) peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    return YES;
}

- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    //retrieve number
    NSLog(@"tapped number");
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, property);
    NSString *phone = nil;
    if ((ABMultiValueGetCount(phoneNumbers) > 0)) {
        phone = ( NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, identifier);
    } else {
        phone = @"[None]";
    }
    NSLog(@"retrieved number: %@", phone);
    
       
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self sendMessage:phone];
    return NO;
}


- (BOOL)sendMessage:(NSString*)phone
{
    MFMessageComposeViewController* controller = [[MFMessageComposeViewController alloc] init];
    if ([MFMessageComposeViewController canSendText]) {
        controller.body =  @"指定的短信内容";
        //parse through receipients
        NSScanner* numberScanner = [NSScanner scannerWithString:phone];
        [numberScanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@","]];
        NSCharacterSet* charactersToSkip = [NSCharacterSet characterSetWithCharactersInString:@","];
        NSString* substring = @"";
        NSMutableArray *substrings = [NSMutableArray array];
        while (![numberScanner isAtEnd]) {
            [numberScanner scanUpToCharactersFromSet:charactersToSkip intoString:&substring];
            [numberScanner scanCharactersFromSet:charactersToSkip intoString:NULL];
            NSLog(@"%@", substring);
            [substrings addObject:substring];
        }
        
        controller.recipients = substrings;
        controller.messageComposeDelegate = self;
//        [self presentModalViewController:controller animated:YES];
        [self.view addSubview:controller.view];
//        [controller presentedViewController];
//        [self.navigationController pushViewController:controller animated:YES];
        
        return YES;
    }
    else
    {
        UIAlertView * pAler = [[UIAlertView alloc] initWithTitle:Nil message:@"你的设备不支持短信功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [pAler show];
        return NO;
    }
}

#pragma mark - 发送短信的回调方法

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
//    [self.navigationController popViewControllerAnimated:YES];
    
    
    if (result == MessageComposeResultCancelled)
    {
        NSLog(@"Message cancelled");
        [controller.view removeFromSuperview];
        
    }
    else if (result == MessageComposeResultSent)
    {
        NSLog(@"Message sent");
        [controller.view removeFromSuperview];
    }
    else
    {
        NSLog(@"Message failed");
        UIAlertView * pAler = [[UIAlertView alloc] initWithTitle:Nil message:@"发送失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [pAler show];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
