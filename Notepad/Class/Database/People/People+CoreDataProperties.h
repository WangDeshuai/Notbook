//
//  People+CoreDataProperties.h
//  Notepad
//
//  Created by Mac on 2017/11/26.
//  Copyright © 2017年 Mac. All rights reserved.
//
//

#import "People+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface People (CoreDataProperties)

+ (NSFetchRequest<People *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *username;
@property (nullable, nonatomic, copy) NSString *nickname;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nullable, nonatomic, copy) NSString *code;
@property (nullable, nonatomic, copy) NSString *website;
@property (nullable, nonatomic, copy) NSString *divide;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *other1;
@property (nullable, nonatomic, copy) NSString *other2;
@property (nullable, nonatomic, copy) NSString *other3;

@end

NS_ASSUME_NONNULL_END
