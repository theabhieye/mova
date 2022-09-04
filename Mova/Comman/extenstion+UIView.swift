//
//  extenstion+UIView.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import UIKit

extension UIView {
	enum Axis: String {
		case vertical = "V"
		case horizontal = "H"
	}

	func fillSuperview(
		priority: UILayoutPriority = UILayoutPriority(rawValue: Float(1000)),
		overlapMargins: Bool = true
	) {
		self.fillSuperview(axis: .vertical, priority: priority, overlapMargins: overlapMargins)
		self.fillSuperview(axis: .horizontal, priority: priority, overlapMargins: overlapMargins)
	}
	func fillSuperview(
		axis: Axis,
		priority: UILayoutPriority = UILayoutPriority(rawValue: Float(1000)),
		overlapMargins: Bool = true
	) {
		self.translatesAutoresizingMaskIntoConstraints = false
		
		var visualFormat = "|-[subview]-|"
		if overlapMargins {
			visualFormat = "|[subview]|"
		}
		
		let constraints = NSLayoutConstraint.constraints(
			withVisualFormat: axis.rawValue+":"+visualFormat,
			options: NSLayoutConstraint.FormatOptions(),
			metrics: nil,
			views: ["subview": self]
		)
		
		for constraint in constraints {
			constraint.priority = priority
		}
		self.superview?.addConstraints(constraints)
	}

	func roundCorners(cornerRadius: Double, type: Int = 0) {
		self.layer.cornerRadius = CGFloat(cornerRadius)
		self.clipsToBounds = true
		
		
			switch type {
				case 0:
					self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner,.layerMaxXMinYCorner, .layerMaxXMaxYCorner
					]
				//upper corners
				case 1:
					self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
						//bottom corners
				case 2:
					self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
						//left corners
				case 3:
					self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
						//right corners
				case 4:
					self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
						//upper right corner
				case 5:
					self.layer.maskedCorners = [.layerMaxXMinYCorner]
						//Upper left corner
				case 6:
					self.layer.maskedCorners = [.layerMinXMinYCorner]
						//Lower left corner
				case 7:
					self.layer.maskedCorners = [.layerMinXMaxYCorner]
						//Lower Right corner
				case 8:
					self.layer.maskedCorners = [.layerMaxXMaxYCorner]
						//custom case
				case 9:
					self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
						//custom case right corners
				case 10:
					self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
				default:
					break
			}
	}

}
