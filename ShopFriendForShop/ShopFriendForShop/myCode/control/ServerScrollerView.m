//
//  ServerScrollerView.m
//  ShopFriendForShop
//
//  Created by Beautilut on 14-8-18.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//

#import "ServerScrollerView.h"

@implementation ServerScrollerView
@synthesize backScroller,pageController,serverArray,delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        backScroller=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [backScroller setDelegate:self];
        [backScroller setPagingEnabled:YES];
        [self addSubview:backScroller];
        pageController=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 19)];
        [pageController setCenter:CGPointMake(frame.size.width/2, frame.size.height-10)];
        [pageController setCurrentPageIndicatorTintColor:[UIColor colorWithRed:0.1 green:0.68 blue:0.86 alpha:1.0]];
        [pageController  setPageIndicatorTintColor:[UIColor grayColor]];
        [self addSubview:pageController];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame withArray:(NSArray*)array
{
    self=[super initWithFrame:frame];
    if (self) {
        backScroller=[[UIScrollView alloc] initWithFrame:frame];
        [backScroller setDelegate:self];
        [backScroller setPagingEnabled:YES];
        [self addSubview:backScroller];
        pageController=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 19)];
        
        int pageCount=array.count/8+1;
        pageController.numberOfPages=pageCount;
        pageController.currentPage=0;
        
        [backScroller setContentSize:CGSizeMake(frame.size.width*pageCount, frame.size.height)];
    }
    return self;
}
-(void)detailTheScroller:(NSArray*)array withImagePath:(NSString *)path
{
    for (id view in backScroller.subviews) {
        [view removeFromSuperview];
    }
    serverArray=array;
    int pageCount=array.count/8+1;
    if (pageCount!=1) {
        pageController.numberOfPages=pageCount;
        pageController.currentPage=0;
    }else
    {
        pageController.numberOfPages=0;
    }
    CGSize scrollFrame=backScroller.frame.size;
    [backScroller setContentSize:CGSizeMake(scrollFrame.width*pageCount, scrollFrame.height)];
    for (int onePage=0; onePage<pageCount; onePage++) {
        int section;
        if (onePage==(pageCount-1)) {
            section=array.count%8;
        }else
        {
            section=8;
        }
        for (int x=0; x<section; x++) {
            if (x<4) {
                NSDictionary*dic=[array objectAtIndex:onePage*8+x];
                ServerDetailView*aDetail=[[ServerDetailView alloc]  initWithFrame:CGRectMake(80*x+5+scrollFrame.width*onePage, 4, 70, 80)];
                [aDetail setDelegate:self];
                [aDetail setImage:path with:dic];
                [aDetail setTag:(onePage*8+x)];
                [backScroller addSubview:aDetail];
            }else
            {
                NSDictionary*dic=[array objectAtIndex:onePage*8+x];
                int next=x-4;
                ServerDetailView*aDetail=[[ServerDetailView alloc] initWithFrame:CGRectMake(80*next+5+scrollFrame.width*onePage, 89, 70, 80)];
                [aDetail setDelegate:self];
                [aDetail setImage:path with:dic];
                [aDetail setTag:(onePage*8+x)];
                [backScroller addSubview:aDetail];
            }
        }
    }
}
-(void)serverScrollViewReloadData:(NSArray *)array withImagePath:(NSString *)path
{
    for (id view in backScroller.subviews) {
            [view removeFromSuperview];
    }
    serverArray=array;
    int pageCount=array.count/8+1;
    if (pageCount!=1) {
        pageController.numberOfPages=pageCount;
        pageController.currentPage=0;
    }else
    {
        pageController.numberOfPages=0;
    }
    CGSize scrollFrame=backScroller.frame.size;
    [backScroller setContentSize:CGSizeMake(scrollFrame.width*pageCount, scrollFrame.height)];
    for (int onePage=0; onePage<pageCount; onePage++) {
        int section;
        if (onePage==(pageCount-1)) {
            section=array.count%8;
        }else
        {
            section=8;
        }
        for (int x=0; x<section; x++) {
            if (x<4) {
                NSDictionary*dic=[array objectAtIndex:onePage*8+x];
                ServerDetailView*aDetail=[[ServerDetailView alloc]  initWithFrame:CGRectMake(80*x+5+scrollFrame.width*onePage, 4, 70, 80)];
                [aDetail setDelegate:self];
                [aDetail setImage:path with:dic];
                [aDetail setTag:(onePage*8+x)];
                [backScroller addSubview:aDetail];
            }else
            {
                NSDictionary*dic=[array objectAtIndex:onePage*8+x];
                int next=x-4;
                ServerDetailView*aDetail=[[ServerDetailView alloc] initWithFrame:CGRectMake(80*next+5+scrollFrame.width*onePage, 89, 70, 80)];
                [aDetail setDelegate:self];
                [aDetail setImage:path with:dic];
                [aDetail setTag:(onePage*8+x)];
                [backScroller addSubview:aDetail];
            }
        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth=backScroller.frame.size.width;
    int page=backScroller.contentOffset.x/pageWidth;
    pageController.currentPage=page;
}
#pragma mark detail delegate
-(void)serverDetailViewTouchDown:(int)number
{
    NSDictionary*dic=[serverArray objectAtIndex:number];
    if ([delegate respondsToSelector:@selector(serverInfo:)]) {
        [delegate serverInfo:dic];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
