//
//  Picture.m
//  PicItem
//
//  Created by Jim Ji on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Picture.h"

@implementation Picture
@synthesize Id;
@synthesize DataJsonFile;
@synthesize PixleJsonFile;
@synthesize ImageItems;
@synthesize PixelList;
@synthesize Height;
@synthesize Width;
@synthesize Layer;

-(id) init:(NSString*) dataJsonFile pixleJsonFile:(NSString*)pixleJsonFile{
    
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        NSData* jsonData = [NSData dataWithContentsOfFile:
                            [[NSBundle mainBundle] 
                             pathForResource:[[dataJsonFile lastPathComponent] stringByDeletingPathExtension]
                             ofType:@"json"]];
        NSArray *resultsArray = [jsonData objectFromJSONData];
        
        NSLog(@"%@",resultsArray);
        
        ImageItems = [[NSMutableArray alloc] init];
        
        assert(resultsArray.count>0);
        
        Width=0;
        Height = 0;
        
        for (NSDictionary* item in resultsArray) {
            //NSDictionary* dic = [item objectFromJSONString];
            ImageItem* imageItem = [[[ImageItem alloc] init]autorelease];
            imageItem.CenterX = [[item objectForKey:@"CenterX"] intValue];
            imageItem.CenterY = [[item objectForKey:@"CenterY"] intValue];
            imageItem.Width = [[item objectForKey:@"Width"] intValue];
            imageItem.Height = [[item objectForKey:@"Height"] intValue];
            NSInteger randomNumber = arc4random() % resultsArray.count;
            imageItem.IndexInPicture = randomNumber; 
            
            imageItem.BitmapFile = [item objectForKey:@"BitmapFile"];
            
            if (Width==0) {
                Width = imageItem.Width;
                Height = imageItem.Height;
            }
            
            imageItem.CenterY = Height-   imageItem.CenterY;
            
            [ImageItems addObject:imageItem];
            
            NSLog(@"item: BitmapFile %@, x %i,y %i",imageItem.BitmapFile,
                  imageItem.CenterX,imageItem.CenterY);
        }
        NSLog(@"ImageItems count %i",ImageItems.count);
        //
        jsonData = [NSData dataWithContentsOfFile:
                    [[NSBundle mainBundle] 
                     pathForResource:[[pixleJsonFile lastPathComponent] stringByDeletingPathExtension]
                     ofType:@"json"]];
        PixelList = [[jsonData objectFromJSONData] retain];
        NSLog(@"pixelList.count %i",PixelList.count);
        
	}
	return self;
}



-(int)findImageItemIndex:(CGPoint) position{
    int p = (int)(Height-position.y)*Width+position.x;
    if (p>=[PixelList count] || p<0) {
        return -1;
    }
    
    int index= [[PixelList objectAtIndex:p] integerValue];
    NSLog(@"pixelList i: %i",index );
    
    if(index <0){
        return -1;
    }
    
    
    NSLog(@"%@",[ImageItems objectAtIndex:index]);
    if(index>=ImageItems.count){
        return -1;
    }
    
    return index;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	if(ImageItems!=nil)
        [ImageItems release];
    
    if(PixelList!=nil)
        [PixelList release];
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
