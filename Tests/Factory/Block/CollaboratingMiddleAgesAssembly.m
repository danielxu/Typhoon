////////////////////////////////////////////////////////////////////////////////
//
//  58 NORTH
//  Copyright 2013 58 North
//  All Rights Reserved.
//
//  NOTICE: This software is the proprietary information of 58 North
//  Use is subject to license terms.
//
////////////////////////////////////////////////////////////////////////////////

#import "CollaboratingMiddleAgesAssembly.h"
#import "MiddleAgesAssembly.h"
#import "TyphoonCollaboratingAssemblyProxy.h"
#import "TyphoonDefinition.h"
#import "Knight.h"
#import "OCLogTemplate.h"
#import "CampaignQuest.h"


@implementation CollaboratingMiddleAgesAssembly

- (void)resolveCollaboratingAssemblies
{
    [self setQuests:[TyphoonCollaboratingAssemblyProxy proxy]];
}

- (id)knightWithExternalQuest
{
    return [TyphoonDefinition withClass:[Knight class] properties:^(TyphoonDefinition* definition)
    {
        [definition injectProperty:@selector(quest) withDefinition:[_quests environmentDependentQuest]];
    }];
}

+ (void)verifyKnightWithExternalQuest:(Knight*)knight
{
    LogTrace(@"Knight: %@", knight);

    assertThat(knight, notNilValue()); // this needs to call into a SenTestCase, not being self. Perhaps provide when initializing the assembly, and then add a new macro to OCHamcrest?
    assertThat(knight.quest, instanceOf([CampaignQuest class]));
}

- (id)knightWithExternalHardcodedQuest
{
    return [TyphoonDefinition withClass:[Knight class] properties:^(TyphoonDefinition* definition)
    {
        [definition injectProperty:@selector(quest) withDefinition:[[MiddleAgesAssembly assembly] environmentDependentQuest]]; // not revealed as problem because other tests running?
    }];
}

@end