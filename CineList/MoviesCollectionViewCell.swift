//
//  MoviesCollectionViewCell.swift
//  CineList
//
//  Created by preety on 6/1/21.
//


import UIKit
import Kingfisher

class MoviesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MoviesCollectionViewCell"
    
    var movie: Movies! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/" + movie.movieDB!.poster_path!)
        self.imageView.kf.setImage(with: url)
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
       // imageView.image = nil
    }
    
}

