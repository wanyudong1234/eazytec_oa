//
//  EAUser.m
//  YXLibraryOA
//
//  Created by eazytec on 15/8/7.
//  Copyright © 2015年 Eazytec. All rights reserved.
//

#import "EAUserDefault.h"

@implementation EAUserDefault


- (instancetype)initWithLoginId:(NSString *)loginId andPassword:(NSString *)password {
    self = [super init];
    if (self) {
        self.login_id = loginId;
        self.password = password;
    }
    return self;
}

+ (instancetype)loadUserLoginHasRemember {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_LOGIN];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (void)persistenceLoginUserIntoUserDefaults: (EAUserDefault *)user {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey: USER_DEFAULTS_LOGIN];
}


+ (NSString *)loadUserLoginNameHasRemember {
    EAUserDefault *user = [self loadUserLoginHasRemember];
    
    if (user == nil) {
        return nil;
    }
    return user.login_name;
}


+ (NSString *)loadSessionIdIfUserHasLogin {
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    if([NSString isStringNil:myDelegate.sessionId]){
        return [NSString blank];
    }
    return myDelegate.sessionId;
}

+ (void)clearLoginUserInfo {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_DEFAULTS_LOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getNowTime {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    return [dateFormatter stringFromDate:currentDate];
}

///////////////////////////////////////
- (void) encodeWithCoder: (NSCoder *)coder {
    [coder encodeObject:self.login_id forKey:@"login_id"];
    [coder encodeObject:self.login_name forKey:@"login_name"];
    [coder encodeObject:self.password forKey:@"password"];
}


- (id)initWithCoder: (NSCoder *)decoder {
    if (self = [super init])
    {
        self.login_id   = [decoder decodeObjectForKey:@"login_id"];
        self.login_name = [decoder decodeObjectForKey:@"login_name"];
        self.password   = [decoder decodeObjectForKey:@"password"];
    }
    return self;
}

@end