//
//  MovieDetailAdapater.swift
//  Mova
//
//  Created by Abhishek kapoor on 04/09/22.
//

import Foundation
protocol MovieDetailAdapater:NSObject{
	func showLoader()
	func hideLoader()
	func updateView(movieSearchResult:SearchResultResponse?)
	func showErrorAlert(moviesResponse:SearchResultResponse)
	func showUnknownErrorAlert(error:String)
}
