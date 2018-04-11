//
//  TypeFilterPopularFavoriteMoviesInteractor.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import RealmSwift

protocol TypeFilterPopularFavoriteMoviesInteractorInput: class {
    
    func getGenres(url: String, api_key: String, language: String)
}

protocol TypeFilterPopularFavoriteMoviesInteractorOutput: class {
    
    func providedGenres(genres: List<Genre>)
    func serviceError(_ error: NSError)
}


class TypeFilterPopularFavoriteMoviesInteractor: TypeFilterPopularFavoriteMoviesInteractorInput {
    
    
    
    var manager : DetailsPopularMoviesManager!
    var presenter : TypeFilterPopularFavoriteMoviesPresenterInput!
    
    func getGenres(url: String, api_key: String, language: String){
        
        self.manager.getGenresPopolarMovies(url: url, api_key: api_key, language: language, responseSuccess: { (results, statusCode) in
            
            print(results.genres)
            
            self.presenter.providedGenres(genres: results.genres)
            
        }) { (error, stasusCode) in
            
            self.presenter.serviceError(error as NSError)
        }
    }
}
