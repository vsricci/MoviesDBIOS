//
//  TypeFilterPopularFavoriteMoviesPresenter.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import  RealmSwift

protocol TypeFilterPopularFavoriteMoviesPresenterInput: TypeFilterPopularFavoriteMoviesViewControllerOutput, TypeFilterPopularFavoriteMoviesInteractorOutput {
    
    
}

class TypeFilterPopularFavoriteMoviesPresenter: TypeFilterPopularFavoriteMoviesPresenterInput {
    
    
    var view : TypeFilterPopularFavoriteMoviesViewControllerInput!
    var interactor : TypeFilterPopularFavoriteMoviesInteractorInput!
    
    func providedGenres(genres: List<Genre>)  {
        
        self.view.showGetGenres(popularMovies: genres)
        
    }
    
    
    func getGenres(url: String, api_key: String, language: String) {
        
        self.interactor.getGenres(url: url, api_key: api_key, language: language)
    }
    
    func serviceError(_ error: NSError){
        self.view.displayErrorView(errorMessage)
    }
}
