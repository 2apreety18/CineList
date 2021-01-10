//
//  SearchTableViewCell.swift
//  CineList
//
//  Created by preety on 9/1/21.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var rating: UILabel!

    
    var movie: Movies! {
        didSet {
            self.updateUI()
        }
    }
    
    var tvShow: TVShows! {
        didSet {
            self.updateTVUI()
        }
    }
    
    func updateUI() {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/" + movie.movieDB!.poster_path!)
        self.poster.kf.setImage(with: url)
        
        //title
        if self.movie.movieTitle != nil{
            self.showTitle.text = "\(self.movie.movieTitle!.uppercased())"
        }
        
        //genre
        if self.movie.genre != nil{
            self.genreLabel.text = "\(self.movie.genre!)"
        }
        
        //rating
        if self.movie.voteScore != nil{
            self.rating.text = "\(self.movie.voteScore!)"
        }

    }
    
    func updateTVUI() {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/" + tvShow.tvDB!.poster_path!)
        self.poster.kf.setImage(with: url)
        
        //title
        if self.tvShow.TVTitle != nil{
            self.showTitle.text = "\(self.tvShow.TVTitle!.uppercased())"
        }
        
        //genre
        if self.tvShow.genre != nil{
            self.genreLabel.text = "\(self.tvShow.genre!)"
        }
        
        //rating
        if self.tvShow.voteScore != nil{
            self.rating.text = "\(self.tvShow.voteScore!)"
        }

    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
