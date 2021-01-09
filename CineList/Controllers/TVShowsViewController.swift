//
//  TVShowsViewController.swift
//  CineList
//
//  Created by preety on 6/1/21.
//

import UIKit
import Kingfisher
import TMDBSwift

class TVShowsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
   // private var count = 0
    private var rowsCount = 0
    private var data: [TVMDB]!
    var tvData = [TVShows]()
    
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(TVShowsCollectionViewCell.self, forCellWithReuseIdentifier: TVShowsCollectionViewCell.identifier)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowsCollectionViewCell.identifier, for: indexPath) as! TVShowsCollectionViewCell
        cell.tvShow = self.tvData[indexPath.row]
        return cell
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TVShowsDetailViewController") as! TVShowsDetailViewController
        vc.selectedTVShow = self.tvData[indexPath.row]
        //present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        print("row\(indexPath.row)")
        
    }
    
    
    func network() {
       // count += 1
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.rowsCount = self.data.count
//            self.setup()
            self.collectionView.reloadData()
        }
    }
    
}

