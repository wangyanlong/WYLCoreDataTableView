//
//
//  Created by 王老师 on 15/9/15.
//  Copyright (c) 2015年 wyl. All rights reserved.
//
//  QQ:553836854

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface WYLCoreDataTableView : UITableView <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>

/*!
 *  Default FetchedResultsController.Used to coordinate with tableview query data
 */
@property (nonatomic,strong)NSFetchedResultsController *frc;

/*!
 *  Required - Used to check the additions and deletions to the managedObject
 */
@property (nonatomic,strong)NSManagedObjectContext *context;

/*!
 *  Required - FetchedResultsController's batchSize , set the number of each load
 */
@property (nonatomic,assign)NSInteger batchSize;

/*!
 *  Required - FetchedResultsController's entityName , query the data you want through entityName
 */
@property (nonatomic,strong)NSString *entityName;

/*!
 *  Optional - FetchedResultsController's cacheName , set up the data cache to improve the query efficiency.
 */
@property (nonatomic,strong)NSString *cacheName;

/*!
 *  Optional - FetchedResultsController's sectionKey , set up tableView's section
 */
@property (nonatomic,strong)NSString *sectionKey;

/*!
 *  Required - NSFetchRequest's sortArray , set the rules for the query
 */
@property (nonatomic,strong)NSArray *sortArray;

/*!
 *  Optional - NSFetchRequest's predicate , you can set query rules by predicate
 */
@property (nonatomic,strong)NSPredicate *predicate;

/*!
 *  Optional - Can move tableView's cell , default NO
 */
@property (nonatomic,assign)BOOL    canMoveRow;

/*!
 *  Optional - When the list is editing , show cell editing style type , default None
 */
@property (nonatomic,assign)UITableViewCellEditingStyle editStyle;

/*!
 *  set up FetchTableView
 */
- (void)createFetchTableViewInfomation;

@end
