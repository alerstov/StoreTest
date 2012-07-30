//
//  ViewController.h
//  StoreTest
//
//  Created by Lion User on 28.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)click_1:(id)sender;
- (IBAction)click_2:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *but_2;
@property (retain, nonatomic) IBOutlet UIButton *but_1;

- (IBAction)unbuy:(id)sender;

@end
