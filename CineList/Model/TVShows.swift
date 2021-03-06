//
//  TVShows.swift
//  CineList
//
//  Created by preety on 7/1/21.
//

import Foundation
import TMDBSwift

class TVShows {
    
    var TVTitle: String!
    var TVDate: String!
    var TVSummary: String!
    var genre: String!
    var voteCount: String!
    var voteScore: String!
    var revenue: String!
    var duration: String!
    var originCountry: String?
    var seasons: String?
    var episodes: String?
    var language: String?
    var tvDB: TVMDB?
    var tvDetail: TVDetailedMDB?
    
    init(TVTitle: String, TVDate: String, TVSummary: String, genre: String, duration: String) {
        self.TVTitle = TVTitle
        self.TVDate = TVDate
        self.TVSummary = TVSummary
        self.genre = genre
        self.duration = duration
    }
    
    init(ref: (tvShows: TVMDB, detail: TVDetailedMDB)) {
        self.tvDB = ref.tvShows
        self.tvDetail = ref.detail
        self.TVTitle = ref.tvShows.name
        self.TVDate = ref.tvShows.first_air_date
        self.TVSummary = ref.tvShows.overview
        self.language = ref.tvShows.original_language
        self.seasons = String(ref.detail.number_of_seasons!)
        self.episodes = String(ref.detail.number_of_episodes!)

        var genre = ""
        if ref.detail.genres.count == 0 {
            genre = "N/A"
        } else {
            for i in 0...ref.detail.genres.count - 1{
                genre = ref.detail.genres[i].name! + ", " + genre
            }
        }
        self.genre = genre
        self.voteCount = String(Int(ref.tvShows.vote_count!))
        self.voteScore = String(ref.tvShows.vote_average!)

        
    }
}
