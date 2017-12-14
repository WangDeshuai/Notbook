//
//  People+CoreDataProperties.m
//  Notepad
//
//  Created by Mac on 2017/11/26.
//  Copyright © 2017年 Mac. All rights reserved.
//
//

#import "People+CoreDataProperties.h"

@implementation People (CoreDataProperties)

+ (NSFetchRequest<People *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"People"];
}

@dynamic username;
@dynamic nickname;
@dynamic phone;
@dynamic code;
@dynamic website;
@dynamic divide;
@dynamic email;
@dynamic other1;
@dynamic other2;
@dynamic other3;

@end
