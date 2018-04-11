//
//  FavoriteMoviesInteractor.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavoritePopularMoviesInteractorInput : class {
    func getFavoritePopularMovies() -> Results<Movie>
}

protocol FavoritePopularMoviesInteractorOutput : class {
    
}



class FavoritePopularMoviesInteractor: FavoritePopularMoviesInteractorInput  {
    
    var presenter : FavoritePopularMoviesPresenterInput!
    
    
    func getFavoritePopularMovies() -> Results<Movie> {
        
        let realm = try! Realm()
        
        return realm.objects(Movie.self)
    }
}
