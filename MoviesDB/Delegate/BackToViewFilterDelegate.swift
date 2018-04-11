//
//  backToViewFilterDelegate.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

protocol BackToViewFilterDelegate {
    
    func backToViewWithYear(filterPopularFavoriteYear: String?)
    
    func backToViewGenre(filterPopularFavoriteGenre: String?)
}
