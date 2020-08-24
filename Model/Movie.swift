//
//  Movie.swift
//  Kasumi
//
//  Created by docotel on 23/08/20.
//  Copyright © 2020 Affandy Murad. All rights reserved.
//

import Foundation
import DeepDiff

struct Movie : Codable {
    var total_results : Int
    var total_pages : Int
    var page : Int
    var dates : Dates
    var results : [MovieList]?
    
    enum CodingKeys: String, CodingKey {
        case total_results = "total_results"
        case total_pages = "total_pages"
        case page = "page"
        case dates = "dates"
        case results = "results"
    }
}

struct Dates : Codable {
    var maximum : String
    var minimum : String
    
    enum CodingKeys: String, CodingKey {
        case maximum = "maximum"
        case minimum = "minimum"
    }
}


struct MovieList : Codable, Hashable, DiffAware {
    var id : Int
    var vote_count : Int
    var video : Bool
    var vote_average : Float
    var title : String
    var popularity : Float
    var poster_path : String?
    var original_language : String
    var original_title : String
    var genre_ids : [Int]
    var backdrop_path : String?
    var adult : Bool
    var overview : String
    var release_date : String
    
    enum CodingKeys: String, CodingKey {
            case id = "id"
            case vote_count = "vote_count"
            case video = "video"
            case vote_average = "vote_average"
            case title = "title"
            case popularity = "popularity"
            case poster_path = "poster_path"
            case original_language = "original_language"
            case original_title = "original_title"
            case genre_ids = "genre_ids"
            case backdrop_path = "backdrop_path"
            case adult = "adult"
            case overview = "overview"
            case release_date = "release_date"
    }
}
