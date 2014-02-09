//
//  WFViewController.m
//  BasicHR
//
//  Created by Murray Hughes on 26/10/12.
//  Copyright (c) 2012 Wahoo Fitness. All rights reserved.
//

#import "WFViewController.h"
#import <WFConnector/WFConnector.h>
#import "FeedsClient.h"


@interface WFViewController () <WFHardwareConnectorDelegate,WFSensorConnectionDelegate>

@property (nonatomic, retain) WFSensorConnection* sensorConnection;

@end

@implementation WFViewController {
    int heartrate;
}

@synthesize antPlusSwitch;
@synthesize bluetoothSwitch;
@synthesize wildcardSwitch;
@synthesize suuntoSwitch;
@synthesize connectButton;
@synthesize hrLabel;
@synthesize serialLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    heartrate = 100;
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //Setup the hardware connecctor.
    WFHardwareConnector* hardwareConnector = [WFHardwareConnector sharedConnector];
    hardwareConnector.delegate = self;
    [hardwareConnector setSampleTimerDataCheck:FALSE];
    [hardwareConnector setSampleRate:1.0];
    
    //Need to enable the BT
    [hardwareConnector enableBTLE:YES];
    
    NSLog(@"API VERSION:  %@", hardwareConnector.apiVersion);
    NSLog(@"Has BTLE: %@", hardwareConnector.hasBTLESupport ? @"YES" : @"NO");
    
    [self updateConnectButton];
    [self updateData];
    
    M2x* m2x = [M2x shared];
    m2x.api_key = @"6c30d3f9fae23db1209e32d9de2efa1b";
    

}

