//
//  TypeFilterPopularFavoriteMoviesAssembly.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation

class TypeFilterPopularFavoriteMoviesAssembly {
    
    static let sharedInstance =  TypeFilterPopularFavoriteMoviesAssembly()
    
    func configure(viewController: TypeFilterPopularFavoriteMoviesViewController) {
        
        let manager = DetailsPopularMoviesManager()
        let presenter = TypeFilterPopularFavoriteMoviesPresenter()
        let interactor = TypeFilterPopularFavoriteMoviesInteractor()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.manager = manager
    }
}
