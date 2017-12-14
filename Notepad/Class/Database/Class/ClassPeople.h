//
//  ClassPeople.h
//  Notepad
//
//  Created by feijiu_1 on 2017/11/28.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClassData+CoreDataClass.h"
@interface ClassPeople : NSObject
{
    NSManagedObjectContext *_context;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectModel *_model;
    ClassPeople * _dao;
}
//连接数据库
-(void)connectSqlite;
/**
 *插入数据
 */
- (void)insertPeopleWithName:(NSString *)name;

//检索
-(NSArray*)searchAllPeople;
//更新
-(void)updateWithPeople:(ClassData*)people;
//删除数据
- (void)deleteWithPeople:(ClassData *)p;
@end
