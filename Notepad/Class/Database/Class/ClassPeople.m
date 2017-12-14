//
//  ClassPeople.m
//  Notepad
//
//  Created by feijiu_1 on 2017/11/28.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ClassPeople.h"

@implementation ClassPeople
//连接数据库
- (void)connectSqlite{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _model = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ClassData.sqlite"];
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
- (void)insertPeopleWithName:(NSString *)name{
    
    ClassData *p = [NSEntityDescription insertNewObjectForEntityForName:@"ClassData" inManagedObjectContext:_context];
    p.name=name;
    
    
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"失败》》》》》》》》》");
    }
    
    
}
//检索
-(NSArray*)searchAllPeople
{
    NSFetchRequest * req = [[NSFetchRequest alloc]init];
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"ClassData" inManagedObjectContext:_context];
    
    [req setEntity:entityDescription];
    
    
    NSArray * result = [_context executeFetchRequest:req error:nil];
    
    return result;
}

//更新
-(void)updateWithPeople:(ClassData *)people
{
    NSError * error = nil;
    if (![_context save:&error]) {
        NSLog(@"更新数据失败");
    }
}
//删除
- (void)deleteWithPeople:(ClassData *)p{
    
    [_context deleteObject:p];
    NSError *error = nil;
    if (![_context save:&error]) {
        NSLog(@"nonono.....");
    }
    
}
@end
