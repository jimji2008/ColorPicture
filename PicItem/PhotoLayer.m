//
//  PhotoLayer.m
//  PicItem
//
//  Created by Jim Ji on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoLayer.h"

@implementation PhotoLayer
@synthesize picture;

// on "init" you need to initialize your instance
-(id) init{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        //
        CCMenuItem *saveToFacebookMenuItem = [CCMenuItemImage 
                                    itemFromNormalImage:@"ButtonPlus.png" selectedImage:@"ButtonPlusSel.png" 
                                    target:self selector:@selector(saveToFacebook:)];
        saveToFacebookMenuItem.position = ccp(-40, 100);
        CCMenuItem *saveToMenuItem = [CCMenuItemImage 
                                     itemFromNormalImage:@"ButtonMinus.png" selectedImage:@"ButtonMinusSel.png" 
                                     target:self selector:@selector(saveTo:)];
        saveToMenuItem.position = ccp(40, 100);
        
        CCMenu *starMenu = [CCMenu menuWithItems:saveToFacebookMenuItem,saveToMenuItem, nil];
        starMenu.position = ccp(906, 100);
        [self addChild:starMenu];

        //
        self.isTouchEnabled = NO;
        self.visible =NO;
	}
	return self;
}

int dx;
int dy;
-(void) initPicture: (Picture*)_picture{
    picture = _picture;

    CGSize size = [[CCDirector sharedDirector] winSize];
    dx = (size.width-picture.Width)/2;
    dy = (size.height-picture.Height)/2;

    for (ImageItem* item in picture.ImageItems) {
        CCSprite* p = [CCSprite spriteWithFile:item.BitmapFile];
        p.position = ccp(item.CenterX+dx, item.CenterY+dy);

        NSLog(@"r:%i,g:%i",item.ColorR,item.ColorG);
        [p setColor:ccc3(item.ColorR,item.ColorG,item.ColorB)];  
        [self addChild:p z:1];
        
        
        //NSLog(@"item: BitmapFile %@, x %f,y %f",item.BitmapFile,p.position.x,item.BitmapFile,p.position.y);
    }
    
//    [self takeScreenShot];
    [self captureToPhotoAlbum];
}

-(UIImage *) glToUIImage:(int)left top:(int)top right:(int)right bottom:(int)bottom {
    int width=right-left;
    int height=top-bottom;
	NSInteger myDataLength = width * height * 4;
    
	// allocate array and read pixels into it.
	GLubyte *buffer = (GLubyte *) malloc(myDataLength);
	glReadPixels(left, bottom, width, height, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
    
	// gl renders "upside down" so swap top to bottom into new array.
	// there's gotta be a better way, but this works.
	GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
	for(int y = 0; y < height; y++)
	{
		for(int x = 0; x < width * 4; x++)
		{
			buffer2[(height-1 - y) * width * 4 + x] = buffer[y * 4 * width + x];
		}
	}
    
	// make data provider with data.
	CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer2, myDataLength, NULL);
    
	// prep the ingredients
	int bitsPerComponent = 8;
	int bitsPerPixel = 32;
	int bytesPerRow = 4 * width;
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
	CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
	// make the cgimage
	CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
    
	// then make the uiimage from that
	UIImage *myImage = [UIImage imageWithCGImage:imageRef];
	return myImage;
}

-(void)captureToPhotoAlbum {
	UIImage *image = [self glToUIImage:dx top:dy+picture.Height right:dx+picture.Width bottom:dy];
	UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
}

- (void)saveToFacebook:(id)sender {
    NSLog(@"save to facebook");
}
- (void)saveTo:(id)sender {
    NSLog(@"save to ...");
}


@end
