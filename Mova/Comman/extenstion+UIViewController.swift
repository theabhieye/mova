//
//  extenstion+UIViewController.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//
import UIKit

extension UIViewController {
	
	class var storyBoardId: String {
		return String(describing: self)
	}
	
	static func instantiateFromStoryBoard(appStoryBoard: AppStoryboard) -> Self {
		return appStoryBoard.viewController(viewControllerClass: self)
	}
	
	func hideKeyboardWhenTappedAround() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}

