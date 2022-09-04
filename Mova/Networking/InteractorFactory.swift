//
//  InteractorFactory.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import Foundation
class InteractorFactory {
	static let sharedInstance = InteractorFactory()
	
	private init() {}
	
	func servicesLayer() -> ServicesLayer {
		return ServiceLayerImpl()
	}
	
	func movieListingInterctor() -> MovieListingInterector{
		return MovieListingInterectorImpl(serviceLayer: self.servicesLayer())
	}
	
	func movieDetailsInterctor() -> MovieDetailsInterector {
		return MovieDetailsInterectorImpl(serviceLayer: servicesLayer())
	}
}
