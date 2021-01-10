//
//  SearchViewController.swift
//  CineList
//
//  Created by preety on 6/1/21.
//

import UIKit
import Kingfisher
import TMDBSwift

class SearchViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet var tableView: UITableView!
 
    private var rowsCount = 0
    private var data: [MovieMDB]!
    var movieData = [Movies]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        network()
    }

    // MARK: - Table view data source

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowsCount
    }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.movie = self.movieData[indexPath.row]
        return cell
    }

    

    func network() {
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

}
