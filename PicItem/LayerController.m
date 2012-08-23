//
//  LayerController.m
//  PicItem
//
//  Created by Jim Ji on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LayerController.h"

@implementation LayerController
@synthesize Model;
@synthesize Scene;
@synthesize listLayer;
@synthesize photoLayer;

//@synthesize Layers;

-(id) init{
    if( (self=[super init])) {
        // 'scene' is an autorelease object.
        Scene = [CCScene node];
        
        Model = [[PaintModel alloc]init];
        
        listLayer = [ListBarLayer node];
        [listLayer init:self];
        //    ListLayer* l = [ListLayer node];
        [Scene addChild:listLayer];
        
        for (Picture* picture in Model.Pictures) {
            // 'layer' is an autorelease object.
            PictureLayer *layer = [PictureLayer node];
            [layer initPicture:picture];
            
            // add layer as a child to scene
            [Scene addChild: layer];
        }
        
        photoLayer = [[PhotoLayer alloc]init];
        [Scene addChild: photoLayer];
        
        [((PictureLayer*)[Model getCurrentPicture].Layer) MoveFromCenterToCenter];
        //
    }
    return self;
}    


-(void) moveToPrevious{
    NSLog(@"move next");
    [((PictureLayer*)[Model getCurrentPicture].Layer) MoveFromCenterToRight];
    [((PictureLayer*)[Model getPreviousPicture].Layer) MoveFromLeftToCenter];
    [Model movePrevious];
}
-(void) moveToNext{
    NSLog(@"move next");
    [((PictureLayer*)[Model getCurrentPicture].Layer) MoveFromCenterToLeft];
    [((PictureLayer*)[Model getNextPicture].Layer) MoveFromRightToCenter];
    [Model moveNext];
}
-(void) takePhoto{
    NSLog(@"take photo");
    ((PictureLayer*)[Model getCurrentPicture].Layer).isTouchEnabled = NO;
    ((PictureLayer*)[Model getCurrentPicture].Layer).visible = NO;
    listLayer.visible = NO;

    [photoLayer initPicture:[Model getCurrentPicture]];
    photoLayer.visible = YES;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    if(Model!=nil)
        [Model release];
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
