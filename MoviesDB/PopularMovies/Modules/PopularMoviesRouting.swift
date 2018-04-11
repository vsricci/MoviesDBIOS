//
//  MoviesRouting.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

protocol PopularMoviesRouterInput : class {
    
    func navigationToPopularMovieDetail()
    func passDataToNextScene(_ segue: UIStoryboardSegue)
}



class PopularMoviesRouting: PopularMoviesRouterInput {
    
    var viewController : PopularMoviesViewController!
    
    func navigationToPopularMovieDetail() {
        viewController.performSegue(withIdentifier: identifies.ShowPopularMoviesDetail.rawValue, sender: nil)
        
    }
    
    func passDataToNextScene(_ segue: UIStoryboardSegue) {
        
        if segue.identifier == identifies.ShowPopularMoviesDetail.rawValue {
            passDataToShowPopularMovieDetailScene(segue)
        }
    }
    
    // navigate to another module
    func passDataToShowPopularMovieDetailScene(_ segue: UIStoryboardSegue) {
        
        if let selectedIndexPath = viewController.collectionView.indexPathsForSelectedItems?.first {
            let selectedPopularMovieModel = viewController.filterPopularMovies[selectedIndexPath.row]
            let showDetailVC = segue.destination as! DetailsPopularMoviesViewController
            
            showDetailVC.presenter.selectedDataPopularMovie(selectedPopularMovieModel)
        }
    }
}
