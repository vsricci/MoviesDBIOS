//
//  FavoriteMoviesRouting.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit


protocol FavoriteMoviesRoutingInput: class {
    
    func navigationToFiltersPopularFavoriteMovie()
    func passDataToNextScene(_ segue: UIStoryboardSegue)
}

class FavoritePopularMoviesRouting: FavoriteMoviesRoutingInput  {
    
    
    var viewController = FavoritePopularMoviesViewController()
    
    
    func navigationToFiltersPopularFavoriteMovie() {
        viewController.performSegue(withIdentifier: identifies.ShowFilterPopularFaoriteMovies.rawValue, sender: nil)
        
    }
    
    func passDataToNextScene(_ segue: UIStoryboardSegue) {
        
        if segue.identifier == identifies.ShowFilterPopularFaoriteMovies.rawValue {
            passDataToshowFiltersPopularFavoriteMovieScene(segue)
        }
    }
    
    // navigate to another module
    func passDataToshowFiltersPopularFavoriteMovieScene(_ segue: UIStoryboardSegue) {
        
        if let selectedIndexPath = viewController.tableView.indexPathForSelectedRow {
            let selectedPopularMovieModel = viewController.favoriteMovies[selectedIndexPath.row]
              let showFiltersPopularFavoriteMovieVC = segue.destination as! FilterPopularFavoriteMoviesViewController
            showFiltersPopularFavoriteMovieVC.customDelegate = viewController.self
            
            
            
        }
    }
    
}
