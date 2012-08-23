//
//  HelloWorldLayer.m
//  PicItem
//
//  Created by  on 12-5-20.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//


// Import the interfaces
#import "PictureLayer.h"

// HelloWorldLayer implementation
@implementation PictureLayer
@synthesize picture;


int dx;
int dy;

// on "init" you need to initialize your instance
-(id) init{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		// create and initialize a Label
		//CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
        
		// ask director the the window size
		//CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		//label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		//[self addChild: label];	
        
        //
        self.isTouchEnabled = NO;
        self.visible =NO;
	}
	return self;
}

// on "init" you need to initialize your instance
-(void) initPicture: (Picture*)_picture{
    picture = _picture;
    
    //ImageItems = [[NSMutableArray alloc] init];
    
    for (ImageItem* item in picture.ImageItems) {
        CCSprite* p = [CCSprite spriteWithFile:item.BitmapFile];
        p.opacity = 0;
        item.Sprite = p;
        
        [self addChild:p z:0];
        
       
        //NSLog(@"item: BitmapFile %@, x %f,y %f",item.BitmapFile,p.position.x,item.BitmapFile,p.position.y);
    }
    picture.Layer = self;
}


-(void)MoveFromCenterToCenter{
    CGSize size = [[CCDirector sharedDirector] winSize];
    dx = (size.width-picture.Width)/2;
    dy = (size.height-picture.Height)/2;

//    int j=0;
    double maxDelay=0.5;
//    double time = 0.2;
    double actionDuration = 0.3;
    double fromScale = 3.5;
    for (ImageItem* item in picture.ImageItems) {
        item.Sprite.position = ccp(item.CenterX+dx, item.CenterY+dy);
        item.Sprite.scale = fromScale;

        id delay = [CCDelayTime actionWithDuration: maxDelay/picture.ImageItems.count*item.IndexInPicture];
        
        id fade=[CCFadeIn actionWithDuration:actionDuration];
        id scale=[CCScaleTo actionWithDuration:actionDuration scale:1];
        id sequence = [CCSequence actions: delay, 
                       [CCSpawn actions:fade, scale, nil]
                       , nil, nil];
        [self reorderChild:item.Sprite z:item.IndexInPicture];

        [item.Sprite runAction:sequence];
        NSLog(@"x: %f, y: %f",item.Sprite.position.x, item.Sprite.position.y);
    }
    self.visible = YES;
    self.isTouchEnabled = YES;
}

-(void)MoveFromCenterToLeft{
    for (ImageItem* item in picture.ImageItems) {
        id fade=[CCFadeOut actionWithDuration:1.0];
        id move=[CCMoveTo actionWithDuration:0.2 position:ccp(-1024/2,item.Sprite.position.y)];
        id action = [CCSpawn actions:fade, move, nil];
        [item.Sprite runAction:action];
    }
    //self.visible = NO;
    self.isTouchEnabled = NO;
}
-(void)MoveFromCenterToRight{
    for (ImageItem* item in picture.ImageItems) {
        id fade=[CCFadeOut actionWithDuration:1.0];
        id move=[CCMoveTo actionWithDuration:0.2 position:ccp(1024*1.5,item.Sprite.position.y)];
        id action = [CCSpawn actions:fade, move, nil];
        [item.Sprite runAction:action];
    }
    //self.visible = NO;
    self.isTouchEnabled = NO;
}

