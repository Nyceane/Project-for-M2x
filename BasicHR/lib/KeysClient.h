
#import <Foundation/Foundation.h>
#import "M2x.h"

typedef void (^M2XAPIClientSuccessObject)(id object);
typedef void (^M2XAPIClientFailureError)(NSError *error,NSDictionary *message);

@interface KeysClient : NSObject


///------------------------------------
/// @List Keys
///------------------------------------

/**
 Retrieve list of keys associated with the specified account. This method accepts one optional parameter:
 "feed": a Feed ID; it will list all the keys that are associated with that specific feed or its streams
 */
-(void)listKeysWithParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @Create Key
///------------------------------------

/**
 Create a new key associated with the specified account.
 
 i.e.:
 NSDictionary *key = @{ @"name": @"newkey",
                 "@permissions": @[@"GET", @"PUT"],
                        @"feed": [NSNull null], //optional
                      @"stream": [NSNull null], //optional
                  @"expires_at": [NSNull null]  //optional
                       }
 
 */
-(void)createKey:(NSDictionary*)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @View Key Details
///------------------------------------

/**
 Get details of a specific key associated with a developer account.
 */
-(void)viewDetailsForKey:(NSString*)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @Update Key
///------------------------------------

/**
 Update name or permissions of an existing key associated with the specified account. Same validations as in Create Key applies.
 */
-(void)updateKey:(NSString*)key withParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @Regenerate Key
///------------------------------------

/**
 Regenerate the specified key.
 */
-(void)regenerateKey:(NSString*)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @Delete Key
///------------------------------------

/**
 Delete an existing key.
 */
-(void)deleteKey:(NSString*)key success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

@property (nonatomic,strong) NSString *feed_key;

@end
