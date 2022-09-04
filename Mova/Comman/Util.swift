//
//  Util.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import UIKit
class Util{
	public static func showAlert(title:String?, messageString:String, buttons:[String]?, viewController:UIViewController, didSelect:((_ buttonTitle:String) -> Void)?) {
		DispatchQueue.main.async {
			let alertController = UIAlertController(title: title, message: messageString, preferredStyle: .alert)
 			if buttons != nil, buttons!.count > 0 {
				for button:String in buttons! {
					let defaultAction = UIAlertAction(title: button, style: .default, handler: { (alertAction) in
						if didSelect != nil {
							didSelect!(button)
						}
					})
					alertController.addAction(defaultAction)
				}
			} else {
				let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
					if didSelect != nil {
						didSelect!("OK")
					}
				})
				alertController.addAction(defaultAction)
			}
			viewController.present(alertController, animated: true, completion: nil)
		}
	}

	
}
