//
//  HYPrintObject.m
//  weibo
//
//  Created by zhangfuqiang on 15/12/8.
//  Copyright © 2015年 zhangfuqiang. All rights reserved.
//

#import "HYPrintObject.h"
#import <objc/runtime.h>

@implementation HYPrintObject

+ (NSDictionary*)getObjectData:(id)obj
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        NSString *propertyType = [NSString stringWithCString:property_getAttributes(prop) encoding:NSUTF8StringEncoding];
        NSString *propertyMethod = nil;
        if ([propertyType hasPrefix:@"TB"]) {
            while ([propertyType containsString:@","]) {
                NSRange range = [propertyType rangeOfString:@","];
                propertyType = [propertyType substringFromIndex:range.location + range.length];
            }
            if ([propertyType hasPrefix:@"G"]) {
                propertyMethod = [propertyType substringFromIndex:1];
            }
        }
        
        id value;
        if (nil != propertyMethod && [obj respondsToSelector:NSSelectorFromString(propertyMethod)]) {
            value = [NSNumber numberWithBool:[obj performSelector:NSSelectorFromString(propertyMethod)]];
        }
        else
        {
            value = [obj valueForKey:propName];
        }
        if(value == nil)
        {
            value = [NSNull null];
        }
        else
        {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}

+ (void)print:(id)obj
{
    NSLog(@"%@", [self getObjectData:obj]);
}


+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error
{
    return [NSJSONSerialization dataWithJSONObject:[self getObjectData:obj] options:options error:error];
}

+ (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}

@end
