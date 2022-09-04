//
//  MovieListingAdapater.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import Foundation
protocol MovieListingAdapater: NSObject {
	func updateMoiveResponse(_ moviesResponse:MovieSearchResponse)
	func showLoader()
	func hideLoader()
	func showErrorAlert(moviesResponse:MovieSearchResponse)
	func showUnknownErrorAlert(error:String)
}
