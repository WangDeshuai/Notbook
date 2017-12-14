//
//  ClassData+CoreDataProperties.m
//  Notepad
//
//  Created by feijiu_1 on 2017/11/28.
//  Copyright © 2017年 Mac. All rights reserved.
//
//

#import "ClassData+CoreDataProperties.h"

@implementation ClassData (CoreDataProperties)

+ (NSFetchRequest<ClassData *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ClassData"];
}

@dynamic name;

@end
