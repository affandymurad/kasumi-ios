//
//  MovieDetail.swift
//  Kasumi
//
//  Created by docotel on 23/08/20.
//  Copyright © 2020 Affandy Murad. All rights reserved.
//

import Foundation

struct MovieDetail : Codable {
    var id : Int
    var vote_count : Int
    var video : Bool
    var vote_average : Float
    var title : String
    var popularity : Float
    var poster_path : String?
    var original_language : String
    var original_title : String
    var genre_ids : [Int]?
    var backdrop_path : String?
    var adult : Bool
    var overview : String
    var release_date : String
    var budget : Double
    var revenue : Double
    var homepage : String
    var imdb_id : String?
    var runtime : Int
    var status : String
    var tagline : String
    var spoken_languages: [Language]
    var genres: [Genre]
    var belongs_to_collection : Collections?
    var production_companies: [Company]
    var production_countries: [Country]
    var videos: Videos
    
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
            case budget = "budget"
            case revenue = "revenue"
            case homepage = "homepage"
            case imdb_id = "imdb_id"
            case runtime = "runtime"
            case status = "status"
            case tagline = "tagline"
            case spoken_languages = "spoken_languages"
            case genres = "genres"
            case belongs_to_collection = "belongs_to_collection"
            case production_companies = "production_companies"
            case production_countries = "production_countries"
            case videos = "videos"
    }
}

struct Language : Codable {
    var name : String?
    var iso_3166_1 : String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case iso_3166_1 = "iso_3166_1"
    }
}

struct Genre : Codable {
    var name : String
    var id : Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }
}

struct Collections : Codable {
    var name : String
    var id : Int
    var poster_path : String?
    var backdrop_path : String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case poster_path = "poster_path"
        case backdrop_path = "backdrop_path"
    }
}

struct Company : Codable {
    var name : String
    var id : Int
    var logo_path : String?
    var origin_country : String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case logo_path = "logo_path"
        case origin_country = "origin_country"
    }
}

struct Country : Codable {
    var name : String
    var iso_3166_1 : String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case iso_3166_1 = "iso_3166_1"
    }
}

struct Videos : Codable {
    var results : [VideoList]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}


struct VideoList : Codable {
    var name : String
    var id : String
    var iso_3166_1 : String
    var iso_639_1 : String
    var key : String
    var site : String
    var size : Int
    var type : String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case iso_3166_1 = "iso_3166_1"
        case iso_639_1 = "iso_639_1"
        case key = "key"
        case site = "site"
        case size = "size"
        case type = "type"
    }
}
