
#import <Foundation/Foundation.h>
#import "M2x.h"

typedef void (^M2XAPIClientSuccessObject)(id object);
typedef void (^M2XAPIClientFailureError)(NSError *error,NSDictionary *message);

@interface FeedsClient : NSObject

///------------------------------------
/// @List/Search Feeds
///------------------------------------

/**
 The list of feeds can be filtered by using one or more of the following parameters:
 
 "q": Text to search (optional). Only those feeds containing this text in its name or description will be returned.
 "type" (optional): If passed, only feeds of this type will be returned. Possible values are "blueprint", "batch" and "datasource".
 "page": Page number to be retrieved.
 "limit": Number of feeds to return per page.
 "tags" A comma delimited tags list.
 
 Feeds can be searched by location by using the parameters below:
 
 "latitude"
 "longitude"
 "distance" a numeric value specified in distance_units.
 "distance_unit" either mi, miles or km.
 */
-(void)listWithParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @View Feed Details
///------------------------------------

/**
 Get details of an existing feed.
*/
-(void)viewDetailsForFeedId:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @List Data Streams
///------------------------------------

/**
 Retrieve list of data streams associated with the specified feed.
 */
-(void)listDataStreamsForFeedId:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @List Data Stream Values
///------------------------------------

/**
 List values from an existing data stream associated with a specific feed, sorted in reverse chronological order (most recent values first).
 
 The values can be filtered by using one or more of the following parameters:
 
 "start" (optional)
 "end" (optional)
 "limit" (optional)
 */
-(void)listDataValuesFromTheStream:(NSString*)stream inFeed:(NSString*)feed_id WithParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @Post Data Stream Values
///------------------------------------

/**
 Post values to an existing data stream associated with a specific feed.
 Values are passed in a values array and can be optionally timestamped. If no timestamp is specified, the current time of the API server is used.
 
 Accepted attributes for each element in the array:
 
 "at" (optional)
 "value" (required)
 i.e.:
 NSDictionary *values = @{ @"values": @[
    @{ @"at": @"2013-09-09T19:15:00Z", @"value": @"32" },
    @{ @"at": @"2013-09-09T20:15:00Z", @"value": @"30" },
    @{ "value": "15" } ] };
 */
-(void)postDataValues:(NSDictionary*)values forStream:(NSString*)stream inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @Post values to multiple streams at once.
///------------------------------------

/**
 Post values to an existing data stream associated with a specific feed.
 Values are passed in a values array and can be optionally timestamped. If no timestamp is specified, the current time of the API server is used.
 
 Accepted attributes for each element in the array:
 
 "at" (optional)
 "value" (required)
 i.e.:
 NSDictionary *values = @{ @"values": 
    @{ @"temperature": @[
        @{ @"at": @"2013-09-09T19:15:00Z", @"value": @"32" },
        @{ @"at": @"2013-09-09T20:15:00Z", @"value": @"30" },
        @{ @"value": @"15" } ],
       @"humidity": @[
    @{ @"at": @"2013-09-09T19:15:00Z", @"value": @"88" },
    @{ @"at": @"2013-09-09T20:15:00Z", @"value": @"60" },
    @{ @"value": @"75" } ]
    }
 }
 */
-(void)postMultipleValues:(NSDictionary*)values inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @Read Datasource Location
///------------------------------------

/**
 Get location details of the datasource associated with a specific feed.
 */
-(void)readDataLocationInFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @Update Datasource Location
///------------------------------------
    
/**
 Update the current location of the datasource associated with the specified feed. Accepts the following parameters:
 
 "name" a name identifying this location (optional).
 "latitude" (required)
 "longitude" (required)
 "elevation" (optional)
 */
-(void)updateDatasourceWithLocation:(NSDictionary*)location inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @Update Data Stream
///------------------------------------

/**
 Update a data stream associated with the specified feed (if a stream with this name does not exist it gets created).
 */
-(void)updateDataForStream:(NSString*)stream inFeed:(NSString*)feed_id withParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @Create Data Stream
///------------------------------------

/**
 Create a data stream associated with the specified feed.
 */
-(void)createDataForStream:(NSString*)stream inFeed:(NSString*)feed_id withParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @View Data Stream
///------------------------------------

/**
 Get details of a specific data stream associated with an existing feed.
 */
-(void)viewDataForStream:(NSString*)stream inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @Delete Data Stream
///------------------------------------

/**
 Delete an existing data stream associated with a specific feed.
 */
-(void)deleteDataStream:(NSString*)stream inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @List Triggers
///------------------------------------

/**
 Retrieve list of triggers associated with the specified feed.
 */
-(void)listTriggersinFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @Create Trigger
///------------------------------------

/**
 Create a new trigger associated with the specified feed.
 
 i.e.:
 NSDictionary *trigger = @{ @"name": @"trigger1",
    @"stream": @"temperature",
    @"condition": @">",
    @"value": @"30",
    @"callback_url": @"http://example.com",
    @"status": @"enabled" };
 */
-(void)createTrigger:(NSDictionary*)trigger inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @View Trigger
///------------------------------------

/**
 Get details of a specific trigger associated with an existing feed.
 */
-(void)viewTrigger:(NSString*)trigger_id inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @Update Trigger
///------------------------------------

/**
 Update an existing trigger associated with the specified feed.
 */
-(void)UpdateTrigger:(NSString*)trigger_id inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @Test Trigger
///------------------------------------

/**
 Test the specified trigger by firing it with a fake value. This method can be used by developers of client applications to test the way their apps receive and handle M2X notifications.
 */
-(void)testTrigger:(NSString*)trigger_id inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @Delete Trigger
///------------------------------------

/**
 Delete an existing trigger associated with a specific feed.
 */
-(void)deleteTrigger:(NSString*)trigger_id inFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @View Request Log
///------------------------------------

/**
 Retrieve list of HTTP requests received lately by the specified feed (up to 100 entries).
 */
-(void)viewRequestLogForFeed:(NSString*)feed_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

@property (nonatomic,strong) NSString *feed_key;

@end
