//
//  PaintModel.h
//  PicItem
//
//  Created by Jim Ji on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"
#import "Resource.h"

@interface PaintModel : NSObject{
    
}

@property (nonatomic, retain)  NSMutableArray* Pictures;
@property (nonatomic, retain)  NSMutableArray* ResourceList;

-(Picture*)getCurrentPicture;
-(Picture*)getPreviousPicture;
-(Picture*)getNextPicture;

-(NSArray*)getPictureThumbnailList;

-(void)movePrevious;
-(void)moveNext;

@end
