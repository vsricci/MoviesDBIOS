//
//  DetilsPopularMoviesViewController.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 20/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import RealmSwift


protocol DetailsPopularMoviesViewControllerInput: class {
    func addLoadedPopularImage(_ image: UIImage)
    func addPopularMovieName(_ name: String)
    func addPopularMovieYear(_ year: String)
    func addGenresDetailsPopularMovies(_ genres: List<Genre>)
    func addPopularMovieGenre(_ genresarray: List<Int>)
    func addDescriptionPopularMovie(_ description: String)
    func addAlertPopularMovieFavorited()
    func displayErrorView(_ errorMessage: String)
    
}

protocol DetailsPopularMoviesViewControllerOutput: class {
    
    func selectedDataPopularMovie(_ popularMovie: Movie)
    func selectedGenres(_ genres : List<Genre>)
    func loadPopularMovieImage()
    func sendPopularMovieName()
    func sendPopularMovieYear()
    func sendPopularMovieDescription()
    func sendPopularMovieGenre()
    func favoritedPopularMovie()
    func alertPopularMovie()
    func sendGenresDetailsPopularMovies(url: String, api_key: String, language: String)
    func stateButtonFavorited(sender: UIButton)
    
}

class DetailsPopularMoviesViewController: UIViewController, DetailsPopularMoviesViewControllerInput {
    
    
    
    @IBOutlet weak var imageMovie : UIImageView!
    @IBOutlet weak var nameMovie : UILabel!
    @IBOutlet weak var yearMovie : UILabel!
    @IBOutlet weak var genreMovie: UILabel!
    @IBOutlet weak var descriptionMovie: UILabel!
   
    var presenter: DetailsPopularMoviesViewControllerOutput!
    var movieSelected : Movie!
    var genresArray: List<Int>!
    
    @IBAction func favoriteMovieTapped(_ sender : UIButton) {
        
        
        
        self.presenter.favoritedPopularMovie()
        self.presenter.stateButtonFavorited(sender: sender)
        self.presenter.alertPopularMovie()
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        DetailsPopularMoviesAssembly.sharedInstance.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.loadPopularMovieImage()
        self.presenter.sendPopularMovieName()
        self.presenter.sendPopularMovieYear()
        self.presenter.sendPopularMovieDescription()
        self.presenter.sendPopularMovieGenre()
        DispatchQueue.main.async {
            
            self.presenter.sendGenresDetailsPopularMovies(url: URLS.genresListURL.rawValue, api_key: API_KEY, language: "pt-BR")
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
                self.presenter.sendPopularMovieGenre()
            })
        }
        

        
    }
    
    
    
    func addLoadedPopularImage(_ image: UIImage) {
        
        self.imageMovie.image = image
    }
    
    func addPopularMovieName(_ name: String) {
        self.nameMovie.text = name
    }
    
    func addPopularMovieYear(_ year: String) {
        self.yearMovie.text = year
    }
    
    func addPopularMovieGenre(_ genresarray: List<Int>) {

        self.genresArray = genresarray
       
    }
    
    func addGenresDetailsPopularMovies(_ genres: List<Genre>){
        
        print(genres.count)
        
        
        let  listGenres = List<Genre>()
        self.genreMovie.text = "Genêros:"
        
        for genresId in genres {
            
            for ids in self.genresArray {
                
                let genre = Genre()
                if genresId.id == ids {
                
                    genre.id = ids
                    genre.name = genresId.name
                    listGenres.append(genre)
                    var descriptionsRenges = (self.genreMovie.text ?? "")+", "+String(describing: genresId.name)
                    self.genreMovie.text = "\(descriptionsRenges)"
                }
                
                self.presenter.selectedGenres(listGenres)
            }
        }
    }
    
    
    
    func addDescriptionPopularMovie(_ description: String) {
        self.descriptionMovie.text = description
        
    }
    
    func addAlertPopularMovieFavorited() {
        
        let alert = UIAlertController(title: successo, message: favoritado, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ok, style: .default, handler: { (alertAction) in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func displayErrorView(_ errorMessage: String) {
        
        let refreshAlert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        refreshAlert.addAction(UIAlertAction(title: ok, style: .default, handler: { (action) in
            
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    

   
    

}
