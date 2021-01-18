//
//  AppDelegate.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 11/14/20.
//  Copyright © 2020 Software Development HS_902 All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

@available(iOS 14.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        print("Firebase Configured!")
        
        
        Auth.auth().signInAnonymously() { (authResult, error) in
            guard let user = authResult?.user else { return }
            let uid = user.uid
        }
        /*
        let finalUser = Auth.auth().currentUser
        if let currentUser = finalUser {
            print("anon_id", currentUser.uid)
            print("Good", User(currentUser.uid).riskAssesment)
        }*/
      //  var location: Location = Location("Walmart","3467 Lincoln Hwy E, Thorndale, PA 19372")
       // print("Got location", location.address)
        
        //var news: NewsPost = NewsPost("Covid-19","Pfizer Vaccine got approved for emergency use",UIImage(imageLiteralResourceName: "basketball"),Timestamp())
        
        //var news2: NewsPost = NewsPost("Politics","Trump",UIImage(imageLiteralResourceName: "basketball"),Timestamp())
        //print("Got news", news)
        //var newsFeed = NewsPost.getAllPosts()
        //print(newsFeed)
        /*
        NewsPost.getAllPosts()
        let posts = NewsPost.newsArr
        print("Bruh 0: "+String(posts.count))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
    
        for post in posts{
             print("Bruh 1"+post.title)
             print("Bruh 2"+post.body)
            print("Bruh 3"+dateFormatter.string(from: post.date.dateValue())+"/n")
        }
        */
        var location = Location("Walmart", "3467 Lincoln Hwy E, Thorndale, PA 19372")
        location = Location("GIANT", "168 Eagleview Blvd, Exton, PA 19341")
        print("Location was created",location.name)
        print("Finished all required tasks!")

        return true
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}



