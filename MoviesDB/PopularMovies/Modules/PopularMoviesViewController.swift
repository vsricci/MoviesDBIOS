//
//  MoviesViewController.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit
import RealmSwift
protocol PopularMoviesViewControllerOutput {
    
    func goToPhotoDetailScreen()
    func passDataToNextScene(_ segue: UIStoryboardSegue)
    func fetchMovies(_ url: String, apiKey: String, language: String, page: Int)
    func getFavoritedPopularMovies() -> Results<Movie>
    
    
}

protocol PopularMoviesViewControllerInput {
    
    func displayErrorView(_ errorMessage: String)
    func showWaitingView()
    func hideWatingView()
    func getTotalPopularMovies() -> NSInteger
    func displayPopularMovies(popularMovies : List<Movie>, totalPages: NSInteger)
    
}


class PopularMoviesViewController : UIViewController, PopularMoviesViewControllerInput {
    
    
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var collectionView : UICollectionView!
    var presenter : PopularMoviesViewControllerOutput!
    var popularMovies : [Movie] = []
    var filterPopularMovies : [Movie] = []
    var currentPage = 1
    var totalPages = 1
    let pageSize = 10 // that's up to you, really
    let preloadMargin = 5 // or whatever number that makes sense with your page size
    var lastLoadedPage = 0
    let imageNoResults : UIImageView = UIImageView()
    let descriprionNoResults : UILabel = UILabel()
    var favoriteMovies : Results<Movie>!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.collectionView.reloadData()
    }
    
    @IBAction func tapToHideKeyboard(_ sender: UITapGestureRecognizer) {
        self.searchBar.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tabBarController?.selectedIndex = 0
        self.favoriteMovies = self.presenter.getFavoritedPopularMovies().filter("vote_average > 0.0")
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        self.presenter.fetchMovies(URLS.popularMoviesURL.rawValue, apiKey: API_KEY, language: "pt-BR", page: self.currentPage)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PopularMoviesViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        searchBar.endEditing(true)
        imageNoResults.removeFromSuperview()
        descriprionNoResults.removeFromSuperview()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        PopularMoviesAssembly.shredInstance.configure(self)
    }
    
    
    func displayPopularMovies(popularMovies : List<Movie>, totalPages: NSInteger) {
       
        
        self.popularMovies.append(contentsOf: popularMovies)
        self.filterPopularMovies = self.popularMovies
        self.totalPages = totalPages
       
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
   
    func noResultsSearchMovies(isHidden: Bool) {
        
        
        if isHidden == true {
            self.collectionView.isHidden = false
            imageNoResults.isHidden = true
            descriprionNoResults.isHidden = true
        }
        else {
            
            imageNoResults.image = UIImage(named: "search_icon")
            imageNoResults.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            imageNoResults.contentMode = .scaleAspectFill
            
            descriprionNoResults.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
            
            imageNoResults.isHidden = false
            descriprionNoResults.isHidden = false
        }
        
        
            
        
    }
    
    func displayErrorView(_ errorMessage: String) {
        
        let refreshAlert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        refreshAlert.addAction(UIAlertAction(title: ok, style: .default, handler: { (action) in
            
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func showWaitingView(){
        
        let alert = UIAlertController(title: nil, message: waitingKey, preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = .gray
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func hideWatingView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func getTotalPopularMovies() -> NSInteger {
        
        return self.filterPopularMovies.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.presenter.passDataToNextScene(segue)
    }
   
    func reloadData() {
        // TODO: retrieve data from the database
        collectionView?.reloadSections(NSIndexSet(index: 0) as IndexSet)
    }
    
    
}

extension PopularMoviesViewController : UICollectionViewDelegate {
    
    
    func popularMoviesCell(_ collectionView: UICollectionView, cellForItemAt indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMoviesCell.defaultReuseIdentifier, for: indexPath as IndexPath) as! PopularMoviesCell
            
            let detailsMovie = self.filterPopularMovies[indexPath.row]
            
            cell.imagePopularMovies.sd_setImage(with: URL(string: "\(imageBegginURL)\(detailsMovie.poster_path)")) { (image, error, cache, url) in
                
                cell.imagePopularMovies.image = image
                
                UIView.animate(withDuration: 0.2, animations: {
                    
                    cell.imagePopularMovies.alpha = 1.0
                })
                cell.namePopularMovies.text = detailsMovie.title
                
                
                var title = String()
                for favoriteMovieItem in self.favoriteMovies {
                    
                    title = favoriteMovieItem.title
                    
                    if title == detailsMovie.title {
                        
                        print(title)
                        DispatchQueue.main.async {
                            
                            cell.favoritedImageMovies.image = UIImage(named: "favorite_full_icon")
                        }
                        
                    }
                    else {
                        cell.favoritedImageMovies.image = UIImage(named: "favorite_empty_icon")
                    }
                    
                }
            }
             return cell
        
        }
        
        func searchPopularMoviesCell(_ collectionView: UICollectionView, cellForItemAt indexPath: NSIndexPath) -> UICollectionViewCell{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPopularMoviesCell.defaultReuseIdentifier, for: indexPath as IndexPath) as! SearchPopularMoviesCell
            
             return cell
            
        }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let nextPage: Int = Int(indexPath.item / pageSize) + 1
        let preloadIndex = nextPage * pageSize - preloadMargin
        
        // trigger the preload when you reach a certain point AND prevent multiple loads and updates
        if (indexPath.item >= preloadIndex && lastLoadedPage < nextPage) {
            
            self.currentPage += 1
            self.lastLoadedPage = self.currentPage
            self.presenter.fetchMovies(URLS.popularMoviesURL.rawValue, apiKey: API_KEY, language: "pt-BR", page: self.currentPage)
            return searchPopularMoviesCell(collectionView, cellForItemAt: indexPath as NSIndexPath)
        }
        
            
            return popularMoviesCell(collectionView, cellForItemAt: indexPath as NSIndexPath)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.presenter.goToPhotoDetailScreen()
    }
    
    
}

extension PopularMoviesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if currentPage < totalPages {

            return filterPopularMovies.count + 1
        }
        return self.filterPopularMovies.count
    }
    

}

extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
    
        return CGSize(width: 150, height: 177)
        }
    

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            
            return 0.5
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            
            return 0.5
        }
    
    
}

extension PopularMoviesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text! == "" {
            self.filterPopularMovies = self.popularMovies
        } else {
            self.filterPopularMovies = self.popularMovies.filter( {
                $0.title.lowercased().contains(searchBar.text!.lowercased()) }
               
            )
             print(filterPopularMovies.count)
            if filterPopularMovies.count == 0 {
                
                noResultsSearchMovies(isHidden: false)
            }
            else {
                imageNoResults.removeFromSuperview()
                descriprionNoResults.removeFromSuperview()
                
            }
        }
        
        self.collectionView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("tsete")
        imageNoResults.removeFromSuperview()
        descriprionNoResults.removeFromSuperview()
    }
    

}


