//
//  MovieListingInterector.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import Foundation

protocol MovieListingInterector{
	func getMovieList(movieDto:MovieSearchDTO, completion:@escaping ((_ movieSearchResponse:MovieSearchResponse?,_ error:String?) -> Void) )
}
class MovieListingInterectorImpl:MovieListingInterector{
	private var serviceLayer: ServicesLayer
	
	init(serviceLayer:ServicesLayer) {
		self.serviceLayer = serviceLayer
	}
	
	func getMovieList(movieDto: MovieSearchDTO, completion: @escaping (MovieSearchResponse?, String?) -> Void) {
		self.serviceLayer.getMovieList(movieDto: movieDto) { movieSearchResponse, error in
			if(movieSearchResponse == nil){
				completion(nil,Constants.String.errorMessage)
			} else {
				completion(movieSearchResponse,nil)
			}
		}
	}
	
	 
}
