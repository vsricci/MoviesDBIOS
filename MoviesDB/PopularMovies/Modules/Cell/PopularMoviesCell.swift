//
//  PopularMoviesCell.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 19/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

class PopularMoviesCell: UICollectionViewCell, PopularMoviesIdentifierCellProtocol {
    
    @IBOutlet weak var imagePopularMovies : UIImageView!
    @IBOutlet weak var namePopularMovies: UILabel!
    @IBOutlet weak var favoritedImageMovies: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       // self.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    }
    
}
