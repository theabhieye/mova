//
//  MovieDetailInterector.swift
//  Mova
//
//  Created by Abhishek kapoor on 04/09/22.
//

import Foundation
protocol MovieDetailsInterector {
	func getMovieDetail(searchMovieDto: SearchResultDTO, completion: @escaping ((SearchResultResponse?, String?) -> Void))
}
class MovieDetailsInterectorImpl:MovieDetailsInterector {
	private var serviceLayer: ServicesLayer
	
	init(serviceLayer:ServicesLayer) {
		self.serviceLayer = serviceLayer
	}
	
	func getMovieDetail(searchMovieDto: SearchResultDTO, completion: @escaping ((SearchResultResponse?, String?) -> Void)) {
		self.serviceLayer.getMovieDetail(searchMovieDto: searchMovieDto) { movieSearchResponse, error in
			if(movieSearchResponse == nil){
				completion(nil,Constants.String.errorMessage)
			} else {
				completion(movieSearchResponse,nil)
			}
		}
	}
}
