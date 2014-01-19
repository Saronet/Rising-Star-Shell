//
//  AppoxeePlugin.h
//  AppoxeePlugin
//
//  Created by Inbal Geffen on 12/18/13.
//
//

#import <Cordova/CDV.h>
@interface AppoxeePlugin : CDVPlugin
- (void)openInboxCordova:(CDVInvokedUrlCommand *)command;
- (void)openMoreAppsCordova:(CDVInvokedUrlCommand *)command;
- (void)openFeedbackCordova:(CDVInvokedUrlCommand *)command;
-(void)showBadgeCordova:(CDVInvokedUrlCommand *)command;



//Alias API//
-(void)setDeviceAliasCordova:(CDVInvokedUrlCommand *)command;
-(void)getDeviceAliasCordova:(CDVInvokedUrlCommand *)command;
-(void)removeDeviceAliasCordova:(CDVInvokedUrlCommand *)command;
-(void)clearAliasCacheCordova:(CDVInvokedUrlCommand *)command;

//Tags API//
-(void)addRemoveTagsToDeviceCordova:(CDVInvokedUrlCommand *)command;
-(void)addTagsToDeviceCordova:(CDVInvokedUrlCommand *)command;
-(void)removeTagsFromDeviceCordova:(CDVInvokedUrlCommand *)command;
-(void)getDeviceTagsCordova:(CDVInvokedUrlCommand *)command;
-(void)getTagListCordova:(CDVInvokedUrlCommand *)command;
-(void)clearTagsCacheCordova:(CDVInvokedUrlCommand *)command;


//Device Info

-(void)getDeviceOsNameCordova:(CDVInvokedUrlCommand *)command;
-(void)getDeviceOsNumberCordova:(CDVInvokedUrlCommand *)command;
-(void) getHardwareTypeCordova:(CDVInvokedUrlCommand *)command;
-(void)getDeviceCountryCordova:(CDVInvokedUrlCommand *)command;
-(void)getDeviceActivationsCordova:(CDVInvokedUrlCommand *)command;
-(void)getInAppPaymentCordova:(CDVInvokedUrlCommand *)command;
-(void)getNumProductsPurchasedCordova:(CDVInvokedUrlCommand *)command;
-(void)increaseInAppPaymentCordova:(CDVInvokedUrlCommand *)command;
-(void)increaseNumProductPurchasedCordova:(CDVInvokedUrlCommand *)command;
//////////////////////////////    Push Managment    //////////////////////////////

-(void)isPushEnabledCordova:(CDVInvokedUrlCommand *)command;
-(void)isSoundEnabledCordova:(CDVInvokedUrlCommand *)command;
-(void)isBadgeEnabledCordova:(CDVInvokedUrlCommand *)command;
-(void)setPushEnabledCordova:(CDVInvokedUrlCommand *)command;

-(void)setBadgeEnabledCordova:(CDVInvokedUrlCommand *)command;
-(void)setSoundEnabledCordova:(CDVInvokedUrlCommand *)command;

//////////////////////////////     Localization     //////////////////////////////
-(void)configureAppoxeeForLocaleCordova:(CDVInvokedUrlCommand *)command;
////////////////////// V3 ////////////////////////////
-(void)getAttributeCordova:(CDVInvokedUrlCommand *)command;


@end
