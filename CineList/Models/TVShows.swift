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
//    var proCompany: String?
    var originCountry: String?
    var tvDB: TVMDB?
    var tvDetail: TVDetailedMDB?
    
    init(TVTitle: String, TVDate: String, TVSummary: String, genre: String) {
        self.TVTitle = TVTitle
        self.TVDate = TVDate
        self.TVSummary = TVSummary
        self.genre = genre
    }
    
    init(ref: (tvShows: TVMDB, detail: TVDetailedMDB)) {
        self.tvDB = ref.tvShows
        self.tvDetail = ref.detail
        self.TVTitle = ref.tvShows.name
        self.TVDate = ref.tvShows.first_air_date
        self.TVSummary = ref.tvShows.overview
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
//        //let largeNumber = ref.detail.revenue! - ref.detail.budget!
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal
//        let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber))
//        self.revenue = formattedNumber
//        if ref.detail.production_companies?[0].name == nil {
//            self.proCompany = "N/A"
//        } else {
//            self.proCompany = ref.detail.production_companies?[0].name
//        }
//        if ref.detail.origin_country?[0].name == nil {
//            self.proCountry = "N/A"
//        } else {
//            self.proCountry = ref.detail.origin_country?[0].name?.uppercased()
//        }
//        if ref.detail.runtime == nil {
//            self.duration = "N/A"
//        } else {
//            self.duration = String(ref.detail.runtime!)
//        }
    }
}
