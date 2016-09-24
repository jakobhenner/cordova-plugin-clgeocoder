#import <Cordova/CDV.h>

@interface CLGeocoderPlugin : CDVPlugin

- (void) reverseGeocodeLocation:(CDVInvokedUrlCommand*)command;

@end
