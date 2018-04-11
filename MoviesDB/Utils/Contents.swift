//
//  Contents.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation




let API_KEY = "fbd3adec5c17e4fd9ab611820042e6c1"
//let photoSearchKey = "Party"
let errorTitle = "Erro"
let errorMessage = "Erro no serviço"
let ok = "Ok"
let defaultErrorMessage = "Erro"
let waitingKey = "Aguarde..."
let successo = "Successo"
let favoritado = "Filme favoritado"
let imageBegginURL = "https://image.tmdb.org/t/p/w500"

enum URLS : String {

    case popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key="
    case genresListURL = "https://api.themoviedb.org/3/genre/movie/list?api_key="
    
}

enum identifies : String {
    
    case ShowPopularMoviesDetail = "ShowPopularMoviesDetail"
    case ShowFilterPopularFaoriteMovies = "ShowFilterPopularFaoriteMovies"
    case ShowTypeFilterPopularFaoriteMovies = "ShowTypeFilterPopularFaoriteMovies"
}

enum TypeFilter : String {
    
    case date = "Dates"
    case genre = "Genres"
}


