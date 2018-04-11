//
//  FavoritePopularMovieReuseIdentifier.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

protocol FavoritePopularMoviesIdentifierProtocol {
    
    
    static var defaultReuseIdentifier : String { get }
}

 extension FavoritePopularMoviesIdentifierProtocol where Self: UIView {
    
    static var defaultReuseIdentifier: String {
        
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
