//
//  AFNViewController.m
//  AFNetworking
//
//  Created by JerryTaylorKendrick on 4/9/13.
//  Copyright (c) 2013 Jerry Taylor Kendrick. All rights reserved.
//

#import "AFNViewController.h"
#import "AFNetworking.h"
#import "movieCell.h"

@interface AFNViewController ()

@end

@implementation AFNViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Setting up to handle JSON requests
    // The following method call allows for the fact that  IMDB data site does not supply an expected Content Type pair in requests.
    
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    NSURL *url = [NSURL URLWithString:@"http://static.ddmcdn.com/gif/classic-airplanes-1.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    /*
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/ip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
                 General Format of JSON requests (XML-like)
     { 
         "key": "value"
     }
     
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // Success Block code
        // This code is executed when a web service call is successful
        NSString *ipAddress = [JSON valueForKeyPath:@"origin"];
        NSLog(@"My ip address is: %@", ipAddress);
        //self.ipAddressLabel.text =  ipAddress;
        self.ipAddressLabel.text = [NSString stringWithFormat:@"External IP:%@", ipAddress];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // Failure Block code
        // This code is executed when a web service call doesn't work.
        NSLog(@"oops: %@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
    */
    
 //   AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^
 //       (UImage * image){
 //       self.imageView.image = image;
 //   }];
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image){
        self.imageView.image = image;
    }];
    
    [operation start];
}

- (IBAction) handleIMDBsearch:(id)sender {
    [self.view endEditing:YES];
    
    NSString *searchString = [NSString stringWithFormat:@"http://imdbapi.org/?type=json&title=%@&limit=10", self.searchField.text ];
    NSString *encodedString = [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodedString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
                  
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // Success Block code
        // This code is executed when a web service call is successful
        //NSLog(@"%@", JSON);
        self.movies = JSON;
        [self.IMDBTable reloadData];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // Failure Block code
        // This code is executed when a web service call doesn't work.
        NSLog(@"oops: %@", error);
        
    }];
    [operation start];
}


// A method to indicate how many rows are in the table represented by tableView
-(NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger *) section {
    return self.movies.count;
}

// Compensates for the Table View cell size
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95.0;
}

// Place items into the cells in the table represented by tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
//    NSDictionary *movie = [self.movies objectAtIndex:indexPath.row];
    
//    cell.textLabel.text = [movie valueForKey:@"title"];
//    return cell;
    
    //
    UINib *nib = [UINib nibWithNibName:@"movieCell" bundle:[NSBundle mainBundle]];
    
    //  Returns an array of all the top level objects in the Movie View
    NSArray *array = [nib instantiateWithOwner:nil options: nil];
    movieCell *cell = [array lastObject];
    
    NSDictionary *movie = [self.movies objectAtIndex:indexPath.row];
    NSString *title = [movie valueForKey:@"title"];
    id year = [movie valueForKey:@"year"];
                       
    cell.nameLabel.text = title;
    cell.yearLabel.text = [NSString stringWithFormat:@"%@", year];
    NSURL *posterURL = [NSURL URLWithString:[movie valueForKey:@"poster"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:posterURL];
    
    NSLog(@"about to load movie poster image");
    
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest: request success:^(UIImage *image){
        cell.imageView.image = image;
        [cell layoutSubviews];
    }];
        NSLog(@"movie poster image loaded");
    [operation start];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
