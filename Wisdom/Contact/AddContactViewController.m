

//
//  AddContactViewController.m
//  Wisdom
//
//  Created by Tyler on 15/12/10.
//  Copyright © 2015年 杨锦辉. All rights reserved.
//

#import "AddContactViewController.h"

#import "FMDatabase.h"
#import "XFNotices.h"

@interface AddContactViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *idField;

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *telField;

@property (weak, nonatomic) IBOutlet UITextField *faceField;

@property (nonatomic, strong) NSString *dbPath;


@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [doc stringByAppendingPathComponent:@"user.sqlite"];
    NSLog(@"path===%@",path);
    self.dbPath = path;
    
    self.operateType = 0;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (IBAction)addNewUserInfo:(id)sender {
    
    FMDatabase *db = [[FMDatabase alloc]initWithPath:self.dbPath];
    if ([db open]) {
        
        if (_idField.text.length == 0||_nameField.text.length == 0||_telField.text.length == 0||_faceField.text.length == 0){
            
            [XFNotices noticesWithTitle:@"请完成填写信息" Time:1.5 View:self.view Style:(XFNoticesStyleFail)];
        }else{
            NSLog(@"ID==%@,姓名==%@,电话==%@,头像==%@",_idField.text,_nameField.text,_telField.text,_faceField.text);
            NSString *sql= nil;
            if (self.operateType == 0){//执行插入操作
                sql = @"INSERT INTO USER (name,mobile,userImage,uid) VALUES (?,?,?,?) ";
//                sql = @"INSERT INTO USER (name,mobile,uid) VALUES (?,?,?) ";
            }else if(_operateType == 1)//执行更新操作
            {
                sql = @"UPDATE USER  SET name = ? , mobile = ? , userImage = ? where uid = ?";
                
            }
            
            NSData *imageData ;
            if ([_faceField.text isEqualToString:@"1"]) {
                UIImage *image = [UIImage imageNamed:@"icon1.jpg"];
                if (UIImagePNGRepresentation(image) == nil) {
                    imageData = UIImageJPEGRepresentation(image, 1);
                } else {
                    imageData = UIImagePNGRepresentation(image);
                }
            }else if([_faceField.text isEqualToString:@"2"]){
                UIImage *image = [UIImage imageNamed:@"icon2.jpg"];
                if (UIImagePNGRepresentation(image) == nil) {
                    imageData = UIImageJPEGRepresentation(image, 1);
                } else {
                    imageData = UIImagePNGRepresentation(image);
                }
            }else if([_faceField.text isEqualToString:@"3"]){
                UIImage *image = [UIImage imageNamed:@"icon3.jpg"];
                if (UIImagePNGRepresentation(image) == nil) {
                    imageData = UIImageJPEGRepresentation(image, 1);
                } else {
                    imageData = UIImagePNGRepresentation(image);
                }
            }else if([_faceField.text isEqualToString:@"4"]){
                UIImage *image = [UIImage imageNamed:@"icon4.jpg"];
                if (UIImagePNGRepresentation(image) == nil) {
                    imageData = UIImageJPEGRepresentation(image, 1);
                } else {
                    imageData = UIImagePNGRepresentation(image);
                }
            }else if([_faceField.text isEqualToString:@"5"]){
                UIImage *image = [UIImage imageNamed:@"icon5.jpg"];
                if (UIImagePNGRepresentation(image) == nil) {
                    imageData = UIImageJPEGRepresentation(image, 1);
                } else {
                    imageData = UIImagePNGRepresentation(image);
                }
            }
            
            
            BOOL res = [db executeUpdate:sql,_nameField.text,_telField.text,imageData,_idField.text];
//            BOOL res = [db executeUpdate:sql,_nameField.text,_telField.text,_idField.text];
            if (!res) {
                [XFNotices noticesWithTitle:@"数据插入错误" Time:1.5 View:self.view Style:(XFNoticesStyleFail)];
            }else{
                [XFNotices noticesWithTitle:@"数据插入成功" Time:1.5 View:self.view Style:(XFNoticesStyleFail)];
            }
        }
    }else{
        NSLog(@"数据库打开失败") ;
    }
    if (self.operateType == 0)//如果是添加就留在该页，如果是修改就跳回上一页
    {
        [_nameField resignFirstResponder];
        [_telField resignFirstResponder];
        [_idField resignFirstResponder];
        [_faceField resignFirstResponder];
        _nameField.text = @"";
        _idField.text = @"";
        _telField.text = @"";
        _faceField.text = @"";
    }
    [db close];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)hideKeyboard{
    [_nameField resignFirstResponder];
    [_telField resignFirstResponder];
    [_idField resignFirstResponder];
    [_faceField resignFirstResponder];
}



- (IBAction)backView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
