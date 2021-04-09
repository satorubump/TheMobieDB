//
//  Now_PlayingResponse.swift
//  TheMovieDB
//
//  Created by Satoru Ishii on 4/6/21.
//

import Foundation

struct NowPlayingResponse : Codable {
    let page : Int
    let total_pages : Int
    let total_results : Int
    let dates : Dates
    let results : [Results]
    
    enum CodingKeys : String, CodingKey {
        case page
        case total_pages
        case total_results
        case dates
        case results
    }
    
    struct Dates : Codable {
        let maximum : String
        let minimum : String
        enum CodingKeys : String, CodingKey {
            case maximum
            case minimum
        }
    }
    struct Results : Codable {
        let poster_path : String?
        let adult : Bool
        let overview : String
        let release_date : String
        let genre_ids : [Int]
        let id : Int
        let original_title : String
        let original_language : String
        let title : String
        let backdrop_path : String?
        let popularity : Double
        let vote_count : Int
        let video : Bool
        let vote_average : Double
        enum CodingKeys : String, CodingKey {
            case poster_path
            case adult
            case overview
            case release_date
            case genre_ids
            case id
            case original_title
            case original_language
            case title
            case backdrop_path
            case popularity
            case vote_count
            case video
            case vote_average
        }
    }
    
}
