//
//  PeopleData.m
//  Notepad
//
//  Created by Mac on 2017/11/26.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "PeopleData.h"

@implementation PeopleData
//连接数据库
- (void)connectSqlite{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _model = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"People.sqlite"];
    NSLog(@"%@",path);
    if ([_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:path] options:nil error:nil]) {
        _context = [[NSManagedObjectContext alloc]init];
        [_context setPersistentStoreCoordinator:_persistentStoreCoordinator];
    }else{
        abort();
    }
    
    
}

/**
 *插入数据
 */
- (void)insertPeopleWithName:(NSString *)username Nickname:(NSString*)nickName Phone:(NSString*)phone Email:(NSString*)email Code:(NSString*)code Web:(NSString*)weburl Divide:(NSString*)div Other1:(NSString*)other1 Oher2:(NSString*)other2{
    
    People *p = [NSEntityDescription insertNewObjectForEntityForName:@"People" inManagedObjectContext:_context];
    p.username=username;
    p.nickname=nickName;
    p.phone=phone;
    p.email=email;
    p.code=code;
    p.website=weburl;
    p.divide=div;
    p.other1=other1;
    p.other2=other2;
    
    
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"失败》》》》》》》》》");
    }
    
    
}
//根据NumID去查询
-(NSMutableArray*)genJuPid:(NSString*)pid{
    NSArray * arr =[self searchAllPeople];
    NSMutableArray * array=[NSMutableArray new];
    for (int i = 0; i<arr.count; i++)
    {
        People * p = arr[i];
        if ([p.other1 isEqualToString:pid])
        {
            [array addObject:p];
            NSLog(@"我查Pid来了，并且加进去了");
        }
    }
    
    return array;
}
//检索
-(NSArray*)searchAllPeople
{
    NSFetchRequest * req = [[NSFetchRequest alloc]init];
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"People" inManagedObjectContext:_context];
    
    [req setEntity:entityDescription];
    
    
    NSArray * result = [_context executeFetchRequest:req error:nil];
    
    return result;
}

//更新
-(void)updateWithPeople:(People *)people
{
    NSError * error = nil;
    if (![_context save:&error]) {
        NSLog(@"更新数据失败");
    }
}
//删除
- (void)deleteWithPeople:(People *)p{
    
    [_context deleteObject:p];
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"nonono.....");
    }
    
}
/**
 *根据name去查询
 */
-(People*)peopleName:(NSString*)name{
    NSString * nameStr =[ToolClass isString:[NSString stringWithFormat:@"%@",name]];
    NSArray * arr =[self searchAllPeople];
    People * pp =nil;
    
    for (int i = 0; i<arr.count; i++)
    {
        People * p = arr[i];
        NSString * pstr =[ToolClass isString:[NSString stringWithFormat:@"%@",p.nickname]];
        if ([pstr isEqualToString:nameStr])
        {
            pp=p;
            
        }
    }
    return pp;
}
@end
