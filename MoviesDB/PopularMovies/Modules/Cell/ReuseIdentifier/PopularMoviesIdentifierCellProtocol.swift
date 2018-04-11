//
//  PopularMoviesIdentifierCellProtocol.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 19/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit


protocol PopularMoviesIdentifierCellProtocol: class {
    
    static var defaultReuseIdentifier: String { get }
    
}

extension PopularMoviesIdentifierCellProtocol where Self: UIView {
    
    static var defaultReuseIdentifier: String {
        
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
