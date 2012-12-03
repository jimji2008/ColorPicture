//
//  LayerController.h
//  PicItem
//
//  Created by Jim Ji on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "JSONKit.h"
#import "ImageItem.h"
#import "ButtonLayer.h"
#import "PictureLayer.h"
#import "ButtonLayer.h"
#import "PaintModel.h"
#import "PhotoLayer.h"
#import "ListLayer.h"

@interface LayerController : NSObject{

}
@property (nonatomic,retain) PaintModel* Model;
@property (nonatomic,retain) CCScene* Scene;
@property (nonatomic,retain) ButtonLayer* buttonLayer;
@property (nonatomic,retain) PhotoLayer* photoLayer;
@property (nonatomic,retain) ListLayer* listLayer;
//@property (nonatomic,retain) NSMutableArray* Layers;
// returns a CCScene that contains the HelloWorldLayer as the only child
//+(CCScene *) scene;
//+(PaintModel*) Model;

-(void) moveToPrevious;
-(void) moveToNext;
-(void) takePhoto;
-(void) undo;
-(void) closePhotoLayer;

@end
