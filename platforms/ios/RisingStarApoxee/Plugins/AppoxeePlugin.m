//
//  AppoxeePlugin.m
//  AppoxeePlugin
//
//  Created by Inbal Geffen on 12/18/13.
//
//

#import "AppoxeePlugin.h"
#import "Appoxee.h"
#import "AppDelegate.h"

@implementation AppoxeePlugin

/*
 * Main Actions : 
 * Inbox , More Apps , Feedback
 */
-(void)showBadgeCordova:(CDVInvokedUrlCommand *)command
{
    int unread = [[AppoxeeManager sharedManager]calculateUnreadMessagesBadgeValue];
    
    AppDelegate *appDelegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
    NSString *badgeText = appDelegate.badgeText;
    //    NSString *badgeText = [NSString stringWithFormat:@"%d",unread];
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             badgeText, @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void)openInboxCordova:(CDVInvokedUrlCommand *)command
{
    [[AppoxeeManager sharedManager] show];
    
    int num = [[AppoxeeManager sharedManager] calculateUnreadMessagesBadgeValue];
    NSLog(@"Num = %d",num);
    
    [self.commandDelegate sendPluginResult:nil callbackId:command.callbackId];
}

- (void)openMoreAppsCordova:(CDVInvokedUrlCommand *)command
{
    [[AppoxeeManager sharedManager] showMoreAppsViewController];
    [self.commandDelegate sendPluginResult:nil callbackId:command.callbackId];

}
- (void)openFeedbackCordova:(CDVInvokedUrlCommand *)command
{
    [[AppoxeeManager sharedManager] showFeedbackViewController];
    [self.commandDelegate sendPluginResult:nil callbackId:command.callbackId];
}


/**
 * Add tags to device
 *
 * @param tagsToAdd - NSArray of NSStrings of the selected tags
 * @param tagsToRemove - NSArray of NSStrings of the selected tags
 *
 * @return YES on success, NO if failed
 */
-(void)addRemoveTagsToDeviceCordova:(CDVInvokedUrlCommand *)command
{
    NSString *tagsToAdd = [command.arguments objectAtIndex:0];
    NSString *tagsToRemove = [command.arguments objectAtIndex:1];
    
    NSArray *tagsToAddArr = [tagsToAdd componentsSeparatedByString:@","];
    NSArray *tagsToRemoveArr = [tagsToRemove componentsSeparatedByString:@","];
    
    NSLog(@"add %@ remove %@",tagsToAdd,tagsToRemove);
    BOOL success = [[AppoxeeManager sharedManager] addTagsToDevice:tagsToAddArr andRemove:tagsToRemoveArr];
    
    NSString *successStr;
    if (success)
        successStr=@"true";
    else
        successStr=@"false";
    // Create an object with a simple success property.
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             successStr, @"success",
                             nil
                             ];
    
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
/**
 * Add tags to device
 * And remove tags from device
 * @param tags - NSArray of NSStrings of the selected tags
 *
 * @return YES on success, NO if failed
 */
-(void)addTagsToDeviceCordova:(CDVInvokedUrlCommand *)command
{
    NSString *tagsToAdd = [command.arguments objectAtIndex:0];
    
    NSArray *tagsToAddArr = [tagsToAdd componentsSeparatedByString:@","];
    
    BOOL success = [[AppoxeeManager sharedManager] addTagsToDevice:tagsToAddArr];
    
    NSString *successStr;
    if (success)
        successStr=@"true";
    else
        successStr=@"false";
    // Create an object with a simple success property.
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             successStr, @"success",
                             nil
                             ];
    
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
/**
 * And remove tags from device
 * @param tags - NSArray of NSStrings of the selected tags
 *
 * @return YES on success, NO if failed
 */
-(void)removeTagsFromDeviceCordova:(CDVInvokedUrlCommand *)command
{
    NSString *tagsToRemove = [command.arguments objectAtIndex:0];
    
    NSArray *tagsToRemoveArr = [tagsToRemove componentsSeparatedByString:@","];
    
    
    BOOL success = [[AppoxeeManager sharedManager] removeTagsFromDevice:tagsToRemoveArr];
    
    NSString *successStr;
    if (success)
        successStr=@"true";
    else
        successStr=@"false";
    // Create an object with a simple success property.
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             successStr, @"success",
                             nil
                             ];
    
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
/**
 * Get device's tag list from the server
 *
 * @return NSArray of NSStrings
 */
