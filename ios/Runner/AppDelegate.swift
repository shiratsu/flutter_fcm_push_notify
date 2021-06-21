import UIKit
import Flutter
import FirebaseCore
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    initFirebaseSetting()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func initFirebaseSetting(){
//        let strBuildKey: String = Bundle.main.object(forInfoDictionaryKey: "buildKey") as? String ?? ""
        let strFileName = "GoogleService-Info"
        let filePath = Bundle.main.path(forResource: strFileName, ofType: "plist")
        guard let constFilePath = filePath
            ,let fileopts = FirebaseOptions(contentsOfFile: constFilePath)
            else
        {
            //assert(false, "Couldn't load config file")
            return
            
        }
        FirebaseApp.configure(options: fileopts)
    }
    
    // This method will be called when app received push notifications in foreground
    @available(iOS 10.0, *)
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
    
    func initMessageSetting(){
        // [START set_messaging_delegate]
//       Messaging.messaging().delegate = self
       // [END set_messaging_delegate]
       // Register for remote notifications. This shows a permission dialog on first run, to
       // show the dialog at a more appropriate time move this registration accordingly.
       // [START register_for_notifications]
//       if #available(iOS 10.0, *) {
//         // For iOS 10 display notification (sent via APNS)
//         UNUserNotificationCenter.current().delegate = self
//
//         let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//         UNUserNotificationCenter.current().requestAuthorization(
//           options: authOptions,
//           completionHandler: {_, _ in })
//       } else {
//         let settings: UIUserNotificationSettings =
//         UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//         application.registerUserNotificationSettings(settings)
//       }
//
//       application.registerForRemoteNotifications()

    }
    // [START receive_message]
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
          print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)
      }

    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                       fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
          print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)

        completionHandler(UIBackgroundFetchResult.newData)
      }
      // [END receive_message]
    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
      }

      // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
      // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
      // the FCM registration token.
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")

        // With swizzling disabled you must set the APNs token here.
        // Messaging.messaging().apnsToken = deviceToken
      }
}
