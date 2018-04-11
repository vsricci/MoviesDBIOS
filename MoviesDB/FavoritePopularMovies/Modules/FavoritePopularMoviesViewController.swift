//
//  FavoriteMoviesViewController.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 21/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import RealmSwift
import RealmTypeSafeQuery

protocol FavoritePopularMoviesViewControllerInput : class {
    

}

protocol FavoritePopularMoviesViewControllerOutput : class {
    
    func fetchFavoritePopularMovies() -> Results<Movie>
    func goToFilterFavoritePopularMoviesScreen()
    func passDataToNextScene(_ segue: UIStoryboardSegue)
}

class FavoritePopularMoviesViewController: UIViewController, FavoritePopularMoviesViewControllerInput, BackToViewFilterDelegate  {
    
    var presenter : FavoritePopularMoviesPresenterInput!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterBarButton: UIBarButtonItem!
    var filterFavoriteMovies : Results<Movie>!
    var favoriteMovies : Results<Movie>!
    var filterSelectedGenre : String!
    var filterSelectedDate : String!
    let imageNoResults : UIImageView = UIImageView()
    let descriprionNoResults : UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        FavoritePopularMoviesAssembly.sharedInstance.configure(self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController.unsafelyUnwrapped
        self.tabBarController?.awakeFromNib()
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        filterBarButton.target = self
        filterBarButton.action = #selector(goToFilterPopularFavoriteMovies)
        tableView.rowHeight =  UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150.0
        favoriteMovies = self.presenter.fetchFavoritePopularMovies().filter("vote_average > 0.0")
        filterFavoriteMovies = favoriteMovies
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FavoritePopularMoviesViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        searchBar.endEditing(true)
        imageNoResults.removeFromSuperview()
        descriprionNoResults.removeFromSuperview()
        self.tableView.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.presenter.passDataToNextScene(segue)
        
    }
    
    @objc func goToFilterPopularFavoriteMovies() {
        
        let ir = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifies.ShowFilterPopularFaoriteMovies.rawValue) as! FilterPopularFavoriteMoviesViewController
        ir.customDelegate = self
        self.navigationController?.pushViewController(ir, animated: true)
       // self.presenter.goToFilterFavoritePopularMoviesScreen()
        
    }
    
    func backToViewWithYear(filterPopularFavoriteYear: String?) {
        
        if filterPopularFavoriteYear != nil {
            
            self.filterSelectedDate = filterPopularFavoriteYear
            self.filterFavoriteMovies = self.presenter.fetchFavoritePopularMovies().filter("release_date CONTAINS [cd]  %@ && vote_average > 0.0", filterSelectedDate).sorted(byKeyPath: "release_date", ascending: false)
            self.tableView.reloadData()
        }
       
    }
    
    
    
    func backToViewGenre(filterPopularFavoriteGenre: String?) {
       
        
//       if filterPopularFavoriteGenre != nil {
//
//            self.filterSelectedGenre = filterPopularFavoriteGenre
//            self.filterFavoriteMovies = self.presenter.fetchFavoritePopularMovies().filter("Movie.descriptionGenre[0].name CONTAINS [cd] %@", filterPopularFavoriteGenre!)
//            self.tableView.reloadData()
//        }
        
    }
    
    func noResultsSearchMovies(isHidden: Bool) {
        
        
        if isHidden == true {
            self.tableView.isHidden = false
            imageNoResults.isHidden = true
            descriprionNoResults.isHidden = true
        }
        else {
            
            imageNoResults.image = UIImage(named: "search_icon")
            imageNoResults.contentMode = .scaleAspectFill
            imageNoResults.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            descriprionNoResults.text = "Sua busca por \(self.searchBar.text!) não resultou em nenhum resultado"
            descriprionNoResults.numberOfLines = 0
            descriprionNoResults.font = UIFont.systemFont(ofSize: 17)
            descriprionNoResults.textAlignment = .center
            self.view.addSubview(imageNoResults)
            self.view.addSubview(descriprionNoResults)
            
            imageNoResults.isHidden = isHidden
            descriprionNoResults.isHidden = isHidden
            imageNoResults.snp.makeConstraints({ (make) in
                
                make.center.equalTo(self.view.snp.center)
                make.width.equalTo(200)
                make.height.equalTo(200)
            })
            
            descriprionNoResults.snp.makeConstraints({ (make) in
                make.top.equalTo(imageNoResults.snp.bottom).offset(16)
                make.leading.equalTo(16)
                make.trailing.equalTo(-16)
                make.height.equalTo(45)
            })
            
//            imageNoResults.isHidden = false
//            descriprionNoResults.isHidden = false
        }
      
    }

}

extension FavoritePopularMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritePopuparMoviesCell.defaultReuseIdentifier, for: indexPath) as! FavoritePopuparMoviesCell
        
        let favoritePopulaMovies = filterFavoriteMovies[indexPath.row]

        cell.nameFavoritePopularMovie?.text = favoritePopulaMovies.title
        cell.yearFavoritePopularMovieImage.text = favoritePopulaMovies.release_date
        cell.descriptionFavoritePopularMovieImage.text = favoritePopulaMovies.overview
        cell.imageFavoritePopularMovie.sd_setImage(with: URL(string: "\(imageBegginURL)\(favoritePopulaMovies.poster_path)"), placeholderImage: UIImage(named: ""), options: .cacheMemoryOnly, completed: nil)


        
        return cell
     
    }
   
}

extension FavoritePopularMoviesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filterFavoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let realm = try? Realm()
        
        if editingStyle == .delete {
            
            let item = filterFavoriteMovies[indexPath.row]
            
            realm?.refresh()
            realm?.beginWrite()
           // realm?.delete(item.descriptionGenre)
           // realm?.delete(item)
            
            item.vote_average = 0.0
            realm?.add(item)
            realm?.refresh()
            try! realm?.commitWrite()
        
            
                tableView.endUpdates()
                tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120.0
    }
}

extension FavoritePopularMoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {


            filterFavoriteMovies = favoriteMovies.filter("title CONTAINS [cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)

        print("Goku")
        //}


    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text! == "" {
            self.filterFavoriteMovies = self.favoriteMovies
           
        } else {
            // Filter the results
            self.tableView.isHidden = false
            
            self.filterFavoriteMovies = self.favoriteMovies.filter("title CONTAINS [cd ]%@", searchBar.text!).sorted(byKeyPath: "title", ascending: false)
            
            if filterFavoriteMovies.count == 0 {
                self.tableView.isHidden = true
                noResultsSearchMovies(isHidden: false)
            }
            else {
                imageNoResults.removeFromSuperview()
                descriprionNoResults.removeFromSuperview()
                
            }
        }
        
        self.tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("tsete")
        imageNoResults.removeFromSuperview()
        descriprionNoResults.removeFromSuperview()
    }
}


    
    

