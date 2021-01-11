//
//  MovieDetailViewController.swift
//  CineList
//
//  Created by preety on 8/1/21.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    var selectedMovie : Movies!
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var runTime: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var revenue: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
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
        let url = URL(string: "https://image.tmdb.org/t/p/w500/" + selectedMovie.movieDB!.poster_path!)
        if url != nil{
            self.poster.kf.setImage(with: url)
        }
        
        //title
        if self.selectedMovie.movieTitle != nil{
            self.movieName.text = "\(self.selectedMovie.movieTitle!.uppercased())"
        }
        
        //genre
        if self.selectedMovie.genre != nil{
            self.genreLabel.text = "\(self.selectedMovie.genre!)"
        }
        
        //release date
        if self.selectedMovie.movieDate != nil{
            self.date.text = "\(self.selectedMovie.movieDate!)"
        }
        
        //runtime
        if self.selectedMovie.duration != nil{
            self.runTime.text = "\(self.selectedMovie.duration!)"
        }
        
        //language
        if self.selectedMovie.language != nil{
            self.language.text = "\(self.selectedMovie.language!.uppercased())"
        }
        
        //rating
        if self.selectedMovie.voteScore != nil{
            self.ratingLabel.text = "\(self.selectedMovie.voteScore!)"
        }
        
        //revenue
        if self.selectedMovie.revenue != nil{
            self.revenue.text = "\(self.selectedMovie.revenue!)"
        }
        
        //country
        if self.selectedMovie.proCountry != nil{
            self.country.text = "\(self.selectedMovie.proCountry!)"
        }
        
        //overview
        if self.selectedMovie.movieSummary != nil{
            self.movieOverview.text = "\(self.selectedMovie.movieSummary!)"
        }
        
    }
   

}
