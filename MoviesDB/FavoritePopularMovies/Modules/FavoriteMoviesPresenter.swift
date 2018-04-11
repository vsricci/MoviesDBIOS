//
//  FavoriteMoviesPresenter.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavoritePopularMoviesPresenterInput : FavoritePopularMoviesInteractorOutput, FavoritePopularMoviesViewControllerOutput {
    
}

class FavoritePopularMoviesPresenter: FavoritePopularMoviesPresenterInput {

    
    var view : FavoritePopularMoviesViewControllerInput!
    var interactor : FavoritePopularMoviesInteractorInput!
    var router : FavoriteMoviesRoutingInput!
    
    func fetchFavoritePopularMovies() -> Results<Movie>{
        
        
       return  self.interactor.getFavoritePopularMovies()
    }
    
   
    
    
    func goToFilterFavoritePopularMoviesScreen() {
        
        self.router.navigationToFiltersPopularFavoriteMovie()
    }
    
    func passDataToNextScene(_ segue: UIStoryboardSegue) {
        
        self.router.passDataToNextScene(segue)
        
    }
    
}
