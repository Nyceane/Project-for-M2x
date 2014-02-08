
#import "FeedsClient.h"
#import "M2x.h"

@implementation FeedsClient

@synthesize feed_key=_feed_key;

-(NSString *)getApiKey{
    
    if(!_feed_key || [_feed_key isEqualToString:@""]){
        return [M2x shared].api_key;
    }
    
    return _feed_key;
}

-(void)listWithParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = @"/feeds";
    
    [[M2x shared] getWithPath:path andParameters:parameters api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)viewDetailsForFeedId:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@", feed_id];
    
    [[M2x shared] getWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)listDataStreamsForFeedId:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/streams", feed_id];
    
    [[M2x shared] getWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)listDataValuesFromTheStream:(NSString*)stream inFeed:(NSString*)feed_id WithParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/streams/%@/values",feed_id,stream];
    
    [[M2x shared] getWithPath:path andParameters:parameters api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)postDataValues:(NSDictionary*)values forStream:(NSString*)stream inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/streams/%@/values",feed_id,stream];
    
    [[M2x shared] postWithPath:path andParameters:values api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)postMultipleValues:(NSDictionary*)values inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@",feed_id];
    
    [[M2x shared] postWithPath:path andParameters:values api_key:[self getApiKey] success:success failure:failure];
    
}


-(void)readDataLocationInFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/location",feed_id];
    
    [[M2x shared] getWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)updateDatasourceWithLocation:(NSDictionary*)location inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/location",feed_id];
    
    [[M2x shared] putWithPath:path andParameters:location api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)updateDataForStream:(NSString*)stream inFeed:(NSString*)feed_id withParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/streams/%@",feed_id,stream];
    
    [[M2x shared] putWithPath:path andParameters:parameters api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)createDataForStream:(NSString*)stream inFeed:(NSString*)feed_id withParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/streams/%@",feed_id,stream];
    
    [[M2x shared] putWithPath:path andParameters:parameters api_key:[self getApiKey] success:success failure:failure];
    
}



-(void)viewDataForStream:(NSString*)stream inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/streams/%@",feed_id,stream];
    
    [[M2x shared] getWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)deleteDataStream:(NSString*)stream inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/streams/%@",feed_id,stream];
    
    [[M2x shared] deleteWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)listTriggersinFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{

    NSString *path = [NSString stringWithFormat:@"/feeds/%@/triggers",feed_id];
    
    [[M2x shared] getWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)createTrigger:(NSDictionary*)trigger inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/triggers",feed_id];
    
    [[M2x shared] postWithPath:path andParameters:trigger api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)viewTrigger:(NSString*)trigger_id inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/triggers/%@",feed_id,trigger_id];
    
    [[M2x shared] getWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)UpdateTrigger:(NSString*)trigger_id inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/triggers/%@",feed_id,trigger_id];
    
    [[M2x shared] putWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)testTrigger:(NSString*)trigger_id inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/triggers/%@/test",feed_id,trigger_id];
    
    [[M2x shared] postWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)deleteTrigger:(NSString*)trigger_id inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/triggers/%@/test",feed_id,trigger_id];
    
    [[M2x shared] postWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}

-(void)viewRequestLogForFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure{
    
    NSString *path = [NSString stringWithFormat:@"/feeds/%@/log",feed_id];
    
    [[M2x shared] getWithPath:path andParameters:nil api_key:[self getApiKey] success:success failure:failure];
    
}

@end
