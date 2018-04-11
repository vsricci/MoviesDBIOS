//
//  FilterPopularFavoriteMoviesViewController.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import RealmSwift
import SnapKit
protocol FilterPopularFavoriteMoviesViewControllerInput: class {
    
}

protocol FilterPopularFavoriteMoviesViewControllerOutput: class {
    
}

class FilterPopularFavoriteMoviesViewController: UIViewController, BackToViewFilterDelegate {
    
    

    
    var listFilters : [String] = ["Dates", "Genres"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applayButton: UIButton!
    var customDelegate : BackToViewFilterDelegate? = nil
    
    var selectedDate : String!
    var selectedGenre : String!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        FilterPopularFavoritesMoviesAssembly.sharedInstance.configure(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if selectedGenre != nil && selectedDate != nil {
            
            applayButton.isUserInteractionEnabled = true
            applayButton.backgroundColor = #colorLiteral(red: 1, green: 0.831372549, blue: 0.4745098039, alpha: 1)
        }
        else {
            applayButton.isUserInteractionEnabled = false
            applayButton.backgroundColor = UIColor.lightGray
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func applayButtonTapped(_ sender: UIButton) {
        
        customDelegate?.backToViewGenre(filterPopularFavoriteGenre: selectedGenre)
        customDelegate?.backToViewWithYear(filterPopularFavoriteYear: selectedDate)
        self.navigationController?.popViewController(animated: true)
    }
    
    func backToViewWithYear(filterPopularFavoriteYear: String?) {
        
        selectedDate = filterPopularFavoriteYear
        print(selectedDate)
        self.tableView.reloadData()
       
    }
    
    func backToViewGenre(filterPopularFavoriteGenre: String?) {
        selectedGenre = filterPopularFavoriteGenre
        print(selectedGenre)
        self.tableView.reloadData()
       
    }
    
//    func showDisplayError() {
//
//        var alert = UIAlertController(title: defaultErrorMessage, message: "Preencha os filtros", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: okKey, style: .default, handler: { (alertAction) in
//
//            alert.dismiss(animated: true, completion: nil)
//        }))
//        self.present(alert, animated: true, completion: nil)
//    }

}


extension FilterPopularFavoriteMoviesViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listFilters.count

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
}

extension FilterPopularFavoriteMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FiltersPopularFavoritesMoviesCell.defaultReuseIdentifier, for: indexPath) as! FiltersPopularFavoritesMoviesCell
        
         let filters = listFilters[indexPath.row]
        
        cell.typeFilterPopularFavoriteMovie.text = filters
        
        if indexPath.row == 0 && selectedDate != nil {
            
            
            cell.resultFilterPopularFavoriteMovie.isHidden = false
            cell.resultFilterPopularFavoriteMovie.text = "\(selectedDate!)"
        }
        
        else if indexPath.row == 1 && selectedGenre != nil {
            cell.resultFilterPopularFavoriteMovie.isHidden = false
            cell.resultFilterPopularFavoriteMovie.text = "\(selectedGenre!)"
        }
        else {
            
             cell.resultFilterPopularFavoriteMovie.isHidden = true
        }
        
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = listFilters[indexPath.row]
    
        if indexPath.row == 0 {
            
            print(item)
            let typeFilterFavoritePopularMovies = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifies.ShowTypeFilterPopularFaoriteMovies.rawValue) as! TypeFilterPopularFavoriteMoviesViewController
            typeFilterFavoritePopularMovies.type = item
            typeFilterFavoritePopularMovies.backToItemSelected = self
            self.navigationController?.pushViewController(typeFilterFavoritePopularMovies, animated: true)
        }
        else {
            print(item)
            let typeFilterFavoritePopularMovies = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifies.ShowTypeFilterPopularFaoriteMovies.rawValue) as! TypeFilterPopularFavoriteMoviesViewController
            typeFilterFavoritePopularMovies.type = item
            typeFilterFavoritePopularMovies.backToItemSelected = self
            self.navigationController?.pushViewController(typeFilterFavoritePopularMovies, animated: true)
        }
        
        
    }
    
    
    
    
}
