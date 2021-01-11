//
//  TVShowsDetailViewController.swift
//  CineList
//
//  Created by preety on 9/1/21.
//

import UIKit

class TVShowsDetailViewController: UIViewController {

    var selectedTVShow : TVShows!
    
    @IBOutlet weak var tvShowName: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var runTime: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var seasons: UILabel!
    @IBOutlet weak var episodes: UILabel!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var poster: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0.9995884299, green: 0.9897366166, blue: 0.5702303052, alpha: 1)
//        view.tintColor = .black
//
     

        showMovieDetails()
    }
    
    func showMovieDetails() {
        
        //poster
        let url = URL(string: "https://image.tmdb.org/t/p/w500/" + selectedTVShow.tvDB!.poster_path!)
        if url != nil{
            self.poster.kf.setImage(with: url)
        }
        
        //title
        if self.selectedTVShow.TVTitle != nil{
            self.tvShowName.text = "\(self.selectedTVShow.TVTitle!.uppercased())"
        }
        
        //genre
        if self.selectedTVShow.genre != nil{
            self.genreLabel.text = "\(self.selectedTVShow.genre!)"
        }
        
        //release date
        if self.selectedTVShow.TVDate != nil{
            self.date.text = "\(self.selectedTVShow.TVDate!)"
        }
        
        //runtime
        if self.selectedTVShow.duration != nil{
            self.runTime.text = "\(self.selectedTVShow.duration!)"
        }
        
        //language
        if self.selectedTVShow.language != nil{
            self.language.text = "\(self.selectedTVShow.language!.uppercased())"
        }
        
        //rating
        if self.selectedTVShow.voteScore != nil{
            self.ratingLabel.text = "\(self.selectedTVShow.voteScore!)"
        }
        
        //seasons
        if self.selectedTVShow.seasons != nil{
            self.seasons.text = "\(self.selectedTVShow.seasons!)"
        }
        
        //episodes
        if self.selectedTVShow.episodes != nil{
            self.episodes.text = "\(self.selectedTVShow.episodes!)"
        }
        
        //overview
        if self.selectedTVShow.TVSummary != nil{
            self.overview.text = "\(self.selectedTVShow.TVSummary!)"
        }
        
    }
}
