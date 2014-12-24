//
//  ViewController.m
//  FunctionManager
//
//  Created by Tops on 12/23/14.
//  Copyright (c) 2014 Tops Technology Pvt.Ltd. All rights reserved.
//

#import "ViewController.h"
#import "FunctionManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)btnAlertClick:(id)sender {
    [FunctionManager showMessage:@"GymPal" withMessage:@"Hello" withDelegage:nil view:self];
}
- (IBAction)btnConfirmClick:(id)sender {

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
