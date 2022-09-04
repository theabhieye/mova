//
//  MovieSearchResponse.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import Foundation

// MARK: - MovieSearchResponse
struct MovieSearchResponse: Codable {
	var searchResponse: [SearchResponse]?
	var totalResults, response,error: String?
	
	
	enum CodingKeys: String, CodingKey {
		case searchResponse = "Search"
		case totalResults
		case response = "Response"
		case error = "Error"
	}
	
	init(search: [SearchResponse]?, totalResults: String?, response: String?,error:String?) {
		self.searchResponse = search
		self.totalResults = totalResults
		self.response = response
		self.error = error
	}
}

// MARK: - Search
struct SearchResponse: Codable {
	var title, year, imdbID: String?
	var type: TypeEnum?
	var poster: String?
	
	enum CodingKeys: String, CodingKey {
		case title = "Title"
		case year = "Year"
		case imdbID
		case type = "Type"
		case poster = "Poster"
	}
	
	init(title: String?, year: String?, imdbID: String?, type: TypeEnum?, poster: String?) {
		self.title = title
		self.year = year
		self.imdbID = imdbID
		self.type = type
		self.poster = poster
	}
}

enum TypeEnum: String, Codable {
	case movie = "movie"
	case series = "series"
}
