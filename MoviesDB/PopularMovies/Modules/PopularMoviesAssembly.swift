//
//  MoviesAssembly.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation

class PopularMoviesAssembly {
    
    static let shredInstance = PopularMoviesAssembly()
    
    func configure(_ viewController: PopularMoviesViewController) {
        
        let manager = PopularMoviesDataManager()
        let interactor = PopularMoviesInteractor()
        let presenter = PopularMoviesPresenter()
        let router = PopularMoviesRouting()
        router.viewController = viewController
        presenter.router = router
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        presenter.interactor = interactor
        interactor.moviesDataManager = manager
    }
    
}
