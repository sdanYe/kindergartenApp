//
//  RecipesInfoView.m
//  kindergartenApp
//
//  Created by yangyangxun on 15/8/8.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "RecipesInfoView.h"
#import "RecipesItemVO.h"
#import "RecipesHeadTableViewCell.h"
#import "UIColor+Extension.h"
#import "RecipesStudentInfoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "KGTextView.h"
#import "TopicInteractionView.h"
#import "UIView+Extension.h"
#import "UUImageAvatarBrowser.h"
#import "UIButton+Extension.h"
#import <objc/runtime.h>
#import "CookbookDomain.h"

#define RecipesInfoCellIdentifier  @"RecipesInfoCellIdentifier"
#define RecipesNoteCellIdentifier  @"RecipesNoteCellIdentifier"

@implementation RecipesInfoView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initTableView];
    }
    
    return self;
}

- (void)initTableView {
    recipesTableView = [[UITableView alloc] initWithFrame:CGRectMake(Number_Zero, Number_Zero, self.width, APPWINDOWHEIGHT-APPWINDOWTOPHEIGHTIOS7)];
    recipesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    recipesTableView.separatorColor = [UIColor clearColor];
    recipesTableView.delegate   = self;
    recipesTableView.dataSource = self;
    [self addSubview:recipesTableView];
    
    self.backgroundColor = [UIColor yellowColor];
}


- (NSMutableArray *)tableDataSource {
    if(!_tableDataSource) {
        _tableDataSource = [[NSMutableArray alloc] init];
    }
    return _tableDataSource;
}


//加载食谱数据
- (void)loadRecipesData:(RecipesDomain *)recipes {
    _recipesDomain = recipes;
    
    if (!_recipesDomain.isReqSuccessData) {
        PromptView * pView = [[[NSBundle mainBundle] loadNibNamed:@"PromptView" owner:nil options:nil] lastObject];
        pView.size = CGSizeMake(APPWINDOWWIDTH, 80);
        pView.origin = CGPointMake(0, 80);
        [recipesTableView addSubview:pView];
    }
    
    [self packageTableData];
    [recipesTableView reloadData];
}

- (void)packageTableData {
    [self.tableDataSource removeAllObjects];
    
    RecipesItemVO * itemVO1 = [[RecipesItemVO alloc] initItemVO:_recipesDomain.plandate cbArray:nil];
    [self.tableDataSource addObject:itemVO1];
    
    if(_recipesDomain.list_time_1 && [_recipesDomain.list_time_1 count]>Number_Zero) {
        RecipesItemVO * itemVO2 = [[RecipesItemVO alloc] initItemVO:@"早餐" cbArray:_recipesDomain.list_time_1];
        [self.tableDataSource addObject:itemVO2];
    }
    
    if(_recipesDomain.list_time_2 && [_recipesDomain.list_time_2 count]>Number_Zero) {
        RecipesItemVO * itemVO3 = [[RecipesItemVO alloc] initItemVO:@"早上加餐" cbArray:_recipesDomain.list_time_2];
        [self.tableDataSource addObject:itemVO3];
    }
    
    if(_recipesDomain.list_time_3 && [_recipesDomain.list_time_3 count]>Number_Zero) {
        RecipesItemVO * itemVO4 = [[RecipesItemVO alloc] initItemVO:@"午餐" cbArray:_recipesDomain.list_time_3];
        [self.tableDataSource addObject:itemVO4];
    }
    
    if(_recipesDomain.list_time_4 && [_recipesDomain.list_time_4 count]>Number_Zero) {
        RecipesItemVO * itemVO5 = [[RecipesItemVO alloc] initItemVO:@"下午加餐" cbArray:_recipesDomain.list_time_4];
        [self.tableDataSource addObject:itemVO5];
    }
    
    if(_recipesDomain.list_time_5 && [_recipesDomain.list_time_5 count]>Number_Zero) {
        RecipesItemVO * itemVO6 = [[RecipesItemVO alloc] initItemVO:@"晚餐" cbArray:_recipesDomain.list_time_5];
        [self.tableDataSource addObject:itemVO6];
    }
    
    RecipesItemVO * itemVO7 = [[RecipesItemVO alloc] initItemVO:@"营养分析" cbArray:nil];
    [self.tableDataSource addObject:itemVO7];
}


#pragma UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableDataSource count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Number_One;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == Number_Zero) {
        return 15;
    } else {
        return 30;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section!=Number_Zero && _recipesDomain.isReqSuccessData) {
        RecipesItemVO * itemVO = [self.tableDataSource objectAtIndex:section];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RecipesHeadTableViewCell" owner:nil options:nil];
        RecipesHeadTableViewCell * view = (RecipesHeadTableViewCell *)[nib objectAtIndex:Number_Zero];
        [view resetHead:itemVO.headStr];
        view.backgroundColor = KGColorFrom16(0xE7E7EE);
        return view;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == Number_Zero) {
        //学生基本信息
        return [self loadStudentInfoCell:tableView cellForRowAtIndexPath:indexPath];
    } else if(indexPath.section == [self.tableDataSource count]-Number_One){
        return [self loadRecipesNote:tableView];
    } else {
        return [self loadRecipesCell:tableView cellForRowAtIndexPath:indexPath];
    }
}


- (UITableViewCell *)loadStudentInfoCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecipesStudentInfoTableViewCell * cell = [RecipesStudentInfoTableViewCell cellWithTableView:tableView];
    cell.backgroundColor = KGColorFrom16(0xff4966);
    [cell resetCellParam:_recipesDomain];
    return cell;
}


- (UITableViewCell *)loadRecipesCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:RecipesInfoCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecipesInfoCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    RecipesItemVO * itemVO = [self.tableDataSource objectAtIndex:indexPath.section];
    [self loadRecipes:itemVO cell:cell];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == Number_Zero) {
        return 59;
    } else if (indexPath.section == [self.tableDataSource count]-Number_One) {
        return 380;
    } else {
        RecipesItemVO * itemVO = [self.tableDataSource objectAtIndex:indexPath.section];
        NSInteger total = [itemVO.cookbookArray count];
        NSInteger pageSize = Number_Three;
        NSInteger page = (total + pageSize - Number_One) / pageSize;
        return 70 * page;
    }
}

//加载菜谱
- (void)loadRecipes:(RecipesItemVO *)recipesVO cell:(UITableViewCell *)cell {
    CGRect frame = CGRectMake(CELLPADDING, Number_Zero, CELLCONTENTWIDTH, cell.height);
    UIView * recipesImgsView = [[UIView alloc] initWithFrame:frame];
    
    CGFloat w = (frame.size.width - CELLPADDING * Number_Two) / Number_Three;
    CGFloat h = 70;
    CGFloat index = Number_Zero;
    CGFloat row   = Number_Zero;
    
    UIImageView * imageView = nil;
    UIButton    * btn = nil;
    for(CookbookDomain * cookbook in recipesVO.cookbookArray) {
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CELLPADDING + index * w, row * h, w, h)];
        imageView.backgroundColor = [UIColor clearColor];
        [imageView setClipsToBounds:YES];
        [imageView setContentMode:UIViewContentModeScaleToFill];
        [recipesImgsView addSubview:imageView];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:cookbook.img] placeholderImage:nil options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        
        btn = [[UIButton alloc] initWithFrame:CGRectMake(index * w, imageView.y, w, h)];
        btn.targetObj = imageView;
        objc_setAssociatedObject(btn, "cookbook", cookbook, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [btn addTarget:self action:@selector(showRecipesImgClicked:) forControlEvents:UIControlEventTouchUpInside];
        [recipesImgsView addSubview:btn];
        
        index++;
        
        if(index == Number_Three) {
            index = Number_Zero;
            row++;
        }
    }
    
    frame.size.height = CGRectGetMaxY(imageView.frame);
    recipesImgsView.frame = frame;
    
    [cell addSubview:recipesImgsView];
}

//加载营养分析及帖子回复
- (UITableViewCell *)loadRecipesNote:(UITableView *)tableView {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:RecipesNoteCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecipesNoteCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor clearColor];
    
    if(_recipesDomain.isReqSuccessData) {
        KGTextView * textView = [[KGTextView alloc] initWithFrame:CGRectMake(CELLPADDING, Number_Five, CELLCONTENTWIDTH, 150)];
        [textView setBorderWithWidth:Number_One color:[UIColor blackColor] radian:Number_Five];
        textView.text = _recipesDomain.analysis;
        textView.editable = NO;
        [cell addSubview:textView];
        
        topicViewCell = cell;
        [self loadDZReplyView];
    }
    
    return cell;
}

//加载点赞回复
- (void)loadDZReplyView {
    if(topicView) {
        [topicView removeFromSuperview];
    }
    TopicInteractionDomain * topicInteractionDomain = [TopicInteractionDomain new];
    topicInteractionDomain.dianzan   = _recipesDomain.dianzan;
    topicInteractionDomain.replyPage = _recipesDomain.replyPage;
    topicInteractionDomain.topicType = Topic_Recipes;
    topicInteractionDomain.topicUUID = _recipesDomain.uuid;
    
    TopicInteractionFrame * topicFrame = [TopicInteractionFrame new];
    topicFrame.topicInteractionDomain  = topicInteractionDomain;
    
    CGRect frame = CGRectMake(Number_Zero, 160, KGSCREEN.size.width, topicFrame.topicInteractHeight);
    topicView = [[TopicInteractionView alloc] initWithFrame:frame];
    [topicViewCell addSubview:topicView];
    topicView.topicInteractionFrame = topicFrame;
}

- (void)showRecipesImgClicked:(UIButton *)sender{
    UIImageView * imageView = (UIImageView *)sender.targetObj;
    CookbookDomain * cookbook = objc_getAssociatedObject(sender, "cookbook");
    [UUImageAvatarBrowser showImage:imageView url:cookbook.img];
}

//重置回复内容
- (void)resetTopicReplyContent:(ReplyDomain *)domain {
    //1.对应食谱增加回复
    ReplyPageDomain * replyPageDomain = _recipesDomain.replyPage;
    if(!replyPageDomain) {
        replyPageDomain = [[ReplyPageDomain alloc] init];
    }
    [replyPageDomain.data insertObject:domain atIndex:Number_Zero];
    
    //2.重新加载点赞回复view
    [self loadDZReplyView];
}

@end
