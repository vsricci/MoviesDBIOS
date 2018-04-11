//
//  FiltersPopularFavoritesMoviesCell.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

class FiltersPopularFavoritesMoviesCell: UITableViewCell, FilterPopularFavoriteMovieIdentifierProtocol{
    
    @IBOutlet weak var typeFilterPopularFavoriteMovie: UILabel!
    @IBOutlet weak var resultFilterPopularFavoriteMovie: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

