
////
////  AppDelegate+Notifications.swift
////  FireChat
////
////  Created by Petre Vane on 24/04/2020.
////  Copyright © 2020 Petre Vane. All rights reserved.
////
//
import UIKit
import UserNotifications


public enum NotificationConfigurator {
   
    public static func registerForPushNotifications(application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound, .provisional]) { (granted, _) in
            guard granted else { return }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
    
   public static func sendPushNotification(to stringURL: String, withToken deviceToken: Data) {
        
        guard let localURL = URL(string: stringURL) else { print("Invalid URL"); return }
        let token = deviceToken.reduce("") { $0 + String(format: "%02x", $1) }
        print("Device token is: \(token)")
        var obj: [String: Any] = ["token": token, "debug": false]
        
        #if DEBUG
            obj["debug"] = true
            print("Device token is: \(token)")
            let pretty = try! JSONSerialization.data( withJSONObject: obj, options: .prettyPrinted)
            print(String(data: pretty, encoding: .utf8)!)
        #endif
        
        var request = URLRequest(url: localURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization .data(withJSONObject: obj)
        URLSession.shared.dataTask(with: request).resume()
    }
    
}
