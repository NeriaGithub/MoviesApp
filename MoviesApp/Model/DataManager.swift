//
//  DataManager.swift
//  MoviesApp
//
//  Created by Neria Jerafi on 10.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import Foundation
class DataManager {
    private static var sharedInstance:DataManager?;
    private init(){}
    public  static func getDataManager()->DataManager
    {
        if DataManager.sharedInstance == nil{
            DataManager.sharedInstance = DataManager();
        }
        return DataManager.sharedInstance!
    }
    
    private var movies:[Movie] = []
    func setMoviesArray(moviesList:MoviesList)  {
        self.movies = moviesList.movies.sorted(by: {$0.year > $1.year})
    }
    func getMoviesArray() -> [Movie] {
        return self.movies
    }
    func addMovieData(movie:Movie)  {
        
        for (i,item) in self.movies.enumerated() {
            if item.id == movie.id {
                self.movies[i] = movie
            }
        }
    }
}
