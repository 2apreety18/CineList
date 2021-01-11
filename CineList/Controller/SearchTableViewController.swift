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
   
    private let networkProvider = NetworkProvider()
    private var rowsCount = 0
    var index = 0
    
    var filteredMovieList: [Movies] = []
    var filteredTVList: [TVShows] = []
    
    let searchController = UISearchController(searchResultsController: nil)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        definesPresentationContext = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
       // networkMovies()
        searchController.searchBar.placeholder = "Search for Movies"
        networkProvider.fetchMovies()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.rowsCount = self.networkProvider.mData.count
            self.tableView.reloadData()
        }

    }
    
    @IBAction func didSelectSegment(_ sender: UISegmentedControl) {
        index = sender.selectedSegmentIndex
        
        if sender.selectedSegmentIndex == 0 {
           // networkMovies()
            networkProvider.fetchMovies()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.rowsCount = self.networkProvider.mData.count
                self.tableView.reloadData()
            }
            searchController.searchBar.placeholder = "Search for Movies"
            
            
        } else if sender.selectedSegmentIndex == 1 {
           // networkTV()
            networkProvider.fetchTVShows()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.rowsCount = self.networkProvider.data.count
                self.tableView.reloadData()
            }
            searchController.searchBar.placeholder = "Search for TV Shows"

        }
        
        
    }
    
    

    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if index == 0 {
            if isFiltering {
                let count = filteredMovieList.count
                return count
              }
            return self.rowsCount
            
        } else {
            if isFiltering {
                let count = filteredTVList.count
                return count
              }
            return self.rowsCount
            
        }
      
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        if index == 0 {
            if isFiltering {
              cell.movie = filteredMovieList[indexPath.row]
            } else {
                cell.movie = self.networkProvider.movieData[indexPath.row]
            }
        } else {
            if isFiltering {
             cell.tvShow = self.filteredTVList[indexPath.row]
            } else {
                cell.tvShow = self.networkProvider.tvData[indexPath.row]

            }
        }
        return cell
    }

    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    

    
//    func filterContentForSearchText(_ searchText: String, category: Movies? = nil) {
//      filteredMovieList = movieData.filter { (movie: Movies) -> Bool in
//        return movie.movieTitle.lowercased().contains(searchText.lowercased())
//
//      }
//        self.tableView.reloadData()
//    }
    
    
    func filterContentForSearchText(_ searchText: String, category: (Movies?, TVShows?)) {
        if index == 0 {
            filteredMovieList = networkProvider.movieData.filter { (movie: Movies) -> Bool in
              return movie.movieTitle.lowercased().contains(searchText.lowercased())

            }
        } else {
            filteredTVList = networkProvider.tvData.filter { (tvShows: TVShows) -> Bool in
              return tvShows.TVTitle.lowercased().contains(searchText.lowercased())
            }
        }
      
        self.tableView.reloadData()
    }


}

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
      let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!, category: (nil,nil))
    }
}
