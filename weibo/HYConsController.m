//
//  HYConsController.m
//  weibo
//
//  Created by bala on 5/12/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYConsController.h"

@interface HYConsController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *fsView;
@property (weak, nonatomic) IBOutlet UISlider *sliderView;
@property (weak, nonatomic) IBOutlet UISwitch *swichView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
- (IBAction)progressClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIStepper *stepperView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewC;
@end

@implementation HYConsController

@synthesize fsView;
@synthesize sliderView;
@synthesize swichView;
@synthesize progressView;
@synthesize stepperView;
@synthesize datePickerView;
@synthesize pickerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(375, 2000);
    self.scrollView.backgroundColor = [UIColor darkGrayColor];
    
    self.viewC.constant = self.btn.frame.origin.y - self.view.frame.size.height + self.btn.frame.size.height;
    
    HYLogObj(NSStringFromCGRect(self.btn.frame));
    
//    [self setupFsView];
//    
//    [self setupSliderView];
//    
//    [self setupSwitchView];
//    
//    [self setupProgressView];
//    
//    [self setupStepperView];
//    
//    [self setupDatePickerView];
//    
//    [self setupPickerView];
}

- (void)setupFsView
{
    [fsView insertSegmentWithTitle:@"Three" atIndex:0 animated:YES];
    [fsView sizeToFit];
    fsView.apportionsSegmentWidthsByContent = YES;
    fsView.tintColor = [UIColor darkGrayColor];
    [fsView addTarget:self action:@selector(fsViewClick:) forControlEvents:UIControlEventValueChanged];
}

- (void)fsViewClick:(UISegmentedControl *)sender
{
    NSLog(@"%ld", sender.selectedSegmentIndex);
}

- (void)setupSliderView
{
    sliderView.maximumValueImage = [UIImage imageNamed:@"login_key"];
    [sliderView addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
    sliderView.continuous = NO;
    sliderView.minimumTrackTintColor = [UIColor redColor];
    sliderView.maximumTrackTintColor = [UIColor yellowColor];
    sliderView.thumbTintColor = [UIColor blueColor];
    [sliderView setThumbImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] forState:UIControlStateNormal];
    [sliderView setThumbImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateHighlighted];
}

- (void)sliderValueChanged
{
    NSLog(@"%f", sliderView.value);
}

- (void)setupSwitchView
{
//    swichView.onTintColor = [UIColor redColor];
//    swichView.tintColor = [UIColor blueColor];
//    swichView.thumbTintColor = [UIColor yellowColor];
    [swichView addTarget:self action:@selector(switchValueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)switchValueChanged
{
    NSLog(@"%d", swichView.on);
}

- (void)setupProgressView
{
    progressView.progress = 0;
    progressView.tintColor = [UIColor redColor];
    progressView.trackTintColor = [UIColor blackColor];
//    progressView.progressViewStyle = UIProgressViewStyleBar;
}

- (IBAction)progressClick:(id)sender {
//    progressView.progressViewStyle = UIProgressViewStyleDefault;
    static float progress = 0;
    progress += 0.1;
    progressView.progress = progress;
}

- (void)setupStepperView
{
    [stepperView addTarget:self action:@selector(stepperValueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)stepperValueChanged
{
    HYLogObj(stepperView);
}

- (void)setupDatePickerView
{
    
//    NSDateFormatter *format = [NSDateFormatter dateFormatFromTemplate:@"yyyy-MM-dd H:mm:ss" options:0 locale:[NSLocale currentLocale]];
    datePickerView.date = [NSDate date];
    datePickerView.datePickerMode = UIDatePickerModeTime;
    [datePickerView addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)datePickerValueChanged
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd H:mm:ss";
    HYLogObj([format stringFromDate:datePickerView.date]);
}

#pragma mark pickerView
- (void)setupPickerView
{
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 100;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%ld - %ld", component, row];
}

//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    
//}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
//{
//    
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"selected %ld -- %ld", component, row);
}

@end
