
#import "KeysClient.h"
#import "M2x.h"

@implementation KeysClient

-(NSString *)getApiKey{
    
    if(!_feed_key || [_feed_key isEqualToString:@""]){
        return [M2x shared].api_key;
    }
    
    return _feed_key;
}

-(void)listKeysWithParameters:(NSDictionary *)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/keys";
    
    [[M2x shared] getWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)createKey:(NSDictionary *)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/keys";
    
    [[M2x shared] postWithPath:path andParameters:key api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)viewDetailsForKey:(NSString *)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@",key];
    
    [[M2x shared] getWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)updateKey:(NSString *)key withParameters:(NSDictionary *)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@",key];
    
    [[M2x shared] putWithPath:path andParameters:parameters api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)regenerateKey:(NSString *)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@/regenerate",key];
    
    [[M2x shared] postWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)deleteKey:(NSString *)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/keys/%@",key];
    
    [[M2x shared] deleteWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}


@end
