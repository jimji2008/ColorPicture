//
//  Picture.h
//  PicItem
//
//  Created by Jim Ji on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageItem.h"
#import "JSONKit.h"
#import "cocos2d.h"
//#import "HelloWorldLayer.h"

@interface Picture : NSObject{
    
}

@property (nonatomic, retain)  NSString* Id;

@property (nonatomic, retain)  NSString* DataJsonFile;
@property (nonatomic, retain)  NSString* PixleJsonFile;

@property (nonatomic, retain)  NSMutableArray* ImageItems;
@property (nonatomic, retain)  NSArray* PixelList;
@property (nonatomic, retain)  CCLayer* Layer;

@property (nonatomic, assign)  int Width;
@property (nonatomic, assign)  int Height;



-(id) init:(NSString*) dataJsonFile pixleJsonFile:(NSString*)pixleJsonFile;

@end
