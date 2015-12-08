//
//  HYLabelController.m
//  weibo
//
//  Created by bala on 8/12/15.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYLabelController.h"

@interface HYLabelController ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation HYLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *text = @"驾驶证、身份证都有有效期，为啥结婚证不能有有效期?近日，某学者提出一种大胆设想：结婚证应设置7年有效期，到期自动离婚。这样能解决单身问题，还能尝试多段感情，再婚买房买车又能拉动经济增长。";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    UIFont *font = [UIFont systemFontOfSize:20];
    NSRange range = NSMakeRange(0, text.length);
    [attrStr addAttribute:NSFontAttributeName value:font range:range];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 10;
    style.paragraphSpacing = 1;
    style.lineBreakMode = NSLineBreakByWordWrapping;
    [attrStr addAttribute:NSParagraphStyleAttributeName value:style range:range];
    [attrStr addAttribute:NSBackgroundColorAttributeName value:[UIColor whiteColor] range:range];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    [attrStr addAttribute:NSLigatureAttributeName value:@(3) range:NSMakeRange(0, 5)];
    [attrStr addAttribute:NSKernAttributeName value:@(1) range:range];
    [attrStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(5, 5)];
    [attrStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(15, 5)];
    [attrStr addAttribute:NSStrokeColorAttributeName value:[UIColor blueColor] range:range];
    [attrStr addAttribute:NSStrokeWidthAttributeName value:@(5) range:NSMakeRange(20, 5)];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, 1);
    shadow.shadowBlurRadius = 1;
    shadow.shadowColor = [UIColor orangeColor];
    [attrStr addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(25, 5)];
    
    _label1.attributedText = attrStr;
    _label1.numberOfLines = 0;
    
    NSString *str = [NSString stringWithFormat:@"<div style='background-color:#F1F1F1; font-size:20px; color:#304182; text-align:center; margin-left:10px; padding-right:10px'> <p>iOS <span style='font-size:18px; color:#E88834;'>Developer</span> Tips</p> </div>"];
    NSMutableAttributedString *attrStr2 = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    _label2.attributedText = attrStr2;
}

/*
 NSMutableParagraphStyle
 @property(NS_NONATOMIC_IOSONLY) CGFloat lineSpacing;
 @property(NS_NONATOMIC_IOSONLY) CGFloat paragraphSpacing;
 @property(NS_NONATOMIC_IOSONLY) NSTextAlignment alignment;
 @property(NS_NONATOMIC_IOSONLY) CGFloat firstLineHeadIndent;
 @property(NS_NONATOMIC_IOSONLY) CGFloat headIndent;
 @property(NS_NONATOMIC_IOSONLY) CGFloat tailIndent;
 @property(NS_NONATOMIC_IOSONLY) NSLineBreakMode lineBreakMode;
 @property(NS_NONATOMIC_IOSONLY) CGFloat minimumLineHeight;
 @property(NS_NONATOMIC_IOSONLY) CGFloat maximumLineHeight;
 @property(NS_NONATOMIC_IOSONLY) NSWritingDirection baseWritingDirection;
 @property(NS_NONATOMIC_IOSONLY) CGFloat lineHeightMultiple;
 @property(NS_NONATOMIC_IOSONLY) CGFloat paragraphSpacingBefore;
 @property(NS_NONATOMIC_IOSONLY) float hyphenationFactor;
 @property(null_resettable, copy, NS_NONATOMIC_IOSONLY) NSArray<NSTextTab *> *tabStops NS_AVAILABLE(10_0, 7_0);
 @property(NS_NONATOMIC_IOSONLY) CGFloat defaultTabInterval NS_AVAILABLE(10_0, 7_0);
 @property(NS_NONATOMIC_IOSONLY) BOOL allowsDefaultTighteningForTruncation NS_AVAILABLE(10_11, 9_0);
 
 - (void)addTabStop:(NSTextTab *)anObject NS_AVAILABLE(10_0, 9_0);
 - (void)removeTabStop:(NSTextTab *)anObject NS_AVAILABLE(10_0, 9_0);
 
 - (void)setParagraphStyle:(NSParagraphStyle *)obj NS_AVAILABLE(10_0, 9_0);
 */

