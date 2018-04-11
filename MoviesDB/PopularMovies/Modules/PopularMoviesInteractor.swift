//
//  MoviesInteractor.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import RealmSwift
protocol PopularMoviesInteractorInput : class {
    
    func setPopularMovies(_ url: String, apiKey: String, language: String, page: Int)
    func getFavoritePopularMovies() -> Results<Movie>
}

protocol PopularMoviesInteractorOutput : class {
    
    func providedPopularMovies(_ popularMovies : List<Movie>, totalPages: NSInteger)
    func serviceError(_ error: NSError)
}

class PopularMoviesInteractor : PopularMoviesInteractorInput {
    
    weak var presenter : PopularMoviesInteractorOutput!
    var moviesDataManager : PopularMoviesProtocol!
    
    func setPopularMovies(_ url: String, apiKey: String, language: String, page: Int) {
        
        moviesDataManager.moviesGridList(url: url, apiKey: apiKey, language: language, page: page, responseSuccess: { (result, pages, statusCode) in
            
            print(result?.results.count)
            
            self.presenter.providedPopularMovies((result?.results)!, totalPages: pages)
            
        }) { (error, statuscode) in
            
            self.presenter.serviceError(error!)
        }
        
    }
    
    func getFavoritePopularMovies() -> Results<Movie> {
        
        let realm = try! Realm()
       
            realm.beginWrite()
            let listResults = realm.objects(Movie.self)
            try! realm.commitWrite()
     
        return listResults
    }
}
