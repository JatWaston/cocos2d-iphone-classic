//
//  CCTextureCacheTest.m
//  cocos2d-ui-tests-ios
//
//  Created by Viktor on 11/12/13.
//  Copyright (c) 2013 Cocos2d. All rights reserved.
//

#import "TestBase.h"
#import "CCTextureCache.h"

@interface CCTextureCacheTest : TestBase
@property (nonatomic,strong) CCTexture* texture;
@end

@implementation CCTextureCacheTest
{
    CCNode *_spriteNode;
}

- (NSArray*) testConstructors
{
    return [NSArray arrayWithObjects:
            @"setupTextureCacheTest",
            nil];
}

- (void) setupTextureCacheTest
{
    self.subTitle = @"Tests the texture cache's retain count under ARC (check console).";
    
    CCButton* btnAdd = [CCButton buttonWithTitle:@"Load textures to cache"];
    btnAdd.positionType = CCPositionTypeNormalized;
    btnAdd.position = ccp(0.5, 0.9);
    [btnAdd setTarget:self selector:@selector(testCacheAdd:)];
    [self.contentNode addChild:btnAdd];
    
    _spriteNode = [CCNode node];
    [self.contentNode addChild:_spriteNode];
    
    CCButton* btnClear = [CCButton buttonWithTitle:@"Cache information"];
    btnClear.positionType = CCPositionTypeNormalized;
    btnClear.position = ccp(0.5, 0.8);
    [btnClear setTarget:self selector:@selector(testCacheInformation:)];
    [self.contentNode addChild:btnClear];

    CCButton* btnCreate = [CCButton buttonWithTitle:@"Create sprites"];
    btnCreate.positionType = CCPositionTypeNormalized;
    btnCreate.position = ccp(0.5, 0.7);
    [btnCreate setTarget:self selector:@selector(testCacheCreate:)];
    [self.contentNode addChild:btnCreate];

    CCButton* btnRelease = [CCButton buttonWithTitle:@"Flush unused textures"];
    btnRelease.positionType = CCPositionTypeNormalized;
    btnRelease.position = ccp(0.5, 0.6);
    [btnRelease setTarget:self selector:@selector(testCacheFlush:)];
    [self.contentNode addChild:btnRelease];
}

// add a couple of images to the cache
- (void)testCacheAdd:(id)sender
{
    [[CCTextureCache sharedTextureCache] addImage:@"Images/grossini_dance_01.png"];
    [[CCTextureCache sharedTextureCache] addImage:@"Images/grossini_dance_02.png"];
    [[CCTextureCache sharedTextureCache] addImage:@"Images/grossini_dance_03.png"];
    [[CCTextureCache sharedTextureCache] addImage:@"Images/grossini_dance_04.png"];
    [[CCTextureCache sharedTextureCache] addImage:@"Images/grossini_dance_05.png"];
}

// create a couple of sprites, with cache images
- (void)testCacheCreate:(id)sender
{
    CCSprite *sprite;
    
    [_spriteNode removeAllChildren];
    
    sprite = [CCSprite spriteWithImageNamed:@"Images/grossini_dance_01.png"];
    sprite.positionType = CCPositionTypeNormalized;
    sprite.position = ccp(0.3, 0.4);
    [_spriteNode addChild:sprite];

    sprite = [CCSprite spriteWithImageNamed:@"Images/grossini_dance_02.png"];
    sprite.positionType = CCPositionTypeNormalized;
    sprite.position = ccp(0.5, 0.4);
    [_spriteNode addChild:sprite];

    sprite = [CCSprite spriteWithImageNamed:@"Images/grossini_dance_03.png"];
    sprite.positionType = CCPositionTypeNormalized;
    sprite.position = ccp(0.7, 0.4);
    [_spriteNode addChild:sprite];

}


// show cache information
- (void)testCacheInformation:(id)sender
{
    [[CCTextureCache sharedTextureCache] dumpCachedTextureInfo];
}

// remove unused textures
- (void)testCacheFlush:(id)sender
{
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
}

@end
