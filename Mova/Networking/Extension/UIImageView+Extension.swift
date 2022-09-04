//
//  UIImageView+Extension.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//
//  source :- https://stackoverflow.com/a/52330296/19375387
import UIKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
	func loadImageUsingCache(withUrl urlString : String) {
		let url = URL(string: urlString)
		if url == nil {return}
		self.image = nil
		
		// check cached image
		if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
			self.image = cachedImage
			return
		}
		
		let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
		addSubview(activityIndicator)
		activityIndicator.startAnimating()
		activityIndicator.center = self.center
		
		URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
			DispatchQueue.main.async {
				activityIndicator.removeFromSuperview()

				if error != nil {
					self.image = Asset.placeholderImage
					return
				}
				if let image = UIImage(data: data!) {
 					imageCache.setObject(image, forKey: urlString as NSString)
					self.image = image
				}
			}
			
		}).resume()
	}
}

