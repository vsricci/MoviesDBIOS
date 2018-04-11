//
//  CustomButton.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton : UIButton {

    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            
            self.layer.cornerRadius = cornerRadius
        }
    }

    func setupView() {
        
        self.layer.cornerRadius = cornerRadius
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setupView()
    }
}
