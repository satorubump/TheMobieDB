//
//  ConstantsTable.swift
//  TheMovieDB
//
//  Created by Satoru Ishii on 4/6/21.
//

import Foundation

struct ConstantsTable {
    static let Scheme = "https"
    static let Host = "api.themoviedb.org"
    static let Path = "/3/movie"
    static let Now_PlayingReq = "/now_playing"
    static let APIKeyLabel = "api_key"
    static let APIKey = "1e1c266b3ca81dad5aea7386cd74c596"
    
    static let ImageHost = "image.tmdb.org"
    static let ImagePath = "/t/p/w200/"
    
    static let ReleaseDate = 1
    static let Rating = 2
    static let Title = 3
    
    static let GenreIDsMap = [12 : "Adventure",
                             14 : "Fantasy",
                             16 : "Animation",
                             18 : "Drama",
                             27 : "Horror",
                             28 : "Action",
                             35 : "Comedy",
                             36 : "History",
                             37 : "Western",
                             53 : "Thriller",
                             80 : "Crime",
                             90 : "Documentary",
                             878 : "Science Fiction",
                             9648 : "Mistery",
                             10402 : "Music",
                             10749 : "Romance",
                             10751 : "Family",
                             10752 : "War",
                             10770 : "TV Movie"
                            ]
}
