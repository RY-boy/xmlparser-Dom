//
//  ViewController.m
//  xmlparserDom
//
//  Created by qingyun on 15/11/13.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "Bookmodel.h"
#import "GDataXMLNode.h"
@interface ViewController ()
@property (nonatomic,strong)NSMutableArray *bookArr;
@property (nonatomic,strong)Bookmodel *model;
@property (nonatomic,strong)NSString *tempStr;


@end

@implementation ViewController
-(void)domClick
{
    //读取xml path
    NSURL *urlPath = [[NSBundle mainBundle] URLForResource:@"bookstore" withExtension:@"xml"];
    //2xml======>Data
    NSData *data = [[NSData alloc] initWithContentsOfURL:urlPath];
    //3将datada转换成Dom树对象
    NSError *error;
    GDataXMLDocument *Document = [[GDataXMLDocument alloc]initWithData:data options:0 error:&error];
    //取出根元素
    GDataXMLElement *rootElement = [Document rootElement];
    //取出book元素
    NSArray *bArr = [rootElement elementsForName:@"book"];
    _bookArr=[NSMutableArray array];
    //元素转换成mode
    for (GDataXMLElement *element in bArr) {
        _model=[Bookmodel new];
        //取出属性
        _model.category=[[element attributeForName:@"category"] stringValue];
        //取出元素title
        GDataXMLElement *titleElement = [element elementsForName:@"title"][0];
        //titles属性 lang
        _model.lang= [[titleElement attributeForName:@"lang"] stringValue];
        _model.title = [titleElement stringValue];
        //author
        GDataXMLElement *authorElement = [element elementsForName:@"author"][0];
        _model.author=[authorElement stringValue];
        //year
        _model.year = [[element elementsForName:@"year"][0] stringValue];
        
        //price
        _model.price = [[element elementsForName:@"price"][0] stringValue];
        [_bookArr addObject:_model];
    }
    NSLog(@"======%ld",_bookArr.count);
    
}

-(void)addsubView
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [btn setTitle:@"DOM" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn addTarget:self action:@selector(domClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addsubView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
