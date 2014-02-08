
#import <Foundation/Foundation.h>
#import "M2x.h"

typedef void (^M2XAPIClientSuccessObject)(id object);
typedef void (^M2XAPIClientFailureError)(NSError *error,NSDictionary *message);

@interface DataSourceClient : NSObject


///------------------------------------
/// @List Blueprints
///------------------------------------

/**
Retrieve list of data source blueprints accessible by the authenticated API key.
*/
-(void)listBlueprintsWithSuccess:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @Create Blueprint
///------------------------------------

/**
 Create a new data source blueprint.
 */
-(void)createBlueprint:(NSDictionary*)blueprint success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @View Blueprint Details
///------------------------------------

/**
 Retrieve information about an existing data source blueprint.
 */
-(void)viewDetailsForBlueprintId:(NSString*)blueprint_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @Update Blueprint Details
///------------------------------------

/**
 Update an existing data source blueprint's information. Accepts the following parameters:
 "name" (required)
 "description" (optional)
 "visibility" either "public" or "private".
 "tags" a comma separated string of tags (optional).
 */
-(void)updateDetailsForBlueprintId:(NSString*)blueprint_id withParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @Delete Blueprint
///------------------------------------

/**
 Delete an existing data source blueprint.
 */
-(void)deleteBlueprint:(NSString*)blueprint_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @List Batches
///------------------------------------

/**
 Retrieve list of data source batches accessible by the authenticated API key.
 */
-(void)listBatchWithSuccess:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @Create Batch
///------------------------------------

/**
 Create a new data source batch.
 
 i.e.:
 NSDictionary *key = @{ @"name": @"newBatch",
                 @"description": @"this is the description", //optional
                  @"visibility": "public", //or "private"
                        @"tags": @"tag1, tag2", //optional
                        }
 */
-(void)createBatch:(NSDictionary*)batch success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @View Batch Details
///------------------------------------

/**
 Retrieve information about an existing data source batch.
 */
-(void)viewDetailsForBatchId:(NSString*)batch_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @Update Batch Details
///------------------------------------

/**
 Update an existing data source batch's information. Accepts the following parameters:
 "name" (required)
 "description" (optional)
 "visibility" either "public" or "private".
 "tags" a comma separated string of tags (optional).
 */
-(void)updateDetailsForBatchId:(NSString*)batch_id withParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @List Data Sources from a Batch
///------------------------------------

/**
 Retrieve list of data sources added to the specified batch
 */
-(void)listDataSourcesfromBatch:(NSString*)batch_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @Add Data Source to an existing Batch
///------------------------------------

/**
 Add a new data source to an existing batch. Accepts the following parameter:
 
 "serial" data source serial number (required).
 
 NSDictionary *parameters = @{ @"serial": @"ABC1234" };
 */
-(void)addDataSourceToBatch:(NSString*)batch_id withParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @Delete Batch
///------------------------------------

/**
 Delete an existing data source batch.
 */
-(void)deleteBatch:(NSString*)batch_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;

///------------------------------------
/// @List Data Sources
///------------------------------------

/**
 Retrieve list of data sources accessible by the authenticated API key.
 */
-(void)listDataSourcesWithSuccess:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @Create Data Source
///------------------------------------

/**
 Create a new data source. Accepts the following parameters:
 
 "name" the name of the new data source (required).
 "description" containing a longer description (optional).
 "visibility" either "public" or "private".
 "tags" a comma separated list of tags (optional).
 */
-(void)createDataSource:(NSDictionary*)dataSource success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @View Data Source Details
///------------------------------------

/**
 Retrieve information about an existing data source.
 */
-(void)viewDetailsForDataSourceId:(NSString*)datasource_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @View Data Source Details
///------------------------------------

/**
 Update an existing data source's information. Accepts the following parameters:
 
 "name" (required)
 "description" (optional)
 "visibility" either "public" or "private".
 "tags" a comma separated list of tags (optional).
 */
-(void)updateDetailsForDataSourceId:(NSString*)datasource_id withParameters:(NSDictionary*)parameters success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


///------------------------------------
/// @Delete Data Source
///------------------------------------

/**
 Delete an existing data source.
 */
-(void)deleteDatasource:(NSString*)datasource_id success:(M2XAPIClientSuccessObject)success failure:(M2XAPIClientFailureError)failure;


@property (nonatomic,strong) NSString *feed_key;


@end
