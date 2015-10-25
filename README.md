# WYLCoreDataTableView
一个基于NSFetchedResultController封装的tableView
# Getting Started
**Using [CocoaPods](http://cocoapods.org)**
 
 1.Add the pod `WYLCoreDataTableView` to your [Podfile](http://guides.cocoapods.org/using/the-podfile.html).
```ruby
pod 'WYLCoreDataTableView', '~> 1.0.3'
```

 2.Run `pod install` from Terminal, then open your app's `.xcworkspace` file to launch Xcode.
 
 3.`#import WYLCoreDataTableView.h` wherever you want to use the API.
 
 **Manually from GitHub**

1.Download the `WYLCoreDataTableView.h` and `WYLCoreDataTableView.m` files in th [Source directory](https://github.com/wangyanlong/WYLCoreDataTableView/tree/master/WYLCoreDataTableView)

2.Add both files to your Xcode project.

3.`#import WYLCoreDataTableView.h` wherever you want to use the API.

#Example Usage

**Example location**

Check out the [example project](https://github.com/wangyanlong/WYLCoreDataTableView/tree/master/WYLCoreDataTableViewDemo) included in the repository. It contains a few demos of the API in use for various scenarios. 

**Usage**

no.1 The program needs to include the CoreData related files. 

no.2 Create a entity. 

no.3 Create a list of inherited WYLCoreDataTableView

no.4 Configure the new tableView like this

objc 

	AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    CollectionTableView *ctv = [[CollectionTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"comicID" ascending:YES];
    ctv.context = app.managedObjectContext;
    ctv.sortArray = @[sortDescriptor];
    ctv.entityName = @"Comic";
    [ctv createFetchTableViewInfomation];
    
    [self.view addSubview:ctv];

no.5 Custom the new tableView delegate method like this
	
	#import "Comic.h"
	#import "CollectionTableView.h"

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

# version 1.0.2
Joined, when no data, to the user to display no data pages
#License
MIT