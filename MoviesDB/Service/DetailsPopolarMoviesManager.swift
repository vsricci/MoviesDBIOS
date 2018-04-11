//
//  DetailsPopolarMoviesManager.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 20/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import Alamofire
protocol DetailsPopularMoviesProtocol : class{
    
    func getGenresPopolarMovies(url: String, api_key: String, language: String, responseSuccess: @escaping(Genres, Int) -> Void, failure: @escaping (Error, Int) -> Void)
}


class DetailsPopularMoviesManager {
    
    static let sharedInstance = DetailsPopularMoviesManager()
    let manager = Alamofire.SessionManager.default
    
    func getGenresPopolarMovies(url: String, api_key: String, language: String, responseSuccess: @escaping(Genres, Int) -> Void, failure: @escaping (Error, Int) -> Void){
        
        let fullUrl = "\(url)\(api_key)&languege=\(language)"
        
        manager.request(fullUrl, method: .get, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            
            let statusCode =  response.response?.statusCode
            
            switch response.result {
                
            case .success:
                
                let decode = try! JSONDecoder().decode(Genres.self, from: response.data!)
                responseSuccess(decode, statusCode!)
                return
                
                
            case .failure(let error):
                failure(error, statusCode!)
            }
        }
    }
    
}
