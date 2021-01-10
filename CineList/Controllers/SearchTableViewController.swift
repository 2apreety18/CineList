//
//  SearchTableViewController.swift
//  CineList
//
//  Created by preety on 10/1/21.
//

import UIKit
import Kingfisher
import TMDBSwift

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
 
    private var rowsCount = 0
    
    private var data: [MovieMDB]!
    var movieData = [Movies]()
    var filteredMovieList: [Movies] = []
    
    private var tdata: [TVMDB]!
    var tvData = [TVShows]()
    var filteredTVList: [TVShows] = []
    
    private var searchData: [SearchMDB]!

    let searchController = UISearchController(searchResultsController: nil)


    override func viewDidLoad() {
        super.viewDidLoad()
        networkMovies()
       // networkTV()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            let count = filteredMovieList.count
            return count
          }
        return self.rowsCount
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell

          if isFiltering {
            cell.movie = filteredMovieList[indexPath.row]
           // cell.tvShow = self.filteredTVList[indexPath.row]
          } else {
            cell.movie = self.movieData[indexPath.row]
           // cell.tvShow = self.tvData[indexPath.row]

          }

          return cell
    }
    

    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    func filterContentForSearchText(_ searchText: String, category: Movies? = nil) {
      filteredMovieList = movieData.filter { (movie: Movies) -> Bool in
        
//        if movie.movieTitle.lowercased().contains(searchText.lowercased()) == false {
//
//            func filterContentForSearchText(_ searchText: String, category: TVShows? = nil) {
//              filteredTVList = tvData.filter { (tvShows: TVShows) -> Bool in
//                return tvShows.TVTitle.lowercased().contains(searchText.lowercased())
//              }
//            }
//        }
        return movie.movieTitle.lowercased().contains(searchText.lowercased())
      
      }
      tableView.reloadData()
    }

  //MARK: NETWORK PART

    func networkMovies() {
        TMDBConfig.apikey = "ccb281446ad667986a85ae167de70e9c"
        MovieMDB.discoverMovies(params: [.language("en"), .page(1)], completion: {api, movie in
            //self.data = api
            if let movie = movie{
                self.data = movie
                DispatchQueue.main.async {
                    for i in 0...self.data.count - 1{
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.rowsCount = self.data.count
//            self.setup()
            self.tableView.reloadData()
        }
    }
    
    func networkTV() {
       // count += 1
        TMDBConfig.apikey = "ccb281446ad667986a85ae167de70e9c"
        TVMDB.discoverTV(params: [.language("en"), .page(1)], completionHandler: {api, tvShow in
            //self.data = api
            if let tvShow = tvShow{
                self.tdata = tvShow
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.rowsCount = self.data.count
//            self.setup()
            self.tableView.reloadData()
        }
    }
    
   
    
    
  

}

extension SearchTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}
