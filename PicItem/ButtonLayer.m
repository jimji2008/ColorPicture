//
//  ListBarLayer.m
//  PicItem
//
//  Created by Jim Ji on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ButtonLayer.h"

@implementation ButtonLayer
@synthesize layerController;

// on "init" you need to initialize your instance
-(id) init
{
    
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite* back = [CCSprite spriteWithFile:@"desktopBg.png"];
        back.position = ccp(size.width /2 , size.height/2);
        [self addChild: back];
        

		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"list bar layer" fontName:@"Marker Felt" fontSize:64];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height );
		
		// add the label as a child to this Layer
		[self addChild: label];	
                
        //
        self.isTouchEnabled = YES;
        
	}
	return self;
}

-(void)init: (LayerController*)_controller{
    layerController = _controller;
    
    CCMenuItem *undoMenuItem = [CCMenuItemImage
                                  itemFromNormalImage:@"undo.png" selectedImage:@"undo_sel.png"
                                  target:self selector:@selector(undoButtonTapped:)];
    undoMenuItem.position = ccp(0, 50);
    
    CCMenuItem *cameraMenuItem = [CCMenuItemImage
                                  itemFromNormalImage:@"camera.png" selectedImage:@"camera_sel.png"
                                  target:self selector:@selector(cameraButtonTapped:)];
    cameraMenuItem.position = ccp(120, 50);
    
    CCMenuItem *listMenuItem = [CCMenuItemImage
                                  itemFromNormalImage:@"list.png" selectedImage:@"list_sel.png"
                                  target:self selector:@selector(listButtonTapped:)];
    listMenuItem.position = ccp(220, 50);
    
    CCMenu *starMenu = [CCMenu menuWithItems:undoMenuItem,cameraMenuItem, listMenuItem, nil];
    starMenu.position = ccp(650, 0);
    [self addChild:starMenu];
    
}


-(void)registerWithTouchDispatcher{
    [[CCTouchDispatcher sharedDispatcher]addTargetedDelegate:self priority:0 swallowsTouches:NO];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    
        CGPoint location = [self convertTouchToNodeSpace:touch];
    //    //[cocosGuy stopAllActions];
    //    [cocosGuy runAction: [CCMoveTo actionWithDuration:1 position:location]];
//    CGPoint location = [[[CCDirector sharedDirector] convertCoordinate: touch.location];
                        
//    CGPoint touchLocation = [touch locationInView: [touch view]];
//    NSLog(@"location: %f,%f",location.x,location.y);
//    NSLog(@"t1: %f,%f",touchLocation.x,touchLocation.y);
//    touchLocation = [[CCDirector sharedDirector] convertToGL: location];
//    NSLog(@"t2: %f,%f",touchLocation.x,touchLocation.y);
    CCSprite* item = [self findTouchedSprite: location];
   // NSLog(@"item:%@",item);
    if (item==nil) {
        return;
    }
    int i=0;
    [item setColor:ccc3(((i+2)*90)%255,(i*100)%255,(i*50)%255)];    
    i++;

}


-(CCSprite*)findTouchedSprite:(CGPoint) touchLocation{
    NSLog(@"tl: %f,%f",touchLocation.x,touchLocation.y);
    int i=0;
    for( CCSprite* item in self.children ) {
        NSLog(@"item%i: %@",i,item);
        NSLog(@"p:%f, %f",item.position.x,item.position.y);

        //CGPoint local = [item convertToNodeSpace:touchLocation];
        //NSLog(@"local%i: %f,%f",i,local.x,local.y);
        CGRect r = CGRectMake( item.position.x, item.position.y,
                              item.contentSize.width, item.contentSize.height);
        
        CGRect particularSpriteRect = CGRectMake(item.position.x, item.position.y, 
                                                 item.contentSize.width, item.contentSize.height);
   
//        NSLog(@"r: %@",r);
        i++;
        
        //r.origin = CGPointZero;
        if( CGRectContainsPoint( r, touchLocation ) ){
            return item;
        }
    }
    return nil;
    
}

//- (void)plusButtonTapped:(id)sender {
//    [layerController moveToNext];
//}
//- (void)minusButtonTapped:(id)sender {
//    [layerController moveToPrevious];
//}
- (void)cameraButtonTapped:(id)sender {
    [layerController takePhoto];
}

- (void)undoButtonTapped:(id)sender {
    [layerController undo];
}

- (void)listButtonTapped:(id)sender {
    [layerController undo];
}

@end
