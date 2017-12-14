//
//  ClassData+CoreDataProperties.h
//  Notepad
//
//  Created by feijiu_1 on 2017/11/28.
//  Copyright © 2017年 Mac. All rights reserved.
//
//

#import "ClassData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ClassData (CoreDataProperties)

+ (NSFetchRequest<ClassData *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
