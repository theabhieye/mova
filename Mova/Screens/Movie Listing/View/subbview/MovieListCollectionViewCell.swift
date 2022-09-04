//
//  MovieListTableViewCell.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell{

	@IBOutlet weak var containerBGView: UIView!
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var posterImg: UIImageView!
	@IBOutlet weak var typeLbl: UILabel!
	
	var searchResponse:SearchResponse?
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }
	 
	public func config(searchResponse:SearchResponse?) {
		self.containerBGView.roundCorners(cornerRadius: 10)
		self.posterImg.roundCorners(cornerRadius: 20)
		self.titleLbl.text = searchResponse?.title ?? String()
		self.typeLbl.text = (searchResponse?.type?.rawValue ?? String()).uppercased()
		if let img = searchResponse?.poster {
			self.posterImg.loadImageUsingCache(withUrl: img)
		} else {
			self.posterImg.image = Asset.placeholderImage
		}
	}
}
