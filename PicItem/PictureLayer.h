//
//  HelloWorldLayer.h
//  PicItem
//
//  Created by  on 12-5-20.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "JSONKit.h"
#import "ImageItem.h"
#import "ListBarLayer.h"
#import "PaintModel.h"
#import "LayerController.h"
//#import "ListLayer.h"

// HelloWorldLayer
@interface PictureLayer : CCLayer
{
}
@property (nonatomic,retain) Picture* picture;


-(ImageItem*)findTouchedSprite:(CGPoint) touchLocation;
-(void) initPicture: (Picture*)_picture;

-(void)MoveFromCenterToCenter;

-(void)MoveFromCenterToLeft;
-(void)MoveFromCenterToRight;

-(void)MoveFromLeftToCenter;
-(void)MoveFromRightToCenter;

@end
