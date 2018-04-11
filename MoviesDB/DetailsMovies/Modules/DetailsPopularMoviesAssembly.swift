//
//  DetailsPopularMoviesAssembly.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 20/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation

class DetailsPopularMoviesAssembly {
    
    static let sharedInstance = DetailsPopularMoviesAssembly()
    
    func configure(_ viewController: DetailsPopularMoviesViewController) {
        
        let manager = PopularMoviesDataManager()
        let listGenreManager = DetailsPopularMoviesManager()
        let interactor = DetailsPopularMoviesInteractor()
        let presenter = DetailsPopularMoviesPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        presenter.interactor = interactor
        interactor.imageDataManager = manager
        interactor.detilsPopularMoviesManager = listGenreManager
        
    }
    
}
