//
//  PhotoLayer.h
//  PicItem
//
//  Created by Jim Ji on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "Picture.h"

@interface PhotoLayer : CCLayer

@property (nonatomic,retain) Picture* picture;

-(void) initPicture: (Picture*)_picture;
-(UIImage *) glToUIImage:(int)left top:(int)top right:(int)right bottom:(int)bottom;
    
@end
