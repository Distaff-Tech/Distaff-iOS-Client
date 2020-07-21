//
//  AppDelegate.swift
//  Distaff
//
//  Created by netset on 09/01/20.
//  Copyright © 2020 netset. All rights reserved.
//

import UIKit
import IQKeyboardManager
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import UserNotifications
import Fabric

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate {
    
    var window: UIWindow?
    var isAppOpenFromPushNotification = false
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] != nil {
            isAppOpenFromPushNotification = true
        }
        
        
        UIApplication.shared.statusBarStyle = .lightContent
        sleep(UInt32(AppInfo.splashScreenSleepTime))
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.font:UIFont(name:AppFont.fontSemiBold, size: CGFloat(AppInfo.navigationBarTitleSize))!]
        UINavigationBar.appearance().setBackgroundImage(#imageLiteral(resourceName: "navigationImage"), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().toolbarTintColor = AppColors.appColorBlue
        UITextField.appearance().tintColor = AppColors.appColorBlue
        UITextView.appearance().tintColor = AppColors.appColorBlue
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().shadowImage = nil
        CommonMethods.makeInitialRoot()
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        
        registerRemoteNotification(application: application)
        FirebaseApp.configure()
        NotificationCenter.default.addObserver(self,selector: #selector(tokenRefreshNotification),name: NSNotification.Name.InstanceIDTokenRefresh,object: nil)
        GIDSignIn.sharedInstance().clientID = AppInfo.clientId
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    
    //MARK: - Social Media Sign In
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == AppInfo.facebookUrlScheme {  //F
            return ApplicationDelegate.shared.application(app, open: url, options: options)
        }else {
            return (GIDSignIn.sharedInstance()?.handle(url))! //G
        }
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        //   UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK:- PUSH
    func application(received remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("FCM TOKEN//////////////",fcmToken)
        sendTokenToServer(currentToken: fcmToken)
    }
    
    func registerRemoteNotification(application : UIApplication){
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {granted, error in
                    // For iOS 10 data message (sent via FCM)
                    Messaging.messaging().delegate = self
            })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    }
    func connectToFcm() {
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        #if DEBUG
        Messaging.messaging().setAPNSToken(deviceToken as Data, type: .sandbox)
        #else
        Messaging.messaging().setAPNSToken(deviceToken as Data, type: .prod)
        #endif
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    @objc func tokenRefreshNotification() {
        let refreshedToken = Messaging.messaging().fcmToken
        if refreshedToken != nil{
            sendTokenToServer(currentToken: refreshedToken!)
            connectToFcm()
        }
    }
    func sendTokenToServer(currentToken: String) {
        print("---refresh token ----",currentToken)
        UserDefaults.standard.set(currentToken, forKey: UserDefaultsKeys.deviceId)
        if userdefaultsRef.value(forKey: UserDefaultsKeys.isUserLogedIn) != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                CommonMethods.callUpdateFCMTokenOnServer(newToken: currentToken) {
                }
            }
        }
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo as AnyObject
        print(userInfo)
        let tag = userInfo["tag"] as? String ?? ""
        if tag != PushNotificationsType.message && tag !=  PushNotificationsType.postDisabled {
            Variables.shared.hasPendingNotifications = true
        }
        handleNotificationBannerTap(info: userInfo)
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo as AnyObject
        print(userInfo)
        let tag = userInfo["tag"] as? String ?? ""
        if tag != PushNotificationsType.message && tag !=  PushNotificationsType.postDisabled {
            Variables.shared.hasPendingNotifications = true
        }
        updateUIOnNotificationBanner(info: userInfo)
        if isNeedToShowNotificationBanner() {
            completionHandler([.alert, .sound,.badge])
        }
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func handleNotificationBannerTap(info:AnyObject) {
        
        if  let tab =  appDelegateRef.window?.rootViewController as? UITabBarController {
            let selectedIndex = tab.selectedIndex
            let selectedNavigation = tab.viewControllers?[selectedIndex] as? UINavigationController
            let visible = selectedNavigation?.visibleViewController
            let selectedVC = tab.selectedViewController as? UINavigationController
            dismissVCIfPresented(vc: visible ?? UIViewController())
            
            let tag = info["tag"] as? String ?? ""
            if tag == PushNotificationsType.like {
                let targetVC = homeStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.postDetailVC) as? PostDetailVC
                targetVC?.postId = Int(info["post_id"] as? String ?? "0")
                if selectedIndex == 4 && visible is PostDetailVC {
                    let vc = visible as? PostDetailVC
                    print(vc?.postId ?? 0)
                    if vc?.postId ?? 0 == Int(info["post_id"] as? String ?? "0") {
                        selectedVC?.popToRootViewController(animated: false)
                    }
                }
                
                selectedVC?.pushViewController(targetVC ?? UIViewController(), animated: true)
            }
                
            else if tag == PushNotificationsType.follow {
                let targetVC = homeStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.myProfileVC) as? MyProfileVC
                targetVC?.isMyProfile = false
                targetVC?.passedUserId = Int(info["sender_id"] as? String ?? "0")
                let vc = visible as? MyProfileVC
                if vc?.passedUserId ?? 0 == Int(info["sender_id"] as? String ?? "0") {
                    selectedVC?.popViewController(animated: false)
                }
                
                selectedVC?.pushViewController(targetVC ?? UIViewController(), animated: true)
                
            }
                
            else if tag == PushNotificationsType.OrderPlace {
                let targetVC = homeStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.orderDetailVC) as? OrderDetailVC
                targetVC?.isMyOrder =  false
                targetVC?.orderId = Int(info["order_id"] as? String ?? "0")
                selectedVC?.pushViewController(targetVC ?? UIViewController(), animated: true)
                
            }
                
            else if tag == PushNotificationsType.message {
                let targetVC = homeStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.chatVC) as? ChatVC
                targetVC?.receiverId = Int(info["sender_id"] as? String ?? "0")
                selectedVC?.pushViewController(targetVC ?? UIViewController(), animated: true)
            }
                
            else if tag == PushNotificationsType.orderAccept {
                let targetVC = homeStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifers.orderDetailVC) as? OrderDetailVC
                targetVC?.isMyOrder =  true
                targetVC?.orderId = Int(info["order_id"] as? String ?? "0")
                let vc = visible as? OrderDetailVC
                if vc?.orderId ?? 0 == Int(info["order_id"] as? String ?? "0") {
                    selectedVC?.popViewController(animated: false)
                }
                selectedVC?.pushViewController(targetVC ?? UIViewController(), animated: true)
            }
                
            else if tag == PushNotificationsType.postDisabled {
                if   let tab =  appDelegateRef.window?.rootViewController as? UITabBarController  {
                    if tab.selectedIndex != 4 && !(visible is MyProfileVC) {
                        Variables.shared.shouldLoadProfileData = true
                        let nav = tab.viewControllers?[4] as? UINavigationController
                        nav?.popToRootViewController(animated: true)
                        tab.selectedIndex = 4
                        
                        print(UIApplication.shared.applicationState)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            if self.isAppOpenFromPushNotification {
                                Variables.shared.shouldLoadPostData = true
                                self.isAppOpenFromPushNotification = false
                            }
                        }
                    }
                    
                }
                
            }
        }
        
    }
    
    func updateUIOnNotificationBanner(info:AnyObject) {
        if   let tab =  appDelegateRef.window?.rootViewController as? UITabBarController {
            let selectedIndex = tab.selectedIndex
            let selectedNavigation = tab.viewControllers?[selectedIndex] as? UINavigationController
            let visibleVC = selectedNavigation?.visibleViewController
            let tag = info["tag"] as? String ?? ""
            
            if tag == PushNotificationsType.postDisabled {  // if other page and user dont tap banner
                Variables.shared.shouldLoadProfileData = true
            }
            
            if visibleVC is HomeVC { // fire local notification
                
                let homePage = visibleVC as? HomeVC
                homePage?.notificationBageBtn.badgeString = "●"
            }
            
            if visibleVC is ChatVC {
                
                NotificationCenter.default
                    .post(name: NSNotification.Name(rawValue:NotificationObservers.refreshChatList), object: nil, userInfo: info as? [AnyHashable : Any])
                
            }
            
            if visibleVC is MessageVC {
                NotificationCenter.default
                    .post(name: NSNotification.Name(rawValue:NotificationObservers.refreshChatList), object: nil, userInfo: info as? [AnyHashable : Any])
                
            }
            
            
            
            if (visibleVC is MyProfileVC &&  tag == PushNotificationsType.follow) {
                NotificationCenter.default
                    .post(name: NSNotification.Name(rawValue: NotificationObservers.refreshProfile), object: nil, userInfo: info as? [AnyHashable : Any])
            }
            
            
            if  (visibleVC is MyProfileVC) && (tab.selectedIndex == 4)  && (tag == PushNotificationsType.postDisabled) {
                NotificationCenter.default
                    .post(name: NSNotification.Name(rawValue: NotificationObservers.refreshProfile), object: nil, userInfo: info as? [AnyHashable : Any])
                
            }
            
            if (visibleVC is PostDetailVC)   && (tag == PushNotificationsType.postDisabled) && (visibleVC as? PostDetailVC)?.postId == Int(info["post_id"] as? String ?? "0")   {
                
                Variables.shared.shouldLoadProfileData = true
                selectedNavigation?.popToRootViewController(animated: true)
            }
            
            if visibleVC is OrderDetailVC &&  tag == PushNotificationsType.orderAccept {
                
                NotificationCenter.default
                    .post(name: NSNotification.Name(rawValue: NotificationObservers.refreshOrderDetail), object: nil, userInfo: info as? [AnyHashable : Any])
                
            }
            
            if visibleVC is NotificationVC &&  tag != PushNotificationsType.message {
                
                NotificationCenter.default
                    .post(name: NSNotification.Name(rawValue: NotificationObservers.refreshNotificationList), object: nil, userInfo: info as? [AnyHashable : Any])
                
            }
            
            
            if visibleVC is OrderHistoryVC &&  (tag == PushNotificationsType.orderAccept || tag == PushNotificationsType.OrderPlace ) {
                
                NotificationCenter.default
                    .post(name: NSNotification.Name(rawValue: NotificationObservers.refreshOrderDetail), object: nil, userInfo: info as? [AnyHashable : Any])
            }
            
        }
    }
    
    func isNeedToShowNotificationBanner() -> Bool {
        var isNeedToShowBanner = true
        if   let tab =  appDelegateRef.window?.rootViewController as? UITabBarController {
            let selectedIndex = tab.selectedIndex
            let AllNav = tab.viewControllers?[selectedIndex] as? UINavigationController
            let visible = AllNav?.visibleViewController
            if visible is ChatVC  {
                isNeedToShowBanner = false
            }
        }
        return isNeedToShowBanner
    }
    
    func dismissVCIfPresented(vc:UIViewController) {
        if vc.isModal {
            vc.dismiss(animated: true, completion: nil)
        }
    }
    
}