-(void)getDeviceTagsCordova:(CDVInvokedUrlCommand *)command
{
    NSArray *tagsArr= [[AppoxeeManager sharedManager] getDeviceTags];
    NSString *tags = [tagsArr componentsJoinedByString:@","];
    // Create an object to hold the array
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             tags, @"result",
                             nil
                             ];
    
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
/**
 * Get App's tag list from the server
 *
 * @return NSArray of NSStrings
 */
-(void)getTagListCordova:(CDVInvokedUrlCommand *)command
{
    NSLog(@"get tag list called");
    NSArray *tagsArr= [[AppoxeeManager sharedManager] getTagList];
    NSString *tags = [tagsArr componentsJoinedByString:@","];
    // Create an object to hold the array
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             tags, @"result",
                             nil
                             ];
    
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
/**
 * Clear tags local cache
 */
-(void)clearTagsCacheCordova:(CDVInvokedUrlCommand *)command
{
    [[AppoxeeManager sharedManager] clearTagsCache];
    
    NSLog(@"clearTagsCacheCordova called");
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : nil
                                     ];

    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}


//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////      Aliases API     //////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
/**
 * Set device alias
 *
 * @return YES on success, NO if failed
 */
-(void)setDeviceAliasCordova:(CDVInvokedUrlCommand *)command
{
    NSString *alias = [command.arguments objectAtIndex:0];
    
    BOOL success = [[AppoxeeManager sharedManager] setDeviceAlias:alias];
    
    NSString *successStr;
    if (success)
        successStr=@"true";
    else
        successStr=@"false";
    // Create an object with a simple success property.
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             successStr, @"success",
                             nil
                             ];
    
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
/**
 * Remove device alias
 *
 * @return YES on success, NO if failed
 */
-(void)removeDeviceAliasCordova:(CDVInvokedUrlCommand *)command
{
    BOOL success = [[AppoxeeManager sharedManager] removeDeviceAlias];
    
    NSString *successStr;
    if (success)
        successStr=@"true";
    else
        successStr=@"false";
    // Create an object with a simple success property.
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             successStr, @"success",
                             nil
                             ];
    
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
   
}
/**
 * Get device alias
 *
 * @return YES on success, NO if failed
 */
-(void)getDeviceAliasCordova:(CDVInvokedUrlCommand *)command
{
    NSString *deviceAlias = [[AppoxeeManager sharedManager] getDeviceAlias];
    
    NSLog(@"alias=%@",deviceAlias);
    // Create an object that will be serialized into a JSON object.
    // This object contains the date String contents and a success property.
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             deviceAlias, @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}
/**
 * Clear alias local cache
 */
-(void)clearAliasCacheCordova:(CDVInvokedUrlCommand *)command
{
    [[AppoxeeManager sharedManager] clearAliasCache];
 
    NSLog(@"clearAliasCache called");

    
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : nil
                                     ];
    
    

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////    Device Info       //////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
/**
 * Get Device Os Name
 */
-(void)getDeviceOsNameCordova:(CDVInvokedUrlCommand *)command
{
    NSString *result = [[AppoxeeManager sharedManager] getDeviceOsName];
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             result, @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}
/**
 * Get Device Os Number
 */
-(void)getDeviceOsNumberCordova:(CDVInvokedUrlCommand *)command
{
    NSString *result = [[AppoxeeManager sharedManager] getDeviceOsNumber];
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             result, @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}
/**
 * Get Hardware Type
 */
