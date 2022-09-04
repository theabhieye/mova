//
//  MovieGenreCollectionViewCell.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import UIKit

class MovieGenreCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var bgContentView: UIView!
	
	@IBOutlet weak var genreLbl: UILabel!
	
	public func config(genre:String){
		self.bgContentView.roundCorners(cornerRadius: 4,type: 2)
		self.bgContentView.backgroundColor = UIColor(hexString: Constants.HexCodes.genreBgColor)
		self.genreLbl.textColor = UIColor(hexString: Constants.HexCodes.genreLblColor)
		self.genreLbl.text = genre
	}
}
