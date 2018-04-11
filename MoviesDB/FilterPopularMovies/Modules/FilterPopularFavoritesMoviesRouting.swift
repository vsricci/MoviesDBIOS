//
//  FilterPopularFavoritesMoviesRouting.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

protocol FilterPopularFavoriteMoviesRoutingInput: class {
    
    func navigationToTypeFilterPopularFavoriteMovie()
    func passDataToNextScene(_ segue: UIStoryboardSegue)
    
}

class FilterPopularFavoriteMoviesRouting: FilterPopularFavoriteMoviesRoutingInput {
    
    var viewController : FilterPopularFavoriteMoviesViewController!
    
    func navigationToTypeFilterPopularFavoriteMovie() {
        viewController.performSegue(withIdentifier: identifies.ShowTypeFilterPopularFaoriteMovies.rawValue, sender: nil)
        
    }
    
    func passDataToNextScene(_ segue: UIStoryboardSegue) {
        
        if segue.identifier == identifies.ShowTypeFilterPopularFaoriteMovies.rawValue {
            passDataToshowTypeFilterPopularFavoriteMovieScene(segue)
        }
    }
    
    // navigate to another module
    func passDataToshowTypeFilterPopularFavoriteMovieScene(_ segue: UIStoryboardSegue) {
        
        if let selectedIndexPath = viewController.tableView.indexPathForSelectedRow {
            let selectedPopularMovieModel = viewController.listFilters[selectedIndexPath.row]
            let showTypeFilterPopularFavoriteMovieVC = segue.destination as! TypeFilterPopularFavoriteMoviesViewController
            showTypeFilterPopularFavoriteMovieVC.type = selectedPopularMovieModel
        }
    }
}
