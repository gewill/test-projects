//
//  WTTableViewController.m
//  Weather
//
//  Created by Scott on 26/01/2013.
//  Updated by Joshua Greene 16/12/2013.
//
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import "WTTableViewController.h"

#import "NSDictionary+weather.h"
#import "NSDictionary+weather_package.h"

#import "UIImageView+AFNetworking.h"

static NSString *const BaseURLString =
    @"http://www.raywenderlich.com/demos/weather_sample/";

@interface WTTableViewController ()
@property(nonatomic, strong)
    NSMutableDictionary *currentDictionary; // current section being parsed
@property(nonatomic, strong)
    NSMutableDictionary *xmlWeather; // completed parsed xml response
@property(nonatomic, strong) NSString *elementName;
@property(nonatomic, strong) NSMutableString *outstring;
@property(strong) NSDictionary *weather;
@end

@implementation WTTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.toolbarHidden = NO;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)clear:(id)sender {
  self.title = @"";
  self.weather = nil;
  [self.tableView reloadData];
}

- (IBAction)jsonTapped:(id)sender {
  // 1
  NSString *string =
      [NSString stringWithFormat:@"%@weather.php?format=json", BaseURLString];
  NSURL *url = [NSURL URLWithString:string];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];

  // 2
  AFHTTPRequestOperation *operation =
      [[AFHTTPRequestOperation alloc] initWithRequest:request];
  operation.responseSerializer = [AFJSONResponseSerializer serializer];

  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
                                             id responseObject) {

    // 3
    self.weather = (NSDictionary *)responseObject;
    self.title = @"JSON Retrieved";
    [self.tableView reloadData];

  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    // 4
    UIAlertView *alertView =
        [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                   message:[error localizedDescription]
                                  delegate:nil
                         cancelButtonTitle:@"Ok"
                         otherButtonTitles:nil];
    [alertView show];
  }];

  // 5
  [operation start];
}

- (IBAction)plistTapped:(id)sender {
  NSString *string =
      [NSString stringWithFormat:@"%@weather.php?format=plist", BaseURLString];
  NSURL *url = [NSURL URLWithString:string];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];

  AFHTTPRequestOperation *operation =
      [[AFHTTPRequestOperation alloc] initWithRequest:request];

  // Make sure to set the responseSerializer correctly
  operation.responseSerializer = [AFPropertyListResponseSerializer serializer];

  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
                                             id responseObject) {

    self.weather = (NSDictionary *)responseObject;
    self.title = @"PLIST Retrieved";
    [self.tableView reloadData];

  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    UIAlertView *alertView =
        [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                   message:[error localizedDescription]
                                  delegate:nil
                         cancelButtonTitle:@"Ok"
                         otherButtonTitles:nil];
    [alertView show];
  }];

  [operation start];
}

- (IBAction)xmlTapped:(id)sender {
  NSString *string =
      [NSString stringWithFormat:@"%@weather.php?format=xml", BaseURLString];
  NSURL *url = [NSURL URLWithString:string];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];

  AFHTTPRequestOperation *operation =
      [[AFHTTPRequestOperation alloc] initWithRequest:request];

  // Make sure to set the responseSerializer correctly
  operation.responseSerializer = [AFXMLParserResponseSerializer serializer];

  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,
                                             id responseObject) {

    NSXMLParser *XMLParser = (NSXMLParser *)responseObject;
    [XMLParser setShouldProcessNamespaces:YES];

    // These lines below were previously commented
    XMLParser.delegate = self;
    [XMLParser parse];

  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    UIAlertView *alertView =
        [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                   message:[error localizedDescription]
                                  delegate:nil
                         cancelButtonTitle:@"Ok"
                         otherButtonTitles:nil];
    [alertView show];

  }];

  [operation start];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  if (!self.weather)
    return 0;

  switch (section) {
  case 0: {
    return 1;
  }
  case 1: {
    NSArray *upcomingWeather = [self.weather upcomingWeather];
    return [upcomingWeather count];
  }
  default:
    return 0;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"WeatherCell";
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                      forIndexPath:indexPath];

  NSDictionary *daysWeather = nil;

  switch (indexPath.section) {
  case 0: {
    daysWeather = [self.weather currentCondition];
    break;
  }

  case 1: {
    NSArray *upcomingWeather = [self.weather upcomingWeather];
    daysWeather = upcomingWeather[indexPath.row];
    break;
  }

  default:
    break;
  }

  cell.textLabel.text = [daysWeather weatherDescription];

  cell.textLabel.text = [daysWeather weatherDescription];

  NSURL *url = [NSURL URLWithString:daysWeather.weatherIconURL];
  UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
  [cell.imageView setImageWithURL:url placeholderImage:placeholderImage];

  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // Navigation logic may go here. Create and push another view controller.
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
  self.xmlWeather = [NSMutableDictionary dictionary];
}

- (void)parser:(NSXMLParser *)parser
    didStartElement:(NSString *)elementName
       namespaceURI:(NSString *)namespaceURI
      qualifiedName:(NSString *)qName
         attributes:(NSDictionary *)attributeDict {
  self.elementName = qName;

  if ([qName isEqualToString:@"current_condition"] ||
      [qName isEqualToString:@"weather"] ||
      [qName isEqualToString:@"request"]) {
    self.currentDictionary = [NSMutableDictionary dictionary];
  }

  self.outstring = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
  if (!self.elementName)
    return;

  [self.outstring appendFormat:@"%@", string];
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
  // 1
  if ([qName isEqualToString:@"current_condition"] ||
      [qName isEqualToString:@"request"]) {
    self.xmlWeather[qName] = @[ self.currentDictionary ];
    self.currentDictionary = nil;
  }
  // 2
  else if ([qName isEqualToString:@"weather"]) {

    // Initialize the list of weather items if it doesn't exist
    NSMutableArray *array =
        self.xmlWeather[@"weather"] ?: [NSMutableArray array];

    // Add the current weather object
    [array addObject:self.currentDictionary];

    // Set the new array to the "weather" key on xmlWeather dictionary
    self.xmlWeather[@"weather"] = array;

    self.currentDictionary = nil;
  }
  // 3
  else if ([qName isEqualToString:@"value"]) {
    // Ignore value tags, they only appear in the two conditions below
  }
  // 4
  else if ([qName isEqualToString:@"weatherDesc"] ||
           [qName isEqualToString:@"weatherIconUrl"]) {
    NSDictionary *dictionary = @{ @"value" : self.outstring };
    NSArray *array = @[ dictionary ];
    self.currentDictionary[qName] = array;
  }
  // 5
  else if (qName) {
    self.currentDictionary[qName] = self.outstring;
  }

  self.elementName = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
  self.weather = @{ @"data" : self.xmlWeather };
  self.title = @"XML Retrieved";
  [self.tableView reloadData];
}

@end