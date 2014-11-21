//
//  BlueViewController.m
//  SlideOutMenu_NotificationCenter
//
//  Created by Jin on 11/20/14.
//  Copyright (c) 2014 Jin. All rights reserved.
//

#import "BlueViewController.h"

@interface BlueViewController ()

@property (strong, nonatomic) IBOutlet UIBarButtonItem *menuButton;

@end

@implementation BlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    
//    [visualEffectView setFrame:self.view.bounds];
//    
//    [self.view addSubview:visualEffectView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)menuButtonTouched:(UIBarButtonItem *)sender {
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
