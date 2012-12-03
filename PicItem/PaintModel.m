//
//  PaintModel.m
//  PicItem
//
//  Created by Jim Ji on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaintModel.h"

@implementation PaintModel
@synthesize Pictures;
@synthesize ResourceList;

int currentLayerInx = 0;
int nextLayerInx = 0;
int previousLayerInx = 0;

NSMutableArray* pictureThumbnails;

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        NSData* jsonData = [NSData dataWithContentsOfFile:
                            [[NSBundle mainBundle] 
                             pathForResource:@"res"
                             ofType:@"json"]];
        NSArray *resultsArray = [jsonData objectFromJSONData];
        
        NSLog(@"%@",resultsArray);
        Pictures=[[NSMutableArray alloc] init];
        ResourceList = [[NSMutableArray alloc] init];
        
        for (NSDictionary* item in resultsArray) {
            //NSDictionary* dic = [item objectFromJSONString];
            Resource* res = [[[Resource alloc] init]autorelease];
            res.DataJsonFile = [item objectForKey:@"DataJsonFile"];
            res.PixleJsonFile = [item objectForKey:@"PixleJsonFile"];
            
            NSLog(@"DataJsonFile: %@",res.DataJsonFile);
            
            [ResourceList addObject:res];
            
            //
            Picture* pic = [[Picture alloc] init:res.DataJsonFile pixleJsonFile:res.PixleJsonFile];
            [Pictures addObject:pic];
        }
        
        pictureThumbnails = [NSMutableArray arrayWithCapacity:20];
        for (int i=0; i<30; i++) {
            [pictureThumbnails addObject:@"camera.png"];
        }
        
        [self moveNext];
        [self movePrevious];
    }
    
    return self;
}



-(Picture*)getCurrentPicture{
    return [Pictures objectAtIndex:currentLayerInx];
}
-(Picture*)getPreviousPicture{
    return [Pictures objectAtIndex:previousLayerInx];
}
-(Picture*)getNextPicture{
    return [Pictures objectAtIndex:nextLayerInx];
}

-(void)movePrevious{
    currentLayerInx = (currentLayerInx-1);
    if(currentLayerInx <0)
        currentLayerInx = Pictures.count-1;
    
    nextLayerInx = currentLayerInx+1;
    if (nextLayerInx>Pictures.count-1) {
        nextLayerInx=0;
    }
    
    previousLayerInx = currentLayerInx-1;
    if (previousLayerInx<0) {
        previousLayerInx=Pictures.count-1;
    }
}
-(void)moveNext{
    currentLayerInx = (currentLayerInx+1);
    if(currentLayerInx >Pictures.count-1)
        currentLayerInx = 0;
    
    nextLayerInx = currentLayerInx+1;
    if (nextLayerInx>Pictures.count-1) {
        nextLayerInx=0;
    }
    
    previousLayerInx = currentLayerInx-1;
    if (previousLayerInx<0) {
        previousLayerInx=Pictures.count-1;
    }
}

-(NSArray*)getPictureThumbnailList{
    
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	if(Pictures!=nil)
        [Pictures release];
    
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
