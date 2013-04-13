//
//  scanIMDBViewController.h
//  AFNetworking
//
//  Created by JerryTaylorKendrick on 4/9/13.
//  Copyright (c) 2013 Jerry Taylor Kendrick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFNViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *ipAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UITableView *IMDBTable;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) IBOutlet UITextField *searchField;

- (IBAction) handleIMDBsearch:(UIButton *)sender;

@end
