//
//  TComicCollectionTableView.m
//  NSFetchedRequestController_TableViewDemo
//
//  Created by 王老师 on 15/9/15.
//  Copyright (c) 2015年 wyl. All rights reserved.
//

#import "CollectionTableView.h"
#import "Comic.h"

@implementation CollectionTableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Comic *c = [self.frc objectAtIndexPath:indexPath];
    cell.textLabel.text = c.name;
    
    return cell;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
