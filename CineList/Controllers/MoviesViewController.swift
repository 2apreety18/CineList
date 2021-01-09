//
//  MoviesViewController.swift
//  CineList
//
//  Created by preety on 6/1/21.
//

import UIKit
import Kingfisher
import TMDBSwift

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    private var rowsCount = 0
    private var data: [MovieMDB]!
    var movieData = [Movies]()
    
    
     
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        network()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("movies count \(self.rowsCount)")
        return self.rowsCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as! MoviesCollectionViewCell
        cell.movie = self.movieData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        vc.selectedMovie = self.movieData[indexPath.row]
        //present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)

        print("row\(indexPath.row)")
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.size.width/2)-2,
            height: (view.frame.size.height/3)-2
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
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
            self.collectionView.reloadData()
        }
    }
    
}