- (void)viewDidUnload
{
    [self setAntPlusSwitch:nil];
    [self setBluetoothSwitch:nil];
    [self setWildcardSwitch:nil];
    [self setConnectButton:nil];
    [self setSuuntoSwitch:nil];
    [self setHrLabel:nil];
    [self setSerialLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark - UI

- (void) updateConnectButton
{
	// get the current connection status.
	WFSensorConnectionStatus_t connState = WF_SENSOR_CONNECTION_STATUS_IDLE;
	if ( self.sensorConnection != nil )
	{
		connState = self.sensorConnection.connectionStatus;
	}
	
	// set the button state based on the connection state.
	switch (connState)
	{
		case WF_SENSOR_CONNECTION_STATUS_IDLE:
            [self.connectButton setTitle:@"Connect" forState:UIControlStateNormal];
			break;
		case WF_SENSOR_CONNECTION_STATUS_CONNECTING:
            [self.connectButton setTitle:@"Connecting.." forState:UIControlStateNormal];
			break;
		case WF_SENSOR_CONNECTION_STATUS_CONNECTED:
            [self.connectButton setTitle:@"Disconnect" forState:UIControlStateNormal];
			break;
		case WF_SENSOR_CONNECTION_STATUS_DISCONNECTING:
            [self.connectButton setTitle:@"Disconnecting.." forState:UIControlStateNormal];
			break;
        case WF_SENSOR_CONNECTION_STATUS_INTERRUPTED:
            [self.connectButton setTitle:@"Interrupted!" forState:UIControlStateNormal];
            break;
	}
    
}

//--------------------------------------------------------------------------------

- (void) updateData
{
    bool isValid = NO;
    
    if([self.sensorConnection isKindOfClass:[WFHeartrateConnection class]])
    {
        WFHeartrateConnection* hrConnection = (WFHeartrateConnection*)self.sensorConnection;
    
        if(hrConnection.connectionStatus == WF_SENSOR_CONNECTION_STATUS_CONNECTED)
        {
            isValid=YES;
            
            self.serialLabel.text = hrConnection.deviceIDString;
            self.hrLabel.text = [[hrConnection getHeartrateData] formattedHeartrate:NO];
            NSLog(@"%@", [[hrConnection getHeartrateData] formattedHeartrate:NO]);
            
            if (!self.hrLabel.text) {
                self.hrLabel.text = @"0";
            }
            
          
            [self connectToATTM2X:self.hrLabel.text];
            
        }
    }

    if(!isValid)
    {
        self.serialLabel.text = @"--";
        self.hrLabel.text = @"--";
    }
}

- (void)connectToATTM2X:(NSString *)hearrateValue {
    NSDictionary *newValue = @{ @"values": @[ @{ @"value":hearrateValue } ] };
    
    FeedsClient *feedClient = [[FeedsClient alloc] init];
    [feedClient setFeed_key:@"6c30d3f9fae23db1209e32d9de2efa1b"];
    
    [feedClient postDataValues:newValue
                     forStream:@"heartrate"
                        inFeed:@"bce9ce2cd1e121eacf6fb260dc9fe055"
                       success:^(id object) { /*success block*/ }
                       failure:^(NSError *error, NSDictionary *message)
     {
         NSLog(@"Error: %@",[error localizedDescription]);
         NSLog(@"Message: %@",message);
     }];
}

- (void)countLabel:(NSTimer*) timer {
    
    heartrate--;
    
    [self connectToATTM2X:[NSString stringWithFormat:@"%d", heartrate]];
    self.hrLabel.text = [NSString stringWithFormat:@"%d", heartrate];

    
    if (heartrate < 40) {
        [timer invalidate];
        timer = nil;
        NSString *phoneNumber = [@"tel://" stringByAppendingString:@"14088384237"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
    
}

- (IBAction)messageButtonSend:(id)sender {
    
    heartrate = 100;
 
    NSTimer *timer1 = [NSTimer scheduledTimerWithTimeInterval: 0.1 target:self selector:@selector(countLabel:) userInfo:nil repeats: YES];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:@"https://rest.nexmo.com/sms/json?api_key=b2897742&api_secret=595daa8c&from=15708460233&to=14088362915&text=hello+I+am+your+Grandma+Hellen+I+need+help+in+nestGSV+campus"]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;

   NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
}

//--------------------------------------------------------------------------------

- (IBAction)connectButtonTouched:(id)sender
{
    [self toggleConnection];
}

#pragma mark -
#pragma mark - Connection Management

//--------------------------------------------------------------------------------
- (void) toggleConnection
{
    //--------------------------------------------------------------------
    // Sensor Type
    WFSensorType_t sensorType = WF_SENSORTYPE_HEARTRATE;
    
    //--------------------------------------------------------------------
    // Network Type
    WFNetworkType_t networkType = WF_NETWORKTYPE_UNSPECIFIED;
    
    if(antPlusSwitch.on) networkType |= WF_NETWORKTYPE_ANTPLUS;
    if(bluetoothSwitch.on) networkType |= WF_NETWORKTYPE_BTLE;
    if(suuntoSwitch.on) networkType |= WF_NETWORKTYPE_SUUNTO;
    
    //OR simply
    //networkType = WF_NETWORKTYPE_ANY;
    
    //--------------------------------------------------------------------
    // Wildcard
    
    bool isWildcard = wildcardSwitch.on;
    
    //--------------------------------------------------------------------
	// Current Connection Status
	WFSensorConnectionStatus_t connState = WF_SENSOR_CONNECTION_STATUS_IDLE;
    WFHardwareConnector* hardwareConnector = [WFHardwareConnector sharedConnector];
    
	if ( self.sensorConnection != nil )
	{
		connState = self.sensorConnection.connectionStatus;
	}
    
    //--------------------------------------------------------------------
	// Toggle Connection
	switch (connState)
	{
		case WF_SENSOR_CONNECTION_STATUS_IDLE:
		{
			// create the connection params.
			WFConnectionParams* params = nil;
            
			if ( isWildcard )
			{
                // if wildcard search is specified, create empty connection params.
				params = [[WFConnectionParams alloc] init];
				params.sensorType = sensorType;
                params.networkType = networkType;
			}
			else
			{
                //
                // otherwise, get the params from the stored settings.
				params = [hardwareConnector.settings connectionParamsForSensorType:sensorType];
			}
            
			if ( params != nil)
			{
                NSError* error = nil;
                
                // if the connection request is a wildcard, you could use proximity search
                if ( isWildcard )
                {
                    WFProximityRange_t range = WF_PROXIMITY_RANGE_DISABLED;
                    self.sensorConnection = [hardwareConnector requestSensorConnection:params withProximity:range error:&error];
                }
                else
                {
                    // otherwise, use normal connection request.
                    self.sensorConnection = [hardwareConnector requestSensorConnection:params];
                }
                
                if(error!=nil)
                {
                    NSLog(@"ERROR: %@", error);
                }
                
                // set delegate to receive connection status changes.
                self.sensorConnection.delegate = self;
			}
			break;
		}
			
		case WF_SENSOR_CONNECTION_STATUS_CONNECTING:
		case WF_SENSOR_CONNECTION_STATUS_CONNECTED:
			// disconnect the sensor.
            NSLog(@"Disconnecting sensor connection");
			[self.sensorConnection disconnect];
			break;
			
		case WF_SENSOR_CONNECTION_STATUS_DISCONNECTING:
        case WF_SENSOR_CONNECTION_STATUS_INTERRUPTED:
			// do nothing.
			break;
	}
    
	[self updateConnectButton];
}


#pragma mark WFHardwareConnectorDelegate Implementation

//--------------------------------------------------------------------------------
- (void)hardwareConnector:(_WFHardwareConnector*)hwConnector stateChanged:(WFHardwareConnectorState_t)currentState
{
}

//--------------------------------------------------------------------------------
- (void)hardwareConnector:(_WFHardwareConnector*)hwConnector connectedSensor:(WFSensorConnection*)connectionInfo
{
    NSString* logMsg = [NSString stringWithFormat:@"Sensor Connected: %@ on Network: %@",
                        [self nameFromSensorType:connectionInfo.sensorType],
                        [self nameFromNetworkType:connectionInfo.networkType]];
    
    NSLog(@"%@", logMsg);
    
}

//--------------------------------------------------------------------------------
- (void)hardwareConnector:(_WFHardwareConnector*)hwConnector disconnectedSensor:(WFSensorConnection*)connectionInfo
{
    NSString* logMsg = [NSString stringWithFormat:@"Sensor Disconnected: %@ on Network: %@",
                        [self nameFromSensorType:connectionInfo.sensorType],
                        [self nameFromNetworkType:connectionInfo.networkType]];
    
    NSLog(@"%@", logMsg);
}

//--------------------------------------------------------------------------------
- (void)hardwareConnector:(_WFHardwareConnector*)hwConnector searchTimeout:(WFSensorConnection*)connectionInfo
{
    NSString* logMsg = [NSString stringWithFormat:@"Search Timeout: %@",
                        [self nameFromSensorType:connectionInfo.sensorType]];
    
    NSLog(@"%@", logMsg);
}

//--------------------------------------------------------------------------------
- (void)hardwareConnectorHasData
{
    [self updateData];
}

#pragma mark -
#pragma mark WFSensorConnectionDelegate Implementation

//--------------------------------------------------------------------------------
- (void)connection:(WFSensorConnection*)connectionInfo stateChanged:(WFSensorConnectionStatus_t)connState
{
    // check for a valid connection.
    if (connectionInfo.isValid)
    {
        // update the stored connection settings.
        [[WFHardwareConnector sharedConnector].settings saveConnectionInfo:connectionInfo];
        
        // update the display.
        [self updateData];
    }
    
    // check for disconnected sensor.
    else if ( connState == WF_SENSOR_CONNECTION_STATUS_IDLE )
    {
        // reset the display.
    }
	
	[self updateConnectButton];
}


#pragma mark - Helpful Methods

- (NSString*) nameFromSensorType:(WFSensorType_t)sensorType
{
	NSString* retVal;
	
	switch (sensorType)
	{
		case WF_SENSORTYPE_HEARTRATE:
			retVal = @"Heartrate";
			break;
		case WF_SENSORTYPE_BIKE_POWER:
			retVal = @"Power";
			break;
		case WF_SENSORTYPE_BIKE_SPEED_CADENCE:
			retVal = @"Speed & Cadence";
			break;
		default:
			retVal = @"Unknown";
			break;
	}
	
	return	retVal;
}

- (NSString*) nameFromNetworkType:(WFNetworkType_t)networkType
{
	NSString* retVal;
	
	switch (networkType)
	{
		case WF_NETWORKTYPE_BTLE:
			retVal = @"BTLE";
			break;
		case WF_NETWORKTYPE_ANTPLUS:
			retVal = @"ANT+";
			break;
		case WF_NETWORKTYPE_SUUNTO:
			retVal = @"Suunto";
			break;
		default:
			retVal = @"Unknown";
			break;
	}
	
	return	retVal;
}


@end
