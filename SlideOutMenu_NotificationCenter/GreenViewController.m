//
//  GreenViewController.m
//  SlideOutMenu_NotificationCenter
//
//  Created by Jin on 11/20/14.
//  Copyright (c) 2014 Jin. All rights reserved.
//

#import "GreenViewController.h"

@interface GreenViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *barButton;

//@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;

@property (strong, nonatomic) UISwipeGestureRecognizer *swipGesture;


@end

@implementation GreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonTouched:)];
//    self.tapGesture.numberOfTapsRequired = 1;
//    
//    [self.view addGestureRecognizer:self.tapGesture];
    
    self.swipGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(menuButtonTouched:)];
    self.swipGesture.numberOfTouchesRequired = 1;
    [self.swipGesture setDirection:(UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:self.swipGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButtonTouched:(id *)sender {
    NSNotification *notification = [NSNotification notificationWithName:@"menuButtonTouched" object:self];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    
    return YES;
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
