#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CLPlacemark.h>

@interface CLGeocoderPlugin : CDVPlugin

- (void) reverseGeocodeLocation:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    Double* lat = [command.arguments objectAtIndex:0];
    Double* lon = [command.arguments objectAtIndex:1];
    CLLocation *bestLocation=[[CLLocation alloc] initWithLatitude:[[lat] doubleValue] longitude:[[lon] doubleValue]]

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];

    [geocoder reverseGeocodeLocation:bestLocation completionHandler:^(NSArray *placemarks, NSError *error)
    {
      if (error) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
      } else {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:placemark.addressDictionary];
      }
      [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

@end