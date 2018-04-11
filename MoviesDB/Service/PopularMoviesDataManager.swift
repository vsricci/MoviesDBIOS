//
//  MoviesDataManager.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import Alamofire
import SDWebImage
protocol PopularMoviesProtocol: class {
    
    func moviesGridList(url: String, apiKey: String, language: String, page: Int, responseSuccess: @escaping (Result?, Int, Int) -> Void, responseError: @escaping (NSError?, Int?) -> Void )
    
    func loadImageFromUrl(_ url: NSURL, clousure: @escaping (UIImage?, NSError?) -> Void)
}


class PopularMoviesDataManager: PopularMoviesProtocol  {
    
    static let sharedInstance = PopularMoviesDataManager()
    let manager = Alamofire.SessionManager.default
    
    func moviesGridList(url: String, apiKey: String, language: String, page: Int, responseSuccess: @escaping (Result?, Int, Int) -> Void, responseError: @escaping (NSError?, Int?) -> Void ) {
        
        let urlRequest = "\(url)\(apiKey)&languege=\(language)&page=\(page)"
        print(urlRequest)
        
        manager.request(urlRequest, method: .get, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
                
                case .success:
                
                    
                    guard let responseJSON = response.result.value as? [String: Any] else {
                        
                        print("Erro")
                        return
                    }
                    
                    guard let page = responseJSON["page"] as? Int else {return}
                    print(page)
                    
                   
                    
                    
                    if let  result = try? JSONDecoder().decode(Result.self, from: response.data!) {
                        if let jsonString = String(data: response.data!, encoding: .utf8) {
                        print(jsonString)
                            
                            let encoder = JSONEncoder()
                            encoder.outputFormatting = .prettyPrinted
                            
                            responseSuccess(result, page, statusCode!)
                        }
                    }
                    
                
                
                
            case .failure(let error):
                
                responseError(error as NSError, statusCode)
            }
        }
        
    }
    
    func loadImageFromUrl(_ url: NSURL, clousure: @escaping (UIImage?, NSError?) -> Void) {
        
        
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: url as URL, options: .continueInBackground, progress: nil, completed: { (image, data, error, finished) in
            
            if ((image != nil) && finished) {
                clousure(image, error as? NSError)
                
            }
            
        })
    }
    
}
