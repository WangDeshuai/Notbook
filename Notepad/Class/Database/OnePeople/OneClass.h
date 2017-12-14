//
//  OneClass.h
//  Notepad
//
//  Created by feijiu_1 on 2017/12/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OnePeople+CoreDataClass.h"
@interface OneClass : NSObject
{
    NSManagedObjectContext *_context;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectModel *_model;
    OnePeople * _dao;
}
//连接数据库
-(void)connectSqlite;
/**
 *插入数据
 */
- (void)insertPeopleWithName:(NSString *)name Content:(NSString*)content Other:(NSString*)other;

//检索
-(NSArray*)searchAllPeople;
//更新
-(void)updateWithPeople:(OnePeople*)people;

//删除数据
- (void)deleteWithPeople:(OnePeople *)p;

-(OnePeople*)peopleName:(NSString*)name;
@end
