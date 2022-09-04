//
//  MovieDetailViewController.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import UIKit


class MovieDetailViewController: UIViewController {
	
	private let movieGenreCollectionViewCell = "MovieGenreCollectionViewCell"
	@IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
	@IBOutlet weak var bottomViewTopConstrants: NSLayoutConstraint!
	@IBOutlet weak var imdbRatingLbl: UILabel!
	@IBOutlet weak var collapsableHeaderView: CollapsableHeaderView!
	@IBOutlet weak var collapsableHeaderViewHeight: NSLayoutConstraint!
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var bottomDetailView: UIView!
	@IBOutlet weak var progressView: UIView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var movieGenreCollectionView: UICollectionView!
	@IBOutlet weak var lengthLbl: UILabel!
	@IBOutlet weak var languageLbl: UILabel!
	@IBOutlet weak var ratedLbl: UILabel!
	@IBOutlet weak var rateValueLbl: UILabel!
	@IBOutlet weak var languageValueLbl: UILabel!
	@IBOutlet weak var lengthValueLbl: UILabel!
	@IBOutlet weak var descLbl: UILabel!
	@IBOutlet weak var descValueLbl: UILabel!
	@IBOutlet weak var actorValueLbl: UILabel!
	@IBOutlet weak var actorLbl: UILabel!
	@IBOutlet weak var scrollViewContainer: UIView!
	
	var presenter:MovieDetailsPresenter!
	var imdb:String!
	
	private var searchResultResponse: SearchResultResponse?
	private var genreData = [Substring]()
	private var indicator: UIActivityIndicatorView?
 
	override func viewDidLoad() {
        super.viewDidLoad()
 		self.collapsableHeaderViewHeight.constant = 200
		self.bottomViewTopConstrants.constant = self.collapsableHeaderViewHeight.constant
		self.bottomDetailView.roundCorners(cornerRadius: 10,type: 1)
		
		self.movieGenreCollectionView.register(UINib(nibName: movieGenreCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: movieGenreCollectionViewCell)
		
		self.movieGenreCollectionView.delegate = self
		self.movieGenreCollectionView.dataSource = self
		self.titleLbl.textColor = UIColor.random()
		self.lengthLbl.textColor = UIColor(hexString: Constants.HexCodes.lightGrey)
		self.lengthValueLbl.textColor = UIColor(hexString: Constants.HexCodes.headingColor)
		
		self.ratedLbl.textColor = UIColor(hexString: Constants.HexCodes.lightGrey)

		self.rateValueLbl.textColor = UIColor(hexString: Constants.HexCodes.headingColor)
		
		
		self.languageLbl.textColor = UIColor(hexString: Constants.HexCodes.lightGrey)
		
		self.languageValueLbl.textColor = UIColor(hexString: Constants.HexCodes.headingColor)

		self.descLbl.textColor = UIColor(hexString: Constants.HexCodes.headingColor)
		
		self.descValueLbl.textColor = UIColor(hexString: Constants.HexCodes.lightGrey)
		self.actorLbl.textColor = UIColor(hexString: Constants.HexCodes.headingColor)
		
		self.actorValueLbl.textColor = UIColor(hexString: Constants.HexCodes.lightGrey)
 
		self.activityIndicator.hidesWhenStopped = true
		self.progressView.roundCorners(cornerRadius: 5)
		self.progressView.backgroundColor = .systemFill
		self.getMovieDetial()
    }
	
	private func getMovieDetial(){
		self.presenter.getMovieDetial(self.imdb)
	}
}
extension MovieDetailViewController:UICollectionViewDelegate,UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		genreData.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return setupGenreCollectionViewCell(indexPath)
	}
	
	private func setupGenreCollectionViewCell(_ indexPath:IndexPath) -> UICollectionViewCell{
		let cell = self.movieGenreCollectionView.dequeueReusableCell(withReuseIdentifier: movieGenreCollectionViewCell, for: indexPath) as! MovieGenreCollectionViewCell
		cell.config(genre: String(genreData[indexPath.row]))
		return cell
	}
}
extension MovieDetailViewController:MovieDetailAdapater {

	func showErrorAlert(moviesResponse: SearchResultResponse) {
		Util.showAlert(
			title: "Response: \(moviesResponse.response ?? "")",
			messageString: "Error: \(moviesResponse.error ?? "")",
			buttons: nil,
			viewController: self,
			didSelect: nil
		)
	}
	
	func showUnknownErrorAlert(error: String) {
		Util.showAlert(
			title: "Unknown Error:",
			messageString: error,
			buttons: nil,
			viewController: self,
			didSelect: nil
		)
	}
	
	func showLoader() {
		self.activityIndicator.startAnimating()
		self.progressView.isHidden = false
	}
	
	func hideLoader() {
		self.activityIndicator.stopAnimating()
		self.progressView.isHidden = true
	}
	
	func updateView(movieSearchResult: SearchResultResponse?) {
		self.searchResultResponse = movieSearchResult
		self.ratedLbl.text = Constants.String.rating
		self.lengthLbl.text = Constants.String.length
		self.languageLbl.text = Constants.String.language
		self.descLbl.text = Constants.String.desc
		self.actorLbl.text = Constants.String.cast
		self.collapsableHeaderView.config(imageUrl: searchResultResponse?.poster)
		self.imdbRatingLbl.text = "\(String(describing: searchResultResponse?.imdbRating ?? "-")) imdB"
		self.titleLbl.text = searchResultResponse?.title
		self.lengthValueLbl.text = searchResultResponse?.runtime
		self.rateValueLbl.text = searchResultResponse?.rated
		self.languageValueLbl.text = searchResultResponse?.language
		self.descValueLbl.text = searchResultResponse?.plot
		self.actorValueLbl.text = searchResultResponse?.actors
		if let genre = searchResultResponse?.genre{
			if(genre.contains(",")) {
				let genreArr = genre.split(separator: ",")
				self.genreData = genreArr
				if(genreArr.isEmpty) {
					self.collectionViewHeight.constant = 0
				} else {
					self.collectionViewHeight.constant = 42
				}
				self.movieGenreCollectionView.reloadData()
			} else {
				self.collectionViewHeight.constant = 0
			}
		}
	}
}
