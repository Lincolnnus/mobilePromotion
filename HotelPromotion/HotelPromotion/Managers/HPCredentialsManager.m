//
//  FTCredentialsManager.m
//  JanuaryApp
//
//  Created by Torin on 22/11/12.
//
//

#import "HPCredentialsManager.h"

@interface HPCredentialsManager()
@end

@implementation HPCredentialsManager;

+ (HPCredentialsManager*)sharedInstance
{
    static HPCredentialsManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}
     
- (void)loginAsCustomer {
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSNumber numberWithInt:1] forKey:@"uid"];
    
    [self getQueryServerPath:@"hotels/api/user.php" parameters:parameters success:^(id jsonObject) {
        NSDictionary *userDict = [jsonObject objectForKey:@"response_message"];
        NSLog(@"%@", userDict);
        self.currentUser = [[HPUser alloc] initWithDictionary:userDict];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginCustomerSucceed" object:self userInfo:nil];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)loginAsStaff {
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSNumber numberWithInt:2] forKey:@"uid"];
    
    [self getQueryServerPath:@"hotels/api/user.php" parameters:parameters success:^(id jsonObject) {
        NSDictionary *userDict = [jsonObject objectForKey:@"response_message"];
        NSLog(@"%@", userDict);
        self.currentUser = [[HPUser alloc] initWithDictionary:userDict];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginStaffSucceed" object:self userInfo:nil];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (void)updatePromotions {
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:self.currentUser.hid forKey:@"hid"];
    
    [self getQueryServerPath:@"hotels/api/promotion.php" parameters:parameters success:^(id jsonObject) {
        NSMutableArray *promotionModels = [NSMutableArray array];
        NSArray *promotionJSONs = [jsonObject objectForKey:@"response_message"];
        for (NSDictionary *dict in promotionJSONs) {
            HPPromotion *promotion = [[HPPromotion alloc] initWithDictionary:dict];
            [promotionModels addObject:promotion];
        }
        self.promotions = promotionModels;
        DLog(@"FETCH = %u", self.promotions.count);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePromotionsSucceed" object:nil];
    } failure:^(NSError *error) {
    }];
}


- (void)getQueryServerPath:(NSString*)apiSubPath
                 parameters:(NSDictionary*)parameters
                    success:(void (^)(id jsonObject))success
                    failure:(void (^)(NSError *error))failure
{
    NSURL *baseURL = [NSURL URLWithString:SERVER_ADDRESS];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    if ([apiSubPath hasPrefix:@"/"] == NO)
        apiSubPath = [NSString stringWithFormat:@"/%@", apiSubPath];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:apiSubPath parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id json)
                                         {
                                             [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                                             
                                             //Generic web service failure
                                             /*
                                              BOOL failed = [self checkWebServiceFailure:json failure:failure];
                                              if (failed)
                                              return;
                                              */
                                             //execute the block on json object instead of [json objectForKey:@"ws_data"]
                                             if (success)
                                                 success(json);
                                             
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSString *json) {
                                             [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                                             
                                             if (failure)
                                                 failure(error);
                                         }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    [queue addOperation:operation];
}


- (void)postQueryServerPath:(NSString*)apiSubPath
                 parameters:(NSDictionary*)parameters
                    success:(void (^)(id jsonObject))success
                    failure:(void (^)(NSError *error))failure
{
    NSURL *baseURL = [NSURL URLWithString:SERVER_ADDRESS];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    if ([apiSubPath hasPrefix:@"/"] == NO)
        apiSubPath = [NSString stringWithFormat:@"/%@", apiSubPath];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:apiSubPath parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id json)
                                         {
                                             [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                                             
                                             //Generic web service failure
                                             /*
                                              BOOL failed = [self checkWebServiceFailure:json failure:failure];
                                              if (failed)
                                              return;
                                              */
                                             //execute the block on json object instead of [json objectForKey:@"ws_data"]
                                             if (success)
                                                 success(json);
                                             
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSString *json) {
                                             [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
                                             
                                             if (failure)
                                                 failure(error);
                                         }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    [queue addOperation:operation];
}

@end
