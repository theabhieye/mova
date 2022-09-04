//
//  File.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import UIKit

protocol NibLoadableView: AnyObject { }

extension NibLoadableView where Self: UIView {
	
	static var nibName: String {
		return String(describing: self)
	}
	
}
