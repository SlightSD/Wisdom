//
//  UserCell.h
//  Wisdom
//
//  Created by Tyler on 15/12/10.
//  Copyright © 2015年 杨锦辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *uid;

@property (weak, nonatomic) IBOutlet UIImageView *faceImage;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *mobile;

@end
