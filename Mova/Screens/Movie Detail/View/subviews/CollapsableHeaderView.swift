//
//  CollapsableHeaderView.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import UIKit

class CollapsableHeaderView: LoadableFromXibView {
	@IBOutlet weak var headerImage: UIImageView!
	
	public func config(imageUrl:String?){
		if let imageUrl = imageUrl {
			headerImage.loadImageUsingCache(withUrl: imageUrl)
		} else {
			headerImage.image = Asset.placeholderImage
		}
	}
	
}
