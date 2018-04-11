//
//  FavoriteMoviesAssembly.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

class FavoritePopularMoviesAssembly {
    
    static let sharedInstance = FavoritePopularMoviesAssembly()
    
    
    func configure(_ viewController: FavoritePopularMoviesViewController) {
        
        let presenter = FavoritePopularMoviesPresenter()
        let interactor = FavoritePopularMoviesInteractor()
        let router = FavoritePopularMoviesRouting()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = viewController
        
    }
}
