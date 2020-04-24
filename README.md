# RemoteNotificationsConfigurator

This package adds an extension to AppDelegate.
The extension contains 2 methods, which ease the process of adding (remote) Notifications to any app.
In order for this to work, you need a server (Vapor or any other server) which provides an API that saves device tokens in a PostgreSQL database.

See chapter 6 in iOS Push Notifications book (Ray Wenderlich) to learn how to build that server with Vapor.
Once you have your server running, implement these methods in AppDelegate:

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerForPushNotifications(application: application)
        FirebaseApp.configure()
       return true
   }
   
   extension AppDelegate {
   func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
       
       sendPushNotification(to: "http://192.168.1.198:9000/api/token", withToken: deviceToken)
       
   }
