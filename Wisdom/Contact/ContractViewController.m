
//
//  ContractViewController.m
//  Wisdom
//
//  Created by 杨锦辉 on 15/12/6.
//  Copyright © 2015年 杨锦辉. All rights reserved.
//

#import "ContractViewController.h"
#import "UserCell.h"

#import "XFNotices.h"
#import "FMDatabase.h"

#import "FMDatabaseQueue.h"

@interface ContractViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (retain, nonatomic) NSMutableArray *userDataArr;
@property (nonatomic, strong) NSString *paths;

@end

@implementation ContractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINib *nib = [UINib nibWithNibName:@"UserCell" bundle:[NSBundle mainBundle]];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"UserCell"];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *path = [document stringByAppendingPathComponent:@"USER.sqlite"];
    self.paths = path;
    //注意以上三句话是获取数据库路径必不可少的，在viewDidload之前就已经准备好了
    self.userDataArr = [NSMutableArray arrayWithCapacity:1];
    [self createTable];
    [self getAllDatabase];
}

//建表
- (void)createTable
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:self.paths]) {
        NSLog(@"表不存在，创建表");
        FMDatabase *db =[FMDatabase databaseWithPath:self.paths];
        if ([db open]) {
            NSString *sql = @"CREATE TABLE 'USER'('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'name' VARCHAR(20),'mobile' VARCHAR(50),'userImage' BLOB,'uid' VARCHAR(100))    ";//sql语句
//              NSString *sql = @"CREATE TABLE 'USER'('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'name' VARCHAR(20),'mobile' VARCHAR(50),'uid' VARCHAR(100))    ";//sql语句
            BOOL success = [db executeUpdate:sql];
            if (!success) {
                NSLog(@"error when create table ");
            }else{
                NSLog(@"create table succeed");
            }
            [db close];
        }else{
            NSLog(@"database open error");
        }
    }
}

//查数据
- (void)getAllDatabase//从数据库中获得所有数据
{
    FMDatabase *db = [FMDatabase databaseWithPath:self.paths];
    if ([db open]) {
        NSString *sql = @"SELECT * FROM USER";
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *name = [rs stringForColumn:@"name"];
            NSString *mobile = [rs stringForColumn:@"mobile"];
            NSData *userImage = [rs dataForColumn:@"userImage"];
            NSString *uid = [rs stringForColumn:@"uid"];
            
            NSDictionary *dic = @{
                                  @"name":name,
                                  @"mobile":mobile,
                                  @"userImage":userImage,
                                  @"uid":uid
                                  };
            [self.userDataArr addObject:dic];
        }
        
        NSLog(@"查询到的用户数据：%@",self.userDataArr);
        [db close];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableview reloadData];
    });
}


#pragma mark 表格代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _userDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    if (self.userDataArr.count>0) {
        NSDictionary *dic = self.userDataArr[indexPath.row];
        cell.uid.text = dic[@"uid"];
        cell.name.text = dic[@"name"];
        cell.mobile.text = dic[@"mobile"];
        NSData *data = [NSData new];
        data = (NSData *)dic[@"userImage"];
        UIImage *image = [UIImage imageWithData:data];
        cell.faceImage.image = image;        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
