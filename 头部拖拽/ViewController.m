//
//  ViewController.m
//  头部拖拽
//
//  Created by cherish on 16/4/15.
//  Copyright © 2016年 Gao_Panpan. All rights reserved.
//

#import "ViewController.h"

static NSString * identifier = @"cell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)UIImageView * image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
    tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.image= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ec9918b9dae328a7d4ecccf9ae74eea6"]];
    self.image.userInteractionEnabled = YES;
    self.image.frame = CGRectMake(0, 0, 375, 200);
    self.image.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.image];
    self.image.autoresizingMask = YES;
    UIImageView * icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ec9918b9dae328a7d4ecccf9ae74eea6"]];
    icon.frame = CGRectMake(0, 0, 80, 80);
    icon.center = CGPointMake(375/2, 100);
    icon.layer.borderWidth = 1;
    icon.layer.borderColor = [UIColor blackColor].CGColor;
    icon.layer.cornerRadius = 40;
    icon.clipsToBounds = YES;
    icon.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    [self.image addSubview:icon];

    [self gaussianBlur:self.image];
}

- (void)gaussianBlur:(UIImageView *)imageView
{
    CIContext * context = [CIContext contextWithOptions:nil];
    CIImage * cImage = [CIImage imageWithCGImage:imageView.image.CGImage];
    CIFilter * gaussian = [CIFilter filterWithName:@"CIGaussianBlur"];
    [gaussian setValue:cImage forKey:@"inputImage"];
    [gaussian setValue:@2 forKey:@"inputRadius"];
    CIImage * result = [gaussian valueForKey:@"outputImage"];
    CGImageRef imageRef = [context createCGImage:result fromRect:CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height)];
    UIImage * image = [UIImage imageWithCGImage:imageRef];
    self.image.image = image;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    if (y<-200) {
        CGRect frame = self.image.frame;
        frame.origin.y = 0;
        frame.size.height = -y;
        self.image.frame = frame;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
