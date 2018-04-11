//
//  DetailsPopularMoviesPresenter.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 20/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import RealmSwift


protocol DetailsPopularMoviesPresenterInput : DetailsPopularMoviesViewControllerOutput, DetailsPopularMoviesInteractorOutput {
    
}

class DetailsPopularMoviesPresenter: DetailsPopularMoviesPresenterInput {
    
    
    var view : DetailsPopularMoviesViewControllerInput!
    var interactor : DetailsPopularMoviesInteractorInput!
    
    
    // Pass data from PhotoSearch Module Router
    
    func selectedDataPopularMovie(_ popularMovie: Movie){
        
        self.interactor.configurePopularMovieModel(popularMovie: popularMovie)
    }
    
    func selectedGenres(_ genres : List<Genre>) {
        
        self.interactor.configureGenres(genres: genres)
    }
    
    func loadPopularMovieImage() {
        
        self.interactor.loadUIImageUrl()
    }
    
    func sendLoadedPopularMovieImage(_ image: UIImage) {
        self.view.addLoadedPopularImage(image)
    }
    
    func sendPopularMovieName() {
        
        let title = self.interactor.getPopularMovieTile()
        self.view.addPopularMovieName(title)
    }
    
    func sendPopularMovieYear() {
        let year = self.interactor.getPopularMovieYear()
        self.view.addPopularMovieYear(year)
        
    }
    
    func sendPopularMovieDescription() {
        let description = self.interactor.getPopularMovieDescription()
        self.view.addDescriptionPopularMovie(description)
        
    }
    
    func sendPopularMovieGenre(){
        let genresArray = self.interactor.getPopularMovieGenres()
        
        self.view.addPopularMovieGenre(genresArray!)
    }
    
    
    func sendGenresDetailsPopularMovies(url: String, api_key: String, language: String) {
        
        self.interactor.getGenresDetailsPopularMovies(url: url, api_key: api_key, language: language)
    }
    
    func providedGenresPopularMovies(genres: List<Genre>)  {
       
         self.view.addGenresDetailsPopularMovies(genres)
    }
    
    func favoritedPopularMovie() {
        
        let movies = self.interactor.getMovies()
        let genres = self.interactor.getGenres()
        self.interactor.getFavoritePopularMovie(movies: movies, genres: genres!)

    }
    
    func stateButtonFavorited(sender: UIButton){
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true {
            
            sender.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        }
        
    }
   
    func serviceError(_ error: NSError){
        self.view.displayErrorView(errorMessage)
    }
    
    
    func alertPopularMovie() {
        
        self.view.addAlertPopularMovieFavorited()
    }
    
}
