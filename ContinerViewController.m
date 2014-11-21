//
//  ContinerViewController.m
//  SlideOutMenu_NotificationCenter
//
//  Created by Jin on 11/20/14.
//  Copyright (c) 2014 Jin. All rights reserved.
//

#import "ContinerViewController.h"
#import "GreenViewController.h"
#import "BlueViewController.h"

@interface ContinerViewController ()

@property (strong, nonatomic) UITableViewController *sideMenuViewController;

@property (strong, nonatomic) NSArray *viewControllers;

@property (assign, nonatomic) NSInteger indexOfVisibleController;

@property (assign, nonatomic) BOOL isMenuVisible;

@end

@implementation ContinerViewController

- (void)initViewControllers{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navController = [storyBoard instantiateViewControllerWithIdentifier:@"NavVC"];
    UINavigationController *blueController = [storyBoard instantiateViewControllerWithIdentifier:@"BlueNa"];
    UINavigationController *greenController = [storyBoard instantiateViewControllerWithIdentifier:@"GreenNa"];
    UITabBarController *tabBarController = [storyBoard instantiateViewControllerWithIdentifier:@"TabBar"];

    
    self.viewControllers = @[navController, blueController, greenController, tabBarController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.indexOfVisibleController = 0;
    self.isMenuVisible = true;
    
    // get the sidementVC from the sotryboard
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.sideMenuViewController = [storyBoard instantiateViewControllerWithIdentifier:@"SideMenuVC"];
    
    // set sidemenuVC frame as continerVC frame
    self.sideMenuViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    //add sidemenu viewcontroller and view to continerVC
    [self addChildViewController:self.sideMenuViewController];
    [self.view addSubview:self.sideMenuViewController.view];
    
    [self initViewControllers];
    
    // init the current view as the first view in the viewcontrollers array
    UINavigationController *visibleViewController = self.viewControllers[0];
    
    visibleViewController.view.frame = CGRectMake(self.view.frame.size.width/3, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:visibleViewController];
    [self.view addSubview:visibleViewController.view];
    
    // add self as the recever of notification for menuButtonTouched
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(handleMenuButtonTouched) name:@"menuButtonTouched" object:nil];
    
    [center  addObserver:self selector:@selector(handleSwitchViewController:) name:@"didSelectRow" object:nil];
}

- (void)handleSwitchViewController:(NSNotification *)paramNotification{
    //NSNumber *incommingViewController = paramNotification.userInfo[@"selectRow"];
    int number = [[paramNotification.userInfo objectForKey:@"selectRow"] intValue];
    NSLog(@"The incomming viewcontroller index is : %d", number);
    [self replaceVisibleViewControllerWithViewControllerAtIndex:number];
    
}

- (void)replaceVisibleViewControllerWithViewControllerAtIndex:(int) index{
    if (index == self.indexOfVisibleController) {
        [self handleMenuButtonTouched];
        return;
    }
    
    
    UIViewController *incomingViewController = self.viewControllers[index];
    incomingViewController.view.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    UIViewController *outgoingViewController = self.viewControllers[self.indexOfVisibleController];
    CGRect visibleFrame = self.view.bounds;
    
    [outgoingViewController willMoveToParentViewController:nil];
    
    [self addChildViewController:incomingViewController];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [self transitionFromViewController:outgoingViewController
                      toViewController:incomingViewController
                              duration:0.5
                               options:0
                            animations:^{
                                outgoingViewController.view.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                            }
                            completion:^(BOOL finished) {
                                [UIView animateWithDuration:0.5
                                                 animations:^{
                                                     [outgoingViewController.view removeFromSuperview];
                                                     [self.view addSubview:incomingViewController.view];
                                                     incomingViewController.view.frame = visibleFrame;
                                                     [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                                 }];
                                [incomingViewController didMoveToParentViewController:self];
                                [outgoingViewController removeFromParentViewController];
                                
                                self.isMenuVisible = NO;
                                self.indexOfVisibleController = index;
                            }];
}

-(void)handleMenuButtonTouched{
    UIViewController *visibleViewController = self.viewControllers[self.indexOfVisibleController];;
    if (self.isMenuVisible) {
        [UIView animateWithDuration:0.5 animations:^{
            visibleViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
        self.isMenuVisible = !self.isMenuVisible;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            visibleViewController.view.frame = CGRectMake(self.view.frame.size.width/3, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
        self.isMenuVisible = !self.isMenuVisible;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
