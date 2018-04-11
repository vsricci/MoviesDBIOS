//
//  MoviesPresenter.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import RealmSwift

protocol PopularMoviesPresenterInput : PopularMoviesViewControllerOutput, PopularMoviesInteractorOutput {
    
    
}


class PopularMoviesPresenter: PopularMoviesPresenterInput {
   
    var view: PopularMoviesViewControllerInput!
    var interactor: PopularMoviesInteractorInput!
    var router : PopularMoviesRouterInput!
    
    func fetchMovies(_ url: String, apiKey: String, language: String, page: NSInteger) {
        if view.getTotalPopularMovies() == 0 {
            
            view.showWaitingView()
        }
        interactor.setPopularMovies(url, apiKey: apiKey, language: language, page: page)
    }
    
    
    func providedPopularMovies(_ popularMovies : List<Movie>, totalPages: NSInteger){
        self.view.hideWatingView()
        self.view.displayPopularMovies(popularMovies: popularMovies, totalPages: totalPages)
        
    }
    
    
    func getFavoritedPopularMovies() -> Results<Movie>{
        
        return self.interactor.getFavoritePopularMovies()
        
    }
    
    func serviceError(_ error: NSError){
        self.view.displayErrorView(errorMessage)
    }
    
    func goToPhotoDetailScreen() {
        
        self.router.navigationToPopularMovieDetail()
    }
    
    func passDataToNextScene(_ segue: UIStoryboardSegue) {
        
        self.router.passDataToNextScene(segue)
    }
}
