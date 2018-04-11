//
//  DetailsPopularMoviesInteractor.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 20/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import RealmSwift



protocol DetailsPopularMoviesInteractorInput: class {
 
    func loadUIImageUrl()
    func getPopularMovieTile() -> String
    func getPopularMovieYear() -> String
    func getPopularMovieGenres() -> List<Int>?
    func getPopularMovieDescription() -> String
    func configurePopularMovieModel(popularMovie: Movie)
    func configureGenres(genres: List<Genre>)
   // func getFavoritePopularMovie(movies: Movie)
    func getFavoritePopularMovie(movies: Movie, genres: List<Genre>)
    func getMovies() -> Movie
    func getGenres() -> List<Genre>?
    
    func getGenresDetailsPopularMovies(url: String, api_key: String, language: String)
}

protocol DetailsPopularMoviesInteractorOutput: class {
    func sendLoadedPopularMovieImage(_ image: UIImage)
    func providedGenresPopularMovies(genres: List<Genre>)
    func serviceError(_ error: NSError)
    
}

class DetailsPopularMoviesInteractor: DetailsPopularMoviesInteractorInput {
   
    
    
    
    
    var presenter : DetailsPopularMoviesInteractorOutput!
    var popularMovie: Movie?
    var genres : List<Genre>?
    var imageDataManager : PopularMoviesProtocol!
    var detilsPopularMoviesManager: DetailsPopularMoviesManager!
    
    
    
    func configurePopularMovieModel(popularMovie: Movie){
        
        self.popularMovie = popularMovie
    }
    
    func configureGenres(genres: List<Genre>) {

        self.genres = genres
    }
    
    func loadUIImageUrl(){
        
        let url = URL(string: "\(imageBegginURL)\(self.popularMovie!.backdrop_path)")
        imageDataManager.loadImageFromUrl(url?.absoluteURL as! NSURL ) { (image, error) in
            
            if let image = image {
                self.presenter.sendLoadedPopularMovieImage(image)
            }
            
            else {
                self.presenter.serviceError(error!)
            }
        }
    }

    
    func getPopularMovieTile() -> String {
        if let title = self.popularMovie?.title {
            
            return title
        }
        return ""
    }
    
    func getPopularMovieYear() -> String {
        if let year = self.popularMovie?.release_date {
            return year
        }
        return ""
    }
    
    func getPopularMovieGenres() -> List<Int>? {
        
        if let genres = self.popularMovie?.genre_ids {
            
            return genres
        }
        
        return nil
    }
    
    func getGenres() -> List<Genre>? {

        if let genres = self.genres {

            return genres
        }
        return nil
    }
    
    func getPopularMovieDescription() -> String {
        if let description = self.popularMovie?.overview {
            return description
        }
        return ""
    }
    
    func getMovies() -> Movie {
        
        let movies = self.popularMovie
        return movies!
    }
    
    
    
    func getGenresDetailsPopularMovies(url: String, api_key: String, language: String){
        
        self.detilsPopularMoviesManager.getGenresPopolarMovies(url: url, api_key: api_key, language: language, responseSuccess: { (results, statusCode) in
            
            print(results.genres)
            
            self.presenter.providedGenresPopularMovies(genres: results.genres)
            
        }) { (error, stasusCode) in
            
            self.presenter.serviceError(error as NSError)
        }
    }
    
    
    func getFavoritePopularMovie(movies: Movie, genres: List<Genre>) {
        
        movies.descriptionGenre = genres
        
        print(movies.descriptionGenre)
        let realm = try! Realm()
        
        do {
            try!
            realm.write {
                realm.add(movies)
                
            }
        }
        
    }
    
}
