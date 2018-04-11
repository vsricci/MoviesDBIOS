//
//  Movie.swift
//  TheMoviesIOS
//
//  Created by Vinicius Ricci on 19/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift


class Result: Object, Decodable {
    
    var results = List<Movie>()
    
    
    
    convenience init(results: List<Movie>) {
        self.init()
        self.results = results
    }
    
    
    enum CodingKeys : String, CodingKey {
        
        case results
       
        
    }
    
    
    convenience required init(from decoder: Decoder) throws {
        
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let resultsArray = try container.decode([Movie].self, forKey: .results)
        let movies = List<Movie>()
        movies.append(objectsIn: resultsArray)
        self.init(results: movies)
        
    }
    
}

class Movie : Object, Decodable{
    
    @objc dynamic var title: String = ""
    @objc dynamic var vote_average: Double = 0.0
    @objc dynamic var poster_path : String = ""
    @objc dynamic var original_title: String = ""
    var genre_ids = List<Int>()
    @objc dynamic var backdrop_path : String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var release_date : String = ""
    var descriptionGenre = List<Genre>()
    
    convenience init(title: String, vote_average: Double, poster_path: String, original_title: String, genres: List<Int>, backdrop_path: String, overview: String, release_date: String) {
        self.init()
        self.title = title
        self.vote_average = vote_average
        self.poster_path = poster_path
        self.original_title = original_title
        self.genre_ids = genres
        self.backdrop_path = backdrop_path
        self.overview = overview
        self.release_date = release_date
       
        
    }
    
    enum CodingKeys : String, CodingKey {
        
        case title
        case vote_average
        case poster_path
        case original_title
        case genre_ids
        case backdrop_path
        case overview
        case release_date
        case descriptionGenre
        
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let vote_average = try container.decode(Double.self, forKey: .vote_average)
        let poster_path = try container.decode(String.self, forKey: .poster_path)
        let original_title = try container.decode(String.self, forKey: .original_title)
        let gentesArray = try container.decode([Int].self, forKey: .genre_ids)
        let backdrop_path = try container.decode(String.self, forKey: .backdrop_path)
        let overview = try container.decode(String.self, forKey: .overview)
        let release_date = try container.decode(String.self, forKey: .release_date)
        
        
        let genre_ids = List<Int>()
        genre_ids.append(objectsIn: gentesArray)
        self.init(title: title, vote_average: vote_average, poster_path: poster_path, original_title: original_title, genres: genre_ids, backdrop_path: backdrop_path, overview: overview, release_date: release_date)
        
    }
    
    
    
    
}

class Genres: Object, Decodable {
    
    var genres = List<Genre>()
    
    convenience init(genres: List<Genre>) {
        self.init()
        self.genres = genres
    }
    
    enum CodingKeys : String, CodingKey {
        
        case genres
        
    }
    
    convenience required init(from decoder: Decoder) throws {
        
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let genresArray = try! container.decode([Genre].self, forKey: .genres)
        let genre = List<Genre>()
        genre.append(objectsIn: genresArray)
        self.init(genres: genre)
        
    }
    
}


class Genre : Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name : String = ""
    
    
    
    
    convenience init(id: Int, name: String) {
        self.init()
        self.id = id
        self.name = name
        
        
        
    }
    
    enum CodingKeys : String, CodingKey {
        
        case id
        case name
        
        
    }
    
    convenience required init(from decoder: Decoder) throws {
        
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let id = try! container.decode(Int.self, forKey: .id)
        let name = try! container.decode(String.self, forKey: .name)
        self.init(id: id, name: name)
        
    }
    
    
}

