//
//  OneClass.m
//  Notepad
//
//  Created by feijiu_1 on 2017/12/8.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "OneClass.h"

@implementation OneClass
//连接数据库
- (void)connectSqlite{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _model = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"OnePeople.sqlite"];
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
- (void)insertPeopleWithName:(NSString *)name Content:(NSString*)content Other:(NSString*)other
{
    
    OnePeople *p = [NSEntityDescription insertNewObjectForEntityForName:@"OnePeople" inManagedObjectContext:_context];
    p.title=name;
    p.content=content;
    p.otherstr1=other;
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"失败》》》》》》》》》");
    }
    
    
}
//检索
-(NSArray*)searchAllPeople
{
    NSFetchRequest * req = [[NSFetchRequest alloc]init];
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"OnePeople" inManagedObjectContext:_context];
    
    [req setEntity:entityDescription];
    
    
    NSArray * result = [_context executeFetchRequest:req error:nil];
    
    return result;
}

//更新
-(void)updateWithPeople:(OnePeople *)people
{
    NSError * error = nil;
    if (![_context save:&error]) {
        NSLog(@"更新数据失败");
    }
}
//删除
- (void)deleteWithPeople:(OnePeople *)p{
    
    [_context deleteObject:p];
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"nonono.....");
    }
    
}
-(OnePeople*)peopleName:(NSString*)name{
    NSString * nameStr =[ToolClass isString:[NSString stringWithFormat:@"%@",name]];
    NSArray * arr =[self searchAllPeople];
    OnePeople * pp =nil;
    
    for (int i = 0; i<arr.count; i++)
    {
        OnePeople * p = arr[i];
        NSString * pstr =[ToolClass isString:[NSString stringWithFormat:@"%@",p.title]];
        if ([pstr isEqualToString:nameStr])
        {
            pp=p;
        }
    }
    return pp;
}
@end