/*
 NSString *const NSFontAttributeName;
 NSString *const NSParagraphStyleAttributeName;
 NSString *const NSForegroundColorAttributeName;
 NSString *const NSBackgroundColorAttributeName;
 NSString *const NSLigatureAttributeName;
 NSString *const NSKernAttributeName;
 NSString *const NSStrikethroughStyleAttributeName;
 NSString *const NSUnderlineStyleAttributeName;
 NSString *const NSStrokeColorAttributeName;
 NSString *const NSStrokeWidthAttributeName;
 NSString *const NSShadowAttributeName;
 NSString *const NSTextEffectAttributeName;
 NSString *const NSAttachmentAttributeName;
 NSString *const NSLinkAttributeName;
 NSString *const NSBaselineOffsetAttributeName;
 NSString *const NSUnderlineColorAttributeName;
 NSString *const NSStrikethroughColorAttributeName;
 NSString *const NSObliquenessAttributeName;
 NSString *const NSExpansionAttributeName;
 NSString *const NSWritingDirectionAttributeName;
 NSString *const NSVerticalGlyphFormAttributeName;
 Constants
 NSFontAttributeName
 The value of this attribute is a UIFont object. Use this attribute to change the font for a range of text. If you do not specify this attribute, the string uses a 12-point Helvetica(Neue) font by default.
 
 Available in iOS 6.0 and later.
 NSParagraphStyleAttributeName
 The value of this attribute is an NSParagraphStyle object. Use this attribute to apply multiple attributes to a range of text. If you do not specify this attribute, the string uses the default paragraph attributes, as returned by the defaultParagraphStyle method of NSParagraphStyle.
 
 Available in iOS 6.0 and later.
 NSForegroundColorAttributeName
 The value of this attribute is a UIColor object. Use this attribute to specify the color of the text during rendering. If you do not specify this attribute, the text is rendered in black.
 
 Available in iOS 6.0 and later.
 NSBackgroundColorAttributeName
 The value of this attribute is a UIColor object. Use this attribute to specify the color of the background area behind the text. If you do not specify this attribute, no background color is drawn.
 
 Available in iOS 6.0 and later.
 NSLigatureAttributeName
 The value of this attribute is an NSNumber object containing an integer. Ligatures cause specific character combinations to be rendered using a single custom glyph that corresponds to those characters. The value 0 indicates no ligatures. The value 1 indicates the use of the default ligatures. The value 2 indicates the use of all ligatures. The default value for this attribute is 1. (Value 2 is unsupported on iOS.)
 
 Available in iOS 6.0 and later.
 NSKernAttributeName
 The value of this attribute is an NSNumber object containing a floating-point value. This value specifies the number of points by which to adjust kern-pair characters. Kerning prevents unwanted space from occurring between specific characters and depends on the font. The value 0 means kerning is disabled. The default value for this attribute is 0.
 
 Available in iOS 6.0 and later.
 NSStrikethroughStyleAttributeName
 The value of this attribute is an NSNumber object containing an integer. This value indicates whether the text has a line through it and corresponds to one of the constants described in “Underline and Strikethrough Style Attributes”. The default value for this attribute is NSUnderlineStyleNone.
 
 Available in iOS 6.0 and later.
 NSUnderlineStyleAttributeName
 The value of this attribute is an NSNumber object containing an integer. This value indicates whether the text is underlined and corresponds to one of the constants described in “Underline and Strikethrough Style Attributes”. The default value for this attribute is NSUnderlineStyleNone.
 
 Available in iOS 6.0 and later.
 NSStrokeColorAttributeName
 The value of this parameter is a UIColor object. If it is not defined (which is the case by default), it is assumed to be the same as the value of NSForegroundColorAttributeName; otherwise, it describes the outline color. For more details, see Drawing attributed strings that are both filled and stroked.
 
 Available in iOS 6.0 and later.
 NSStrokeWidthAttributeName
 The value of this attribute is an NSNumber object containing a floating-point value. This value represents the amount to change the stroke width and is specified as a percentage of the font point size. Specify 0 (the default) for no additional changes. Specify positive values to change the stroke width alone. Specify negative values to stroke and fill the text. For example, a typical value for outlined text would be 3.0.
 
 Available in iOS 6.0 and later.
 NSShadowAttributeName
 The value of this attribute is an NSShadow object. The default value of this property is nil.
 
 Available in iOS 6.0 and later.
 NSTextEffectAttributeName
 The value of this attribute is an NSString object. Use this attribute to specify a text effect, such as NSTextEffectLetterpressStyle. The default value of this property is nil, indicating no text effect.
 
 Available in iOS 7.0 and later.
 NSAttachmentAttributeName
 The value of this attribute is an NSTextAttachment object. The default value of this property is nil, indicating no attachment.
 
 Available in iOS 7.0 and later.
 NSLinkAttributeName
 The value of this attribute is and NSURL object (preferred) or an NSString object. The default value of this property is nil, indicating no link.
 
 Available in iOS 7.0 and later.
 NSBaselineOffsetAttributeName
 The value of this attribute is an NSNumber object containing a floating point value indicating the character’s offset from the baseline, in points. The default value is 0.
 
 Available in iOS 7.0 and later.
 NSUnderlineColorAttributeName
 The value of this attribute is a UIColor object. The default value is nil, indicating same as foreground color.
 
 Available in iOS 7.0 and later.
 NSStrikethroughColorAttributeName
 The value of this attribute is a UIColor object. The default value is nil, indicating same as foreground color.
 
 Available in iOS 7.0 and later.
 NSObliquenessAttributeName
 The value of this attribute is an NSNumber object containing a floating point value indicating skew to be applied to glyphs. The default value is 0, indicating no skew.
 
 Available in iOS 7.0 and later.
 NSExpansionAttributeName
 The value of this attribute is an NSNumber object containing a floating point value indicating the log of the expansion factor to be applied to glyphs. The default value is 0, indicating no expansion.
 
 Available in iOS 7.0 and later.
 NSWritingDirectionAttributeName
 */

@end
