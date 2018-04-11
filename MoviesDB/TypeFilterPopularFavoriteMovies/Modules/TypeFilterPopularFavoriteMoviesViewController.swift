//
//  TypeFilterPopularFavoriteMoviesViewController.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import RealmSwift
protocol TypeFilterPopularFavoriteMoviesViewControllerInput: class {
 
    func showGetGenres(popularMovies : List<Genre>)
    func displayErrorView(_ errorMessage: String)
}


protocol TypeFilterPopularFavoriteMoviesViewControllerOutput {
    
    func providedGenres(genres: List<Genre>)
    func getGenres(url: String, api_key: String, language: String)
}

class TypeFilterPopularFavoriteMoviesViewController: UIViewController, TypeFilterPopularFavoriteMoviesViewControllerInput {

    @IBOutlet weak var tableView: UITableView!
    
    var backToItemSelected : BackToViewFilterDelegate? = nil
    var type : String!
    var listGenres = List<Genre>()
    var listDates : [String] = ["1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018"]
    var presenter : TypeFilterPopularFavoriteMoviesPresenterInput!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        TypeFilterPopularFavoriteMoviesAssembly.sharedInstance.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if TypeFilter.genre.rawValue == type {
            self.navigationItem.title = type
            self.presenter.getGenres(url: URLS.genresListURL.rawValue, api_key: API_KEY, language: "pt-BR")
        }
        else {
            self.navigationItem.title = type
        }
        
       
    }
    
    
    func showGetGenres(popularMovies : List<Genre>) {
        
        
        self.listGenres.append(objectsIn: popularMovies)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func displayErrorView(_ errorMessage: String) {
        
        let refreshAlert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        refreshAlert.addAction(UIAlertAction(title: ok, style: .default, handler: { (action) in
            
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }

}


extension TypeFilterPopularFavoriteMoviesViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}

extension TypeFilterPopularFavoriteMoviesViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if TypeFilter.date.rawValue == type {
            
            return listDates.count
        }
        else {
            return listGenres.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: TypeFilterFavoritePopularMovieCell.defaultReuseIdentifier, for: indexPath) as! TypeFilterFavoritePopularMovieCell
        
        if TypeFilter.date.rawValue == type {
            
            cell.name.text = listDates[indexPath.row]
        }
        else {
            
            let itensGenre = listGenres[indexPath.row]
            
            cell.name.text = itensGenre.name
        }
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if TypeFilter.date.rawValue == type {
            
            let item = listDates[indexPath.row]
            backToItemSelected?.backToViewWithYear(filterPopularFavoriteYear: item)
            self.navigationController?.popViewController(animated: true)
        }
        else {
            let item = listGenres[indexPath.row]
            backToItemSelected?.backToViewGenre(filterPopularFavoriteGenre: item.name)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}
