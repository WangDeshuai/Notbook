//
//  OnePeople+CoreDataProperties.m
//  Notepad
//
//  Created by feijiu_1 on 2017/12/8.
//  Copyright © 2017年 Mac. All rights reserved.
//
//

#import "OnePeople+CoreDataProperties.h"

@implementation OnePeople (CoreDataProperties)

+ (NSFetchRequest<OnePeople *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"OnePeople"];
}

@dynamic content;
@dynamic title;
@dynamic otherstr1;
@dynamic otherstr2;

@end
