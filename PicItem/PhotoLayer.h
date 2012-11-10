//
//  PhotoLayer.h
//  PicItem
//
//  Created by Jim Ji on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "Picture.h"
//#import "LayerController.h"
#import "SHK.h"

@class LayerController;

@interface PhotoLayer : CCLayer

@property (nonatomic,retain) Picture* picture;
@property (nonatomic,retain) LayerController* layerController;

-(void) initPicture: (Picture*)_picture layerController: (LayerController*)_controller;
-(UIImage *) glToUIImage:(int)left top:(int)top right:(int)right bottom:(int)bottom;
    
@end
