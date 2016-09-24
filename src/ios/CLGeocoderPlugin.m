#import "CLGeocoderPlugin.h"
#import <Cordova/CDV.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>

@implementation CLGeocoderPlugin

- (void) reverseGeocodeLocation:(CDVInvokedUrlCommand*)command
{
    __block CDVPluginResult* pluginResult = nil;

    NSNumber *lat = [command.arguments objectAtIndex:0];
    NSNumber *lon = [command.arguments objectAtIndex:1];

    double latD = [lat doubleValue]; 
    double lonD = [lon doubleValue];
    
    CLLocation *bestLocation=[[CLLocation alloc] initWithLatitude:latD longitude:lonD];
    CLGeocoder *reverseGeocoder = [[CLGeocoder alloc] init];

    // NSString* message = @"Hello";

    [reverseGeocoder reverseGeocodeLocation:bestLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark* placemark = [placemarks firstObject];
        if (placemark) {
            //Using blocks, get zip code
          pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:placemark.addressDictionary];
          // pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
        } else {
          pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

@end