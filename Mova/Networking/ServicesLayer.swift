//
//  ServicesLayer.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import Foundation
protocol ServicesLayer {
	func getMovieList(movieDto:MovieSearchDTO, completion:@escaping ((_ movieSearchResponse:MovieSearchResponse?,_ error:String?) -> Void))
	func getMovieDetail(searchMovieDto:SearchResultDTO,completion:@escaping ((_ movieSearchResponse:SearchResultResponse?,_ error:String?) -> Void))
}
class ServiceLayerImpl:ServicesLayer {
	
	
	private let webSerview = Webservice.shared
	
	func getMovieList(movieDto:MovieSearchDTO, completion:@escaping ((_ movieSearchResponse:MovieSearchResponse?,_ error:String?) -> Void) ) {
		let url = API_CONSTANTS.BASE_URL+"s=\(movieDto.searchKey	.lowercased())&page=\(movieDto.pageNo)"
		print("request \(url)")
		webSerview.sendRequest(for: MovieSearchResponse.self, url: url, method: .get, headers: nil, body: nil) { result in
			do {
				let moviesResponse = try result.resolve()
				completion(moviesResponse,nil)
			} catch {
				completion(nil,Constants.String.errorMessage)
			}
		}
	}
	
	func getMovieDetail(searchMovieDto: SearchResultDTO, completion: @escaping ((SearchResultResponse?, String?) -> Void)) {
		let url = API_CONSTANTS.BASE_URL+"i="+searchMovieDto.imdbId
		
		print("url \(url)")
		webSerview.sendRequest(for: SearchResultResponse.self, url: url, method: .get, headers: nil, body: nil) { result in
			do {
				let searchResultResponse = try result.resolve()
				completion(searchResultResponse,nil)
			} catch {
				completion(nil,Constants.String.errorMessage)
			}
		}
	}
}
