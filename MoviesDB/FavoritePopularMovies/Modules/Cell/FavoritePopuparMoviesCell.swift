//
//  FavoritePopuparMoviesCell.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

class FavoritePopuparMoviesCell: UITableViewCell, FavoritePopularMoviesIdentifierProtocol{
    
    @IBOutlet weak var imageFavoritePopularMovie: UIImageView!
    @IBOutlet weak var nameFavoritePopularMovie: UILabel!
    @IBOutlet weak var yearFavoritePopularMovieImage: UILabel!
    @IBOutlet weak var descriptionFavoritePopularMovieImage: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
