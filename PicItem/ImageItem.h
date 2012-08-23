//
//  MyClass.h
//  PicItem
//
//  Created by  on 12-5-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface ImageItem : NSObject{
    
}

@property (nonatomic, retain)  NSString* Id;
@property  (nonatomic,assign) int X;
@property (nonatomic,assign)  int Y;
@property (nonatomic,assign)  int CenterX;
@property  (nonatomic,assign) int CenterY;
@property  (nonatomic,assign) int Width;
@property  (nonatomic,assign) int Height;
@property (nonatomic,assign) float IndexInPicture; // for display animation and zindex

@property (nonatomic,assign) int ColorR;
@property (nonatomic,assign) int ColorG;
@property (nonatomic,assign) int ColorB;



@property (nonatomic, retain)  NSString* BitmapFile;
@property (nonatomic, retain)  CCSprite* Sprite;

@end

