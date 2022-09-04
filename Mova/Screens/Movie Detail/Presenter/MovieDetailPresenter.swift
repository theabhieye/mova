//
//  MovieDetailPresenter.swift
//  Mova
//
//  Created by Abhishek kapoor on 04/09/22.
//

import Foundation

class MovieDetailsPresenter:Presenter {
	private weak var view: MovieDetailAdapater?
	private let wireframe: MovieDetailWireframe
	private let screenInteractor: MovieDetailsInterector
	
	init(view:MovieDetailAdapater,
		 wireframe:MovieDetailWireframe,
		 screenInteractor:MovieDetailsInterector
	) {
		self.view = view
		self.wireframe = wireframe
		self.screenInteractor = screenInteractor
		super.init()
	}

	func getMovieDetial(_ imdbId:String){
		self.view?.showLoader()
		self.screenInteractor.getMovieDetail(searchMovieDto: SearchResultDTO(imdbId: imdbId)) {  [weak self] searchResultResponse, error in
			DispatchQueue.main.async {
				self?.view?.hideLoader()
				if let error = error {
					self?.view?.showUnknownErrorAlert(error: error)
					return
				}
				guard let searchResultResponse = searchResultResponse else {
					return
				}
				if(searchResultResponse.response == "False"){
					self?.view?.showErrorAlert(moviesResponse: searchResultResponse)
				} else {
					self?.view?.updateView(movieSearchResult: searchResultResponse)
				}
			}
		}
	}
	
	
}
