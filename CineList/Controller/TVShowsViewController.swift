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
    
    private var rowsCount = 0
    private let networkProvider = NetworkProvider()

//    private var data: [TVMDB]!
//    var tvData = [TVShows]()
    
    
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
        collectionView.backgroundView = nil;
        collectionView.backgroundColor = #colorLiteral(red: 0.9995884299, green: 0.9897366166, blue: 0.5702303052, alpha: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        
        networkProvider.fetchTVShows()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.rowsCount = self.networkProvider.data.count
            self.collectionView.reloadData()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("movies count \(self.rowsCount)")
        return self.rowsCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowsCollectionViewCell.identifier, for: indexPath) as! TVShowsCollectionViewCell
        cell.tvShow = self.networkProvider.tvData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (UIDevice.current.userInterfaceIdiom == .pad){
            // Ipad: 3 cells per row
            return CGSize(
                width: (view.frame.size.width/3)-3,
                height: (view.frame.size.height/3)-3
            )
          } else {
           // Iphone: 2 cells per row
            return CGSize(
                width: (view.frame.size.width/2)-2,
                height: (view.frame.size.height/3)-2
            )
          }
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
        vc.selectedTVShow = self.networkProvider.tvData[indexPath.row]
        //present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        print("row\(indexPath.row)")
        
    }
    
    
}

