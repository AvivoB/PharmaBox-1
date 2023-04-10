import UIKit
import Flutter
import GoogleMaps
import FirebaseCore
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyD2iAVuME8f_hACkixmDwAWb-VSxz1lCwU")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
