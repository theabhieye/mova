//
//  MovieLisingViewController.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import UIKit

class MovieListingViewController: UIViewController {
	
	@IBOutlet weak var movieCollectionView: UICollectionView!
	@IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
	
	public var presenter:MovieListingPresenter!
	
	private let searchReuseIdentifier = "SearchItemCell"
	private let movieListingReuseIdentifier = "MovieListCollectionViewCell"
	private var searchResponse:[SearchResponse] = []
	private var currentPage:Int = 1
	private var totalMovie:Int = 0
	private var pageRefreshing: Bool = false
	private var searchKey:String  = "marvels"
	private var indicator: UIActivityIndicatorView?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.setupUI()
		self.getMovieList(searchQuery: searchKey)
	}
	
	private func setupUI(){
		self.movieCollectionView.register(UINib(nibName: searchReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: searchReuseIdentifier)
		self.movieCollectionView.register(UINib(nibName: movieListingReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: movieListingReuseIdentifier)
		self.view.backgroundColor = .white
		self.movieCollectionView.delegate = self
		self.movieCollectionView.dataSource = self
		
		let indicator = UIActivityIndicatorView.init(style: .medium)
		indicator.center = self.view.center
		view.addSubview(indicator)
		indicator.bringSubviewToFront(view)
		indicator.startAnimating()
		indicator.hidesWhenStopped = true
		indicator.isHidden = true
		self.indicator = indicator
	}
	
	private func getMovieList(searchQuery: String){
		self.presenter.getMovieList(searchQuery: searchQuery, currentPage: self.currentPage)
	}
}
extension MovieListingViewController:UICollectionViewDelegate,UICollectionViewDataSource{
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 2
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch section {
			case 0:
				return 1
			case 1:
				return searchResponse.count
			default:
				return 0
		}
	}

	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch indexPath.section {
			case 0:
				return getSearchCollectionViewCell(indexPath)
			case 1:
				return getMovieListCollectionViewCell(indexPath)
			default:
				return UICollectionViewCell()
		}
	}
 
	private func getSearchCollectionViewCell(_ indexPath:IndexPath) -> SearchItemCell {
		let cell = self.movieCollectionView.dequeueReusableCell(withReuseIdentifier: searchReuseIdentifier, for: indexPath) as! SearchItemCell
		cell.delegate = self
		cell.config(showKeyboard: false)
		return cell
	}
	 
	private func getMovieListCollectionViewCell(_ indexPath:IndexPath) -> MovieListCollectionViewCell {
		let cell:MovieListCollectionViewCell = self.movieCollectionView.dequeueReusableCell(withReuseIdentifier: movieListingReuseIdentifier, for: indexPath) as! MovieListCollectionViewCell
		let searchItem = self.searchResponse[indexPath.row]
		cell.config(searchResponse: searchItem)
		return cell
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if(totalMovie==0 || searchResponse.isEmpty){
			return
		}
		
		print(searchResponse[indexPath.row].imdbID ?? "")
 		let imdbID = searchResponse[indexPath.row].imdbID ?? ""
		self.presenter.goToMovieDetailScreen(imdb: imdbID)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if(totalMovie <= self.searchResponse.count){
			return
		}
		
		if(self.movieCollectionView.contentOffset.y >= self.movieCollectionView.contentSize.height - self.movieCollectionView.bounds.size.height) {
			if !pageRefreshing {
				pageRefreshing = true
				self.currentPage = self.currentPage + 1
				getMovieList(searchQuery: self.searchKey)
				pageRefreshing = false
			}
		}
	}
 }

 
extension MovieListingViewController: MovieListingAdapater {
	
	
	func showErrorAlert(moviesResponse:MovieSearchResponse) {
		if totalMovie == 0 ||  totalMovie > self.searchResponse.count {
			Util.showAlert(
				title: "Response: \(moviesResponse.response ?? "")",
				messageString: "Error: \(moviesResponse.error ?? "")",
				buttons: nil,
				viewController: self,
				didSelect: nil
			)
		}
		
	}
	
	func showLoader() {
		indicator?.isHidden = false
		indicator?.startAnimating()
	}
	
	func hideLoader() {
		indicator?.isHidden = true
		indicator?.stopAnimating()
	}
	
	func updateMoiveResponse(_ moviesResponse: MovieSearchResponse) {
		totalMovie = Int(moviesResponse.totalResults ?? "0") ?? 0
		var updateArr = [SearchResponse]()
		for i in moviesResponse.searchResponse ?? [SearchResponse]() {
			updateArr.append(i)
		}
		searchResponse.append(contentsOf: updateArr)
		movieCollectionView.reloadData()
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
}
extension MovieListingViewController:SearchItemCellDelegate{
	func searchMovieName(movie: String) {
		self.currentPage = 1
		self.searchResponse.removeAll()
		self.searchKey = movie
		DispatchQueue.main.async {
			self.movieCollectionView.reloadData()
		}
 		self.getMovieList(searchQuery: searchKey)
	}
}
