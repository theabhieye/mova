//
//  MovieListingPresenter.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import UIKit

class MovieListingPresenter:Presenter {
	private weak var view: MovieListingAdapater?
	private let wireframe: MovieListingWireframe
	private let screenInteractor: MovieListingInterector
	private var movieSearchResponse: MovieSearchResponse?
	
	
	init(view:MovieListingAdapater,
		 wireframe:MovieListingWireframe,
		 screenInteractor:MovieListingInterector
	) {
		self.view = view
		self.wireframe = wireframe
		self.screenInteractor = screenInteractor
		super.init()
	}
	
	public func getMovieList(searchQuery:String,currentPage:Int = 1){
		self.view?.showLoader()
		
		self.screenInteractor.getMovieList(movieDto: MovieSearchDTO(pageNo: currentPage, searchKey: searchQuery)) { [weak self] movieSearchResponse, error in
			DispatchQueue.main.async {
				self?.view?.hideLoader()
				if let error = error {
					self?.view?.showUnknownErrorAlert(error: error)
					return
				}
				guard let movieSearchResponse = movieSearchResponse else {
					return
				}

				if(movieSearchResponse.response == "False"){
					self?.view?.showErrorAlert(moviesResponse: movieSearchResponse)
				} else {
					self?.view?.updateMoiveResponse(movieSearchResponse)
				}
			}
		}
	}
	func goToMovieDetailScreen(imdb:String){
		wireframe.goToMovieDetailScreen(imdb: imdb)
	}
}
