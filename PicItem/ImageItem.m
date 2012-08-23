//
//  MyClass.m
//  PicItem
//
//  Created by  on 12-5-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageItem.h"

@implementation ImageItem

@synthesize Id;
@synthesize X;
@synthesize Y;
@synthesize CenterX;
@synthesize CenterY;
@synthesize BitmapFile;
@synthesize Sprite;
@synthesize Width;
@synthesize Height;
@synthesize IndexInPicture;
@synthesize ColorR;
@synthesize ColorG;
@synthesize ColorB;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        ColorR=255;
        ColorG=255;
        ColorB=255;
    }
    
    return self;
}

@end
