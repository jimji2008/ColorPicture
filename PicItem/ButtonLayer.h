//
//  ListBarLayer.h
//  PicItem
//
//  Created by Jim Ji on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "JSONKit.h"
#import "ImageItem.h"
//#import "LayerController.h"

@class LayerController;

@interface ButtonLayer : CCLayer{
    
}

@property (nonatomic,retain) LayerController* layerController;

-(CCSprite*)findTouchedSprite:(CGPoint) touchLocation;
-(void)init:(LayerController*)_controller;

@end
