//
//  PeopleData.h
//  Notepad
//
//  Created by Mac on 2017/11/26.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "People+CoreDataClass.h"
@interface PeopleData : NSObject
{
    NSManagedObjectContext *_context;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectModel *_model;
    PeopleData * _dao;
}

//连接数据库
-(void)connectSqlite;
/**
 *插入数据
 */
- (void)insertPeopleWithName:(NSString *)username Nickname:(NSString*)nickName Phone:(NSString*)phone Email:(NSString*)email Code:(NSString*)code Web:(NSString*)weburl Divide:(NSString*)div Other1:(NSString*)other1 Oher2:(NSString*)other2;

//检索
-(NSArray*)searchAllPeople;
//更新
-(void)updateWithPeople:(People*)people;
//删除数据
- (void)deleteWithPeople:(People *)p;
//根据NumID去查询
-(NSMutableArray*)genJuPid:(NSString*)pid;
-(People*)peopleName:(NSString*)name;
@end
