//
//  ToolClass.h
//  DistributionQuery
//
//  Created by Macx on 16/11/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolClass : NSObject


#pragma mark --个人类型转换
+(NSString*)myStype:(NSString*)str;



#pragma mark --判断是否登录（登录YES）
+(BOOL)isLogin;
#pragma mark --适配高度
+(CGFloat)cellContentViewWith;
#pragma mark --根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL;
#pragma mark --判断字符串是不是空
+(NSString*)isString:(id)str;
#pragma mark -- 拨打电话
+(void)tellPhone:(NSString*)tell;
#pragma mark --把登录返回的字典内容中nil转换成空字符串
+(NSMutableDictionary*)isDictionary:(NSDictionary*)dic;
#pragma mark --设置同一字符串 不同的颜色 不同大小
/*
 titleStr ：哪条Label要变色
 fond：要变颜色字体的大小
 color:要变成什么颜色
 numberStr：要变色的字符串
 */
+(NSMutableAttributedString *)attrStrFrom:(NSString *)titleStr intFond:(int)fond Color:(UIColor*)color numberStr:(NSString *)numberStr;

#pragma mark --Label行间距设置
/*
 默认黑色
 str:为字符串
 juli:为行间距距离
 */
+(NSMutableAttributedString *)hangJianJuStr:(NSString*)str JuLi:(int)juli;




#pragma mark -  计算内容文本的高度方法
+ (CGFloat)HeightForText:(NSString *)text withSizeOfLabelFont:(CGFloat)font withWidthOfContent:(CGFloat)contentWidth;

#pragma mark -  计算字符串长度
+ (CGFloat)WidthForString:(NSString *)text withSizeOfFont:(CGFloat)font;

#pragma mark -  json转换
+(NSString *)getJsonStringFromObject:(id)object;

#pragma mark --存储Plist文件
+(void)savePlist:(id)SaveDic name:(NSString*)plistName;
#pragma mark --读取plist文件
+(NSMutableDictionary*)duquPlistWenJianPlistName:(NSString*)plistname;
+(NSMutableArray*)duquArrayPlistWenJianPlistName:(NSString*)plistname;

#pragma mark --删除plist文件
+(void)deleagtePlistName:(NSString*)plistName;

#pragma mark --获取UUID
+(NSString*)getUUIDStr;
+(void)exitApplication;
+(void)exitApplication2;
#pragma mark --html解析
+(NSAttributedString * )HTML:(NSString*)string1;
#pragma mark --毫秒数转化为时间
+(NSString *)ConvertStrToTime:(long  long)timeStr;
@end
