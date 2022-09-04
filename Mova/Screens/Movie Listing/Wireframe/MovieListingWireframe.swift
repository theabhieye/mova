//
//  MovieListingWireframe.swift
//  Mova
//
//  Created by Abhishek kapoor on 03/09/22.
//

import UIKit

protocol MovieListingWireframe{
	func goToMovieDetailScreen(imdb:String)
	func goToPreviousScreen()
}

class MovieListingWireframeImpl:Wireframe, MovieListingWireframe {
	
	static func push(inNavigationController
					 navigationController:UINavigationController
	) {
		let wireframe = MovieListingWireframeImpl(navigationController: navigationController)

		let view = MovieListingViewController.instantiateFromStoryBoard(appStoryBoard: .MovieListingViewController)

		let interector = InteractorFactory.sharedInstance.movieListingInterctor()

		let presenter = MovieListingPresenter(view: view, wireframe: wireframe, screenInteractor: interector)
		 
		view.presenter = presenter
		
		wireframe.navigationController.pushViewController(view, animated: true)
	}
	
	
	static func showAsRoot(inNavigationController navigationController: UINavigationController) {
		let wireframe = MovieListingWireframeImpl(navigationController: navigationController)
		
		let view = MovieListingViewController.instantiateFromStoryBoard(appStoryBoard: .MovieListingViewController)
		
		let interector = InteractorFactory.sharedInstance.movieListingInterctor()
		
		let presenter = MovieListingPresenter(view: view, wireframe: wireframe, screenInteractor: interector)
		
		view.presenter = presenter
		
		wireframe.navigationController.viewControllers = [view]
		wireframe.navigationController.navigationBar.isHidden = true
		
		let appDelegate = UIApplication.shared.delegate
		appDelegate?.window??.rootViewController = wireframe.navigationController
		
	}

	
	func goToMovieDetailScreen(imdb: String) {
		MovieDetailWireframeImpl.push(inNavigationController: navigationController, imdb: imdb)
	}
	
	func goToPreviousScreen(){
		self.navigationController.popViewController(animated: true)
	}
}
