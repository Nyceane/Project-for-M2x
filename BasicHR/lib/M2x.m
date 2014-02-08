
#import "M2x.h"
#import "AFNetworking.h"


@implementation M2x

@synthesize api_key = _api_key;
@synthesize api_url = _api_url;

+ (M2x *)shared
{
    static M2x *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[M2x alloc] init];
    });
    return shared;
}


-(id)init {
    if (self = [super init]) {
        self.api_url = API_URL;
    }
    return self;
}

-(void)setApi_url:(NSString *)api_url {
    if (api_url && ![api_url isEqualToString:@""]) {
        _api_url = [api_url stringByTrimmingCharactersInSet:
                    [NSCharacterSet characterSetWithCharactersInString:@"/ "]];        
    }
}

-(NSString *)getApiUrl{
    return _api_url;
}

-(NSDate*)iSO8601ToDate:(NSString*)dateString{
    
    // Convert string  to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    return [dateFormat dateFromString:dateString];
    
}

-(NSString*)dateToISO8601:(NSDate*)date{
    
    // Convert nsdate to string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    
    return [dateFormatter stringFromDate:date];
    
}

#pragma mark - Http methods

-(void)getWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
    
    [request setValue:api_key_used forHTTPHeaderField:@"X-M2X-KEY"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = request;
    
    [manager GET:[NSString stringWithFormat:@"%@%@", [M2x shared].api_url, path] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error,[operation responseObject]);
    }];
    
}

-(void)postWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
    
    [request setValue:api_key_used forHTTPHeaderField:@"X-M2X-KEY"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = request;
    
    [manager POST:[NSString stringWithFormat:@"%@%@", [M2x shared].api_url, path] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error,[operation responseObject]);
    }];
    
}

-(void)putWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
    
    [request setValue:api_key_used forHTTPHeaderField:@"X-M2X-KEY"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = request;
    
    [manager PUT:[NSString stringWithFormat:@"%@%@", [M2x shared].api_url, path] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error,[operation responseObject]);
    }];
    
}

-(void)deleteWithPath:(NSString*)path andParameters:(NSDictionary*)parameters api_key:(NSString*)api_key_used success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
    
    [request setValue:api_key_used forHTTPHeaderField:@"X-M2X-KEY"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = request;
    
    [manager DELETE:[NSString stringWithFormat:@"%@%@", [M2x shared].api_url, path] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error,[operation responseObject]);
    }];
    
}

@end
