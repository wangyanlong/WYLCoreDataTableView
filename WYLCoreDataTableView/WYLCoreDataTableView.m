//
//  TComicFetchTableView.m
//  NSFetchedRequestController_TableViewDemo
//
//  Created by 王老师 on 15/9/15.
//  Copyright (c) 2015年 wyl. All rights reserved.
//

#import "WYLCoreDataTableView.h"

#define iOSValue [[[UIDevice currentDevice] systemVersion] floatValue]

@interface WYLCoreDataTableView ()

/*!
 *  when tableview is none datasource , shwo this view on window
 */
@property (nonatomic,strong)UIView *noneDataView;

@end

@implementation WYLCoreDataTableView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.batchSize = 10;
        self.bounces = NO;
        self.canMoveRow = NO;
        self.isTableViewEdit = NO;
        self.isShowNoneView = NO;
        self.editStyle = UITableViewCellEditingStyleNone;
        
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [self setSeparatorInset:UIEdgeInsetsZero];
            
        }
        
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [self setLayoutMargins:UIEdgeInsetsZero];
            
        }
        
        [self addObserver:self forKeyPath:@"isShowNoneView" options:NSKeyValueObservingOptionNew context:nil];
    }

    return self;
    
}

- (void)createFetchTableViewInfomation{
    [self configureFetch];
    [self performFetch];
}

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.frc sections].count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    WYLCoreDataTableView *tb = (WYLCoreDataTableView *)tableView;
    
    NSInteger num = [[self.frc.sections objectAtIndex:section] numberOfObjects];
    
    if (num > 0 && tb.isShowNoneView){
        tb.isShowNoneView = NO;
    }else if (num == 0 && !tb.isShowNoneView){
        tb.isShowNoneView = YES;
    }
    
    return num;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [[[self.frc sections] objectAtIndex:section]name];
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.editStyle;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.canMoveRow;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        //Custom delete method
        
    }else if (editingStyle == UITableViewCellEditingStyleInsert){
    
        // Custom insertion method
        
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

#pragma mark - fetch delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
    
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    UITableView *tableView = self;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeUpdate:
            if (!newIndexPath) {
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            } else {
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
            break;
        case NSFetchedResultsChangeMove:
            
            if (iOSValue < 9.0 && iOSValue >= 8.0) {
                if (indexPath.row == newIndexPath.row && indexPath.section == newIndexPath.section) {
                    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
                    break;
                }
            }
            
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        default:
            break;
    }
    
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    BOOL new = [[change objectForKey:@"new"] boolValue];
    
    if (new) {
        [self addSubview:self.noneDataView];
    }else{
        [self.noneDataView removeFromSuperview];
    }
    
}

- (UIView *)noneDataView{
    
    if (_noneDataView) {
        return _noneDataView;
    }
    
    _noneDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _noneDataView.backgroundColor = [UIColor whiteColor];
    [_noneDataView addSubview:self.noneView];
    
    return _noneDataView;
    
}


#pragma mark - set up

- (void)performFetch{
    
    if (self.frc) {
        
        [self.context performBlockAndWait:^{
            
            int num = 0;
            
            while (num < 5) {
                if (![self.frc performFetch:nil]) {
                    NSLog(@"Fetch error");
                }else{
                    break;
                }
                num++;
            }
            
            [self reloadData];
        }];
        
    }else{
        NSLog(@"没有创建 frc");
    }
    
}

- (void)configureFetch{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityName inManagedObjectContext:self.context];
    
    [request setEntity:entity];
    
    [request setPredicate:self.predicate];
    
    if (self.sortArray.count > 0) {
        [request setSortDescriptors:self.sortArray];
    }
    
    [request setFetchBatchSize:self.batchSize];
    
    self.frc = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.context sectionNameKeyPath:self.sectionKey cacheName:self.cacheName];
    
    self.frc.delegate = self;
    
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"isShowNoneView"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
