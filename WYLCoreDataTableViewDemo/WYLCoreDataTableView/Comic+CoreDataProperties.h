//
//  Comic+CoreDataProperties.h
//  WYLCoreDataTableView
//
//  Created by 王老师 on 15/9/18.
//  Copyright © 2015年 wyl. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Comic.h"

NS_ASSUME_NONNULL_BEGIN

@interface Comic (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *comicID;
@property (nullable, nonatomic, retain) NSNumber *loading;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *success;

@end

NS_ASSUME_NONNULL_END
