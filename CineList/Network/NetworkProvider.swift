//
//  NetworkProvider.swift
//  CineList
//
//  Created by preety on 11/1/21.
//

import TMDBSwift
import SwiftyJSON



class NetworkProvider {
    
    
    var mData: [MovieMDB] = []
    var movieData : [Movies] = []
    
    var data : [TVMDB] = []
    var tvData : [TVShows] = []
    
    func fetchTVShows() {
        TMDBConfig.apikey = "ccb281446ad667986a85ae167de70e9c"
        TVMDB.discoverTV(params: [.language("en"), .page(1)], completionHandler: {api, tvShow in
            //self.data = api
            if let tvShow = tvShow{
                self.data = tvShow
                DispatchQueue.main.async {
                    for i in 0...self.data.count - 1 {
                        TVMDB.tv(tvShowID: tvShow[i].id, language: "en") { (api, tvDetail) in
                            let temp = TVShows(ref: (tvShows: tvShow[i], detail: tvDetail!))
                            DispatchQueue.main.async {
                                self.tvData.append(temp)
                            }
                        }
                    }
                }
            }
        })
    }
    
    func fetchMovies() {
        TMDBConfig.apikey = "ccb281446ad667986a85ae167de70e9c"
        MovieMDB.discoverMovies(params: [.language("en"), .page(1)], completion: {api, movie in
            //self.data = api
            if let movie = movie{
                self.mData = movie
                DispatchQueue.main.async {
                    for i in 0...self.mData.count - 1{
                        MovieMDB.movie(movieID: movie[i].id) { (api, movieDetail) in
                            let temp = Movies(ref: (movie: movie[i], detail: movieDetail!))
                            DispatchQueue.main.async {
                                self.movieData.append(temp)
                            }
                        }
                    }
                }
            }
        })
    
    }
    
    
    
   
}
