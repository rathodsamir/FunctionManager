//
//  ViewController.h
//  FunctionManager
//
//  Created by Tops on 12/23/14.
//  Copyright (c) 2014 Tops Technology Pvt.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate,UIActionSheetDelegate>
{
    UILabel *lblSize;//Resizeble label
}
@property(nonatomic,strong) IBOutlet UILabel *lblSize;

- (IBAction)btnAlertClick:(id)sender;
- (IBAction)btnConfirmClick:(id)sender;
@end
