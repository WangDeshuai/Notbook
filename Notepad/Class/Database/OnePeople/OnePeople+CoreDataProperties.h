//
//  OnePeople+CoreDataProperties.h
//  Notepad
//
//  Created by feijiu_1 on 2017/12/8.
//  Copyright © 2017年 Mac. All rights reserved.
//
//

#import "OnePeople+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface OnePeople (CoreDataProperties)

+ (NSFetchRequest<OnePeople *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *otherstr1;
@property (nullable, nonatomic, copy) NSString *otherstr2;

@end

NS_ASSUME_NONNULL_END
