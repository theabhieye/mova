//
//  AppStoryboard.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import UIKit

enum AppStoryboard: String {
	
	
	case MovieListingViewController,MovieDetailViewController
	
	
	var instance: UIStoryboard {
		return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
	}
	
	func viewController<T: UIViewController>(viewControllerClass : T.Type) -> T {
		let storyBoardId = (viewControllerClass as UIViewController.Type).storyBoardId
		
		return instance.instantiateViewController(withIdentifier: storyBoardId) as! T
		
	}
	
	func initialViewController() -> UIViewController? {
		return instance.instantiateInitialViewController()
	}
}


