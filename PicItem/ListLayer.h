//
//  ListLayer.h
//  PicItem
//
//  Created by Ji Jim on 12/3/12.
//
//

#import "CCLayer.h"
#import "cocos2d.h"

@class LayerController;

@interface ListLayer : CCLayer{
    @private
    LayerController* layerController;
}

-(id) init: (NSMutableArray*)thumbnailList controller: (LayerController*) layerController;

@end
