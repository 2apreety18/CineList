//
//  MovieDetailViewController.swift
//  CineList
//
//  Created by preety on 8/1/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var selectedMovie : Movies!
    
    @IBOutlet weak var movieName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        view.backgroundColor = .systemBackground
//        view.tintColor = .black
//
        movieName.font = movieName.font.withSize(movieName.frame.height * 2/3)
     

        showMovieDetails()
    }
    
    func showMovieDetails() {
        
        //title
        if self.selectedMovie.movieTitle != nil{
            self.movieName.text = "\(self.selectedMovie.movieTitle!.capitalized)"
        }
        
    }
   

}
