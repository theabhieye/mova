//
//  Wireframe.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import UIKit

class Wireframe: NSObject {
	
	private(set) weak var navigationController: UINavigationController!
	
	required init(navigationController: UINavigationController?) {
		self.navigationController = navigationController
	}
	
}
