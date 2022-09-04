//
//  AppDelegate.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	
 	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		let navigationController = UINavigationController()
		MovieListingWireframeImpl.showAsRoot(inNavigationController: navigationController)
 		
		return true
	}
}
