//
//  HYHitTestController.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/8.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYHitTestController.h"

@interface HYHitTestController ()
- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *layerView;

@property (nonatomic, strong) CALayer *blueLayer;

@end

@implementation HYHitTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _blueLayer = [CALayer layer];
    _blueLayer.frame = CGRectMake(self.layerView.frame.size.width * 0.25, self.layerView.frame.size.height * 0.25, self.layerView.frame.size.width * 0.5, self.layerView.frame.size.height * 0.5);
    _blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:_blueLayer];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    /*
    CGPoint point = [touches.anyObject locationInView:self.view];
    point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
    if([self.layerView.layer containsPoint:point])
    {
        point = [self.blueLayer convertPoint:point fromLayer:self.layerView.layer];
        if([self.blueLayer containsPoint:point])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"蓝色图层点击" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [alertView show];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"白色图层点击" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
            [alertView show];
        }
    }
     */
    CGPoint point = [touches.anyObject locationInView:self.view];
    
    CALayer *layer = [self.layerView.layer hitTest:point];
    if(layer == _blueLayer)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"蓝色图层点击" message:nil delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alertView show];
    }
    else if(layer == self.layerView.layer)
    {
        [[[UIAlertView alloc] initWithTitle:@"白色图层点击" message:nil delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil] show];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goback:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
