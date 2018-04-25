//
//  ViewController.m
//  YTKKeyValueStore
//
//  Created by TangQiao on 10/3/14.
//  Copyright (c) 2014 TangQiao. All rights reserved.
//

#import "ViewController.h"
#import "YTKKeyValueStore.h"

@interface ViewController ()

@property(nonatomic,strong) YTKKeyValueStore *store;

@end


static  NSString *tableName = @"user_table";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 创建数据库表
- (IBAction)createDataBaseAndTableBtnClicked:(id)sender {

//    通过createTableWithName方法，我们可以在打开的数据库中创建表，如果表名已经存在，则会忽略该操作。如下所示：
    
    _store = [[YTKKeyValueStore alloc] initDBWithName:@"test.db"];
//    NSString *tableName = @"user_table";
    // 创建名为user_table的表，如果已存在，则忽略该操作
    [_store createTableWithName:tableName];
    
}

- (IBAction)deletAlldataOfATable:(id)sender {
    
    [_store clearTable:tableName];
    
}





- (IBAction)deleteBtnClicked:(id)sender {
//    删除数据接口
//
//    YTKKeyValueStore提供了以下接口用于删除数据。
//
//    // 清除数据表中所有数据
//    - (void)clearTable:(NSString *)tableName;
//
//    // 删除指定key的数据
//    - (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName;
//
//    // 批量删除一组key数组的数据
//    - (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName;
//
//    // 批量删除所有带指定前缀的数据
//    - (void)deleteObjectsByIdPrefix:(NSString *)objectIdPrefix fromTable:(NSString *)tableName;
    
    NSArray *idArray = @[@"number1",@"akey"];
//    [_store deleteObjectById:@"number1" fromTable:tableName];
    [_store deleteObjectsByIdArray:idArray fromTable:tableName];
    
}

//给创建的表中写入数据
- (IBAction)changeBtnClicked:(id)sender {
    
//    读写数据
    
    //    YTKKeyValueStore类提供key-value的存储接口，存入的所有数据需要提供key以及其对应的value，读取的时候需要提供key来获得相应的value。
    //
    //    YTKKeyValueStore类支持的value类型包括：NSString, NSNumber, NSDictionary和NSArray，为此提供了以下接口：
    //
    //    - (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName;
    //    - (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName;
    //    - (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName;
    //    与此对应，有以下value为NSString, NSNumber, NSDictionary和NSArray的读取接口：
    //
    //    - (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName;
    //    - (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName;
    //    - (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName;
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5"];
   _store = [[YTKKeyValueStore alloc] initDBWithName:@"test.db"];
    // 创建名为user_table的表，如果已存在，则忽略该操作
    [_store createTableWithName:tableName];
    //putObject:id  这个id不能是字符串,否则会报错崩溃,存字符串必须要用对应的方法才行.
//    [store2 putObject:@"zansan" withId:@"manName" intoTable:tableName];
    
//            NSDictionary *user = @{@"id": @1, @"name": @"tangqiao", @"age": @30};
    [_store putObject:array withId:@"akey" intoTable:tableName];
    
    [_store putString:@"张三" withId:@"manName" intoTable:tableName];
    
     [_store putNumber:@(5678) withId:@"number1" intoTable:tableName];
}

//查询表中写入的数据
- (IBAction)searchBtnClicked:(id)sender {
//    YTKKeyValueStore还提供了以下接口来获取表示内部存储的key-value对象。
//
//    // 获得指定key的数据
//    - (YTKKeyValueItem *)getYTKKeyValueItemById:(NSString *)objectId fromTable:(NSString *)tableName;
//    // 获得所有数据
//    - (NSArray *)getAllItemsFromTable:(NSString *)tableName;
//    由于YTKKeyValueItem类带有createdTime字段，可以获得该条数据的插入（或更新）时间，以便上层做复杂的处理（例如用来做缓存过期逻辑）。
    
    //写入数据与查询数据要用同一个_store对象,否则是查不出数据的.
   NSArray *array = [_store getObjectById:@"akey" fromTable:tableName];
    NSLog(@"array内容是%@",array);
   NSNumber * number1 = [_store getObjectById:@"number1" fromTable:tableName];
    NSLog(@"number1内容是%@",number1);
   NSArray * arrayAllData = [_store getAllItemsFromTable:tableName];
    NSLog(@"arrayAllData内容是%@",arrayAllData);
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
