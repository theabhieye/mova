//
//  MovieDetailWireframe.swift
//  Mova
//
//  Created by Abhishek kapoor on 04/09/22.
//

import UIKit

protocol MovieDetailWireframe {
	func goToPreviousScreen()
	
}

class MovieDetailWireframeImpl:Wireframe,MovieDetailWireframe {
	
	static func push(inNavigationController
					 navigationController:UINavigationController,
					 imdb:String
	){
		let wireframe = MovieDetailWireframeImpl(navigationController: navigationController)
		
		let view = MovieDetailViewController.instantiateFromStoryBoard(appStoryBoard: .MovieDetailViewController)
		
		let intercator = InteractorFactory.sharedInstance.movieDetailsInterctor()
		
		let presenter = MovieDetailsPresenter(view: view, wireframe: wireframe, screenInteractor: intercator)
		
		view.presenter = presenter
		view.imdb = imdb
		
		navigationController.pushViewController(view, animated: true)
	}
	
	
	func goToPreviousScreen(){
		self.navigationController.popViewController(animated: true)
	}
}
