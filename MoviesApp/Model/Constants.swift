//
//  Constants.swift
//  MoviesApp
//
//  Created by Neria Jerafi on 10.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import Foundation
struct Constants {
    static let movieVCSegue = "MovieVCSegue"
    static let allMoviesUrl = "http://x-mode.co.il/exam/allMovies/allMovies.txt"
    static  func getSpesificMovieUrl(id:String)->String  {
        return "http://x-mode.co.il/exam/descriptionMovies/\(id).txt"
    }
}
