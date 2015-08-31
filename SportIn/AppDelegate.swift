//
//  AppDelegate.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/3/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//

import UIKit
import Parse
import Bolts
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var drawerContainer: MMDrawerController?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        Parse.enableLocalDatastore()
        
        Parse.setApplicationId("47sdVDL2tD9W9Td7iyrHP2QKwnHhT3domJYVHToS", clientKey: "hQ9qo7xW7xbUivjUcrmmyXb98wQdUeVSBZzHwnCA")
        
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        buildUserInterface()
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject?) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        FBSDKAppEvents.activateApp()
        
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    func buildUserInterface()
    {
        
        
        let userName:String? =  NSUserDefaults.standardUserDefaults().stringForKey("user_name")
        
        if(userName != nil)
        {
            // Navigate to Protected page
            let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
            
            // Create View Controllers
            var homePage:HomeViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
            
            var menuPage:MenuViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
            
            var feedPage:FeedTableViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("FeedTableViewController") as! FeedTableViewController
  
            // Wrap into Navigation controllers
            var homePageNav = UINavigationController(rootViewController:homePage)
            var menuPageNav = UINavigationController(rootViewController:menuPage)
            var feedPageNav = UINavigationController(rootViewController:feedPage)
            
            drawerContainer = MMDrawerController(centerViewController: homePageNav, leftDrawerViewController: menuPageNav, rightDrawerViewController: feedPageNav)
            
           // drawerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
           // drawerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningCenterView
            
            window?.rootViewController = drawerContainer
        }
        
        
        
        
    }

}