-(void)MoveFromLeftToCenter{
    CGSize size = [[CCDirector sharedDirector] winSize];
    dx = (size.width-picture.Width)/2;
    dy = (size.height-picture.Height)/2;
    
    //    int j=0;
    double maxDelay=0.5;
    //    double time = 0.2;
    double actionDuration = 0.3;
    double fromScale = 3.5;
    double paperMoveDuration = 0.2;
    
    ImageItem* paper  =(ImageItem*)[picture.ImageItems objectAtIndex:0];
    for (ImageItem* item in picture.ImageItems) {
        if (item == paper) {
            //move paper
            paper.Sprite.position = ccp(-1024*0.5, paper.CenterY+dy);
            id fade=[CCFadeIn actionWithDuration:actionDuration];
            id move=[CCScaleTo actionWithDuration:actionDuration scale:1];
            id sequence = [CCSpawn actions:fade, move, nil];
            [self reorderChild:item.Sprite z:0];
            
            [item.Sprite runAction:sequence];
            
            [paper.Sprite runAction:[CCMoveTo actionWithDuration:paperMoveDuration position:ccp(paper.CenterX+dx, paper.CenterY+dy)]];
            NSLog(@"x: %f, y: %f",paper.Sprite.position.x, paper.Sprite.position.y);
        }
        
        item.Sprite.position = ccp(item.CenterX+dx, item.CenterY+dy);
        item.Sprite.scale = fromScale;
        
        id delay = [CCDelayTime actionWithDuration:paperMoveDuration + maxDelay/picture.ImageItems.count*item.IndexInPicture];
        
        id fade=[CCFadeIn actionWithDuration:actionDuration];
        id scale=[CCScaleTo actionWithDuration:actionDuration scale:1];
        id sequence = [CCSequence actions: delay, 
                       [CCSpawn actions:fade, scale, nil]
                       , nil, nil];
        [self reorderChild:item.Sprite z:item.IndexInPicture+10];
        
        [item.Sprite runAction:sequence];
        NSLog(@"x: %f, y: %f",item.Sprite.position.x, item.Sprite.position.y);
    }
    self.visible = YES;
    self.isTouchEnabled = YES;

}
-(void)MoveFromRightToCenter{
    CGSize size = [[CCDirector sharedDirector] winSize];
    dx = (size.width-picture.Width)/2;
    dy = (size.height-picture.Height)/2;
    
    //    int j=0;
    double maxDelay=0.5;
    //    double time = 0.2;
    double actionDuration = 0.3;
    double fromScale = 3.5;
    double paperMoveDuration = 0.2;
    
    ImageItem* paper  =(ImageItem*)[picture.ImageItems objectAtIndex:0];
    for (ImageItem* item in picture.ImageItems) {
        if (item == paper) {
            //move paper
            paper.Sprite.position = ccp(1024*1.5, paper.CenterY+dy);
            id fade=[CCFadeIn actionWithDuration:actionDuration];
            id move=[CCScaleTo actionWithDuration:actionDuration scale:1];
            id sequence = [CCSpawn actions:fade, move, nil];
            [self reorderChild:item.Sprite z:0];
            
            [item.Sprite runAction:sequence];
            
            [paper.Sprite runAction:[CCMoveTo actionWithDuration:paperMoveDuration position:ccp(paper.CenterX+dx, paper.CenterY+dy)]];
            NSLog(@"x: %f, y: %f",paper.Sprite.position.x, paper.Sprite.position.y);
        }
        
        item.Sprite.position = ccp(item.CenterX+dx, item.CenterY+dy);
        item.Sprite.scale = fromScale;
        
        id delay = [CCDelayTime actionWithDuration:paperMoveDuration + maxDelay/picture.ImageItems.count*item.IndexInPicture];
        
        id fade=[CCFadeIn actionWithDuration:actionDuration];
        id scale=[CCScaleTo actionWithDuration:actionDuration scale:1];
        id sequence = [CCSequence actions: delay, 
                       [CCSpawn actions:fade, scale, nil]
                       , nil, nil];
        [self reorderChild:item.Sprite z:item.IndexInPicture+10];
        
        [item.Sprite runAction:sequence];
        NSLog(@"x: %f, y: %f",item.Sprite.position.x, item.Sprite.position.y);
    }
    self.visible = YES;
    self.isTouchEnabled = YES;
}



-(void)registerWithTouchDispatcher{
    [[CCTouchDispatcher sharedDispatcher]addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

int i=0;
-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    
    //    CGPoint location = [self convertTouchToNodeSpace:touch];
    //    //[cocosGuy stopAllActions];
    //    [cocosGuy runAction: [CCMoveTo actionWithDuration:1 position:location]];
    
    CGPoint touchLocation = [touch locationInView: [touch view]];
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    ImageItem* item = [self findTouchedSprite: touchLocation];
        CCSprite* p = item.Sprite;
    if (item==nil) {
        return;
    }
    
    item.ColorR = ((i+2)*90)%255;
    item.ColorG = (i*100)%255;
    item.ColorB = (i*50)%255;
    
    [self reorderChild:p z:99];
    
    
    [p setColor:ccc3(item.ColorR,item.ColorG,item.ColorB)];  
    id sequence = [CCSequence actions:  
                      [CCScaleTo actionWithDuration:0.1 scale:0.9],
                      [CCScaleTo actionWithDuration:0.5 scale:1]
                      , nil, nil];
    CCAction* a = [CCEaseElasticOut actionWithAction:sequence]; 
    [p runAction:a];
    [self reorderChild:p z:1];
    
    i++;
}

-(ImageItem*)findTouchedSprite:(CGPoint) touchLocation{
    if (touchLocation.x<dx || touchLocation.x>dx+picture.Width) {
        return nil;
    }
    
    int x=touchLocation.x-dx;
    int y=touchLocation.y-dy;
    int p = (int)(picture.Height-y)*picture.Width+(int)(x);
    NSLog(@"picture.PixelList: %i",[picture.PixelList count]);
    if (p>=[picture.PixelList count] || p<0) {
        return nil;
    }
    
    NSNumber *i = [picture.PixelList objectAtIndex:p];
    NSLog(@"pixelList i: %i",[i integerValue]);
    
    if([i integerValue] <0){
        return nil;
    }
    
    
    NSLog(@"%@",[picture.ImageItems objectAtIndex:[i integerValue]]);
    if([i integerValue]>=picture.ImageItems.count){
        return nil;
    }
    
    return (ImageItem*)[picture.ImageItems objectAtIndex:[i integerValue]];
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    if(picture!=nil)
        [picture release];
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
