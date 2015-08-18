//
//  PostTopicViewController.h
//  kindergartenApp
//  发帖
//  Created by yangyangxun on 15/7/25.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "SelectClassCell.h"
#import "BaseTopicInteractViewController.h"
#import "TopicDomain.h"

@interface PostTopicViewController :BaseTopicInteractViewController  <UITableViewDataSource,UITableViewDelegate>

@property (assign, nonatomic) KGTopicType topicType;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;
@property (strong, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (strong, nonatomic) UITableView * selectTableView;
@property (strong, nonatomic) IBOutlet UIView *topBgVIew;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnArray;

@property (nonatomic, copy) void (^PostTopicBlock)(TopicDomain * topicDomain);

- (IBAction)addImgBtnClicked:(UIButton *)sender;

@end
