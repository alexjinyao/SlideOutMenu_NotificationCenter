//
//  RedViewController.m
//  SlideOutMenu_NotificationCenter
//
//  Created by Jin on 11/20/14.
//  Copyright (c) 2014 Jin. All rights reserved.
//

#import "RedViewController.h"

@interface RedViewController ()

@end

@implementation RedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)menuButtonTouched:(id)sender {
    NSNotification *notification = [NSNotification notificationWithName:@"menuButtonTouched" object:self];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
