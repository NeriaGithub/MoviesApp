//
//  MovieCell.swift
//  MoviesApp
//
//  Created by Neria Jerafi on 10.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setMovieCell(movie:Movie)  {
        self.movieNameLabel.text = movie.name
    }
    
    
}
