//
//  RealmConfig.m
//  Readoop
//
//  Created by Marin Chitan on 21/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "RealmConfig.h"
#import <Realm/Realm.h>

@implementation RealmConfig

#define REALM_SCHEMAVERSION 0

- (void)configRealm {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    
    config.schemaVersion = REALM_SCHEMAVERSION;
    //On Realm Schema change do not any explicit physic chages to data
    config.migrationBlock = ^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {
    };
    
    //Setting default configurations
    [RLMRealmConfiguration setDefaultConfiguration:config];
    //Open a realm to apply new config
    [RLMRealm defaultRealm];
    [self logRealmPath];
    
}

- (void)logRealmPath {
    #if TARGET_IPHONE_SIMULATOR
        NSLog(@"[REALM] Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    #endif
}

@end
