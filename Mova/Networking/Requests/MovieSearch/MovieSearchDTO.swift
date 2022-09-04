//
//  MovieSearchDTO.swift
//  Mova
//
//  Created by Abhishek kapoor on 04/09/22.
//

import Foundation
class MovieSearchDTO {
	let pageNo:Int
	let searchKey:String
	init(pageNo:Int,searchKey:String){
		self.pageNo = pageNo
		self.searchKey = searchKey
	}
}
