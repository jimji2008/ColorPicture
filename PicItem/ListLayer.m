//
//  ListLayer.m
//  PicItem
//
//  Created by Ji Jim on 12/3/12.
//
//

#import "ListLayer.h"

@implementation ListLayer{
    
}

// on "init" you need to initialize your instance
-(id) init: (NSMutableArray*)thumbnailList {
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        CCMenu *listMenu = [CCMenu node];

        for (NSString* thumbnailFile in thumbnailList) {
            CCSprite* p = [CCSprite spriteWithFile:thumbnailFile];
            p.opacity = 0;
            
            [self addChild:p z:0];
            
            //
            CCMenuItem *item = [CCMenuItemImage
                                                  itemFromNormalImage:thumbnailFile selectedImage:thumbnailFile
                                                  target:self selector:@selector(saveToFacebook:)];
            item.position = ccp(-40, 50);
            [listMenu addChild:item];
        }
        
        listMenu.position = ccp(800, 0);
        [self addChild:listMenu];
        
        //
        self.isTouchEnabled = NO;
        self.visible =NO;
	}
	return self;
}

@end