- (void) getHardwareTypeCordova:(CDVInvokedUrlCommand *)command
{
    NSString *result = [[AppoxeeManager sharedManager] getHardwareType];
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             result, @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

/**
 * Get Device Country
 */
-(void)getDeviceCountryCordova:(CDVInvokedUrlCommand *)command
{
    NSString *result = [[AppoxeeManager sharedManager] getDeviceCountry];
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             result, @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

/**
 * Get Device Activations
 */
-(void)getDeviceActivationsCordova:(CDVInvokedUrlCommand *)command
{
    NSNumber *result = [NSNumber numberWithInt:[[AppoxeeManager sharedManager] getDeviceActivations]];
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             result, @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}
/**
 * Get Device inApp Payment
 *
 * @return nil if not set yet.
 */
-(void)getInAppPaymentCordova:(CDVInvokedUrlCommand *)command
{
    NSDecimalNumber *result = [[AppoxeeManager sharedManager] getInAppPayment];
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             result, @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
/**
 * Get Num Products Purchased
 */
-(void)getNumProductsPurchasedCordova:(CDVInvokedUrlCommand *)command
{
    NSNumber *result = [NSNumber numberWithInt:[[AppoxeeManager sharedManager] getNumProductsPurchased]];
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             result, @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}
/**
 * Increase inApp payment and number of product purchased
 *
 * @param payment (NSDecimalNumber *)
 * @param numPurchased (int)
 */
- (void)increaseInAppPaymentCordova:(CDVInvokedUrlCommand *)command
{
 
    NSDecimalNumber *payment = [NSDecimalNumber decimalNumberWithString:[command.arguments objectAtIndex:0]];
    int num = [[command.arguments objectAtIndex:1]integerValue];

    
    BOOL result = [[AppoxeeManager sharedManager] increaseInAppPayment:payment andNumPurchased:num];
    NSString *successStr;
    if (result)
        successStr=@"true";
    else
        successStr=@"false";

    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             successStr, @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    
}
/**
 * Increase number of product purchased
 *
 * @param numPurchased (int)
 */
-(void)increaseNumProductPurchasedCordova:(CDVInvokedUrlCommand *)command
{
    
    NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:[command.arguments objectAtIndex:0]];
    
    BOOL result = [[AppoxeeManager sharedManager] increaseNumProductPurchased:num];
    NSString *successStr;
    if (result)
        successStr=@"true";
    else
        successStr=@"false";
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             successStr, @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////    Push Managment    //////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

/**
 * Determines whether push is enabled.
 * Returns
 * True if push is enabled, false otherwise
 **/
-(void)isPushEnabledCordova:(CDVInvokedUrlCommand *)command
{
    BOOL result = [[AppoxeeManager sharedManager] isPushEnabled];
    NSString *successStr;
    if (result)
        successStr=@"true";
    else
        successStr=@"false";
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             successStr, @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

/**
 * Determines whether sound is enabled.
 * Returns
 * A boolean indicated whether sound is enabled.
 **/
-(void)isSoundEnabledCordova:(CDVInvokedUrlCommand *)command
{
    BOOL result = [[AppoxeeManager sharedManager] isSoundEnabled];
    NSString *successStr;
    if (result)
        successStr=@"true";
    else
        successStr=@"false";
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             successStr, @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

/**
 * Determines whether vibration is enabled.
 * Returns
 * A boolean indicating whether vibration is enabled
 **/
- (void)isBadgeEnabledCordova:(CDVInvokedUrlCommand *)command
{
    BOOL result = [[AppoxeeManager sharedManager] isBadgeEnabled];
    NSString *successStr;
    if (result)
        successStr=@"true";
    else
        successStr=@"false";
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             successStr, @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

-(void)setPushEnabledCordova:(CDVInvokedUrlCommand *)command
{
    
    BOOL shouldEnable;
    if ([[command.arguments objectAtIndex:0] isEqualToString:@"True"])
        shouldEnable=YES;
    else
        shouldEnable=NO;


    [[AppoxeeManager sharedManager] setPushEnabled:shouldEnable];
    
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}



- (void)setSoundEnabledCordova
:(CDVInvokedUrlCommand *)command
{
    
    BOOL shouldEnable;
    if ([[command.arguments objectAtIndex:0] isEqualToString:@"True"])
        shouldEnable=YES;
    else
        shouldEnable=NO;
    
    
    [[AppoxeeManager sharedManager] setSoundEnabled:shouldEnable];
    
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}



- (void) setBadgeEnabledCordova:(CDVInvokedUrlCommand *)command
{
    
    BOOL shouldEnable;
    if ([[command.arguments objectAtIndex:0] isEqualToString:@"True"])
        shouldEnable=YES;
    else
        shouldEnable=NO;
    
    
    [[AppoxeeManager sharedManager] setBadgeEnabled:shouldEnable];
    
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}



//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////     Localization     //////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
/*
 *Configures the local language of the SDK.
 *Example for received parameters: en/he/fr.
 *The default language incase that nothing sent or the language file is not exists is English (en).
 *To create new language file, please add txt file named "en.txt" (instead of en, use the proper localized language) to the project, and make sure there are values for all the keys. the full key list appears at the example.txt file.
 */
- (void)configureAppoxeeForLocaleCordova:(CDVInvokedUrlCommand *)command
{
    NSString *theLocale = [command.arguments objectAtIndex:0];
    
    [[AppoxeeManager sharedManager] configureAppoxeeForLocale:theLocale];
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

////////////////////// V3 ////////////////////////////
-(void)getAttributeCordova:(CDVInvokedUrlCommand *)command
{
    NSString *param = [command.arguments objectAtIndex:0];
    
    NSString *result = [[AppoxeeManager sharedManager] getAttribute:param];
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             result, @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
/*
-(void)setAttributeCordova:(CDVInvokedUrlCommand *)command
{
    NSString *param = [command.arguments objectAtIndex:0];
    
    [[AppoxeeManager sharedManager] setAttribute:param];
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             @"true", @"result",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}*/


@end
