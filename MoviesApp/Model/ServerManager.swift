//
//  ServerManager.swift
//  MoviesApp
//
//  Created by Neria Jerafi on 10.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import Foundation
class  ServerManager {
    private static var sharedInstance:ServerManager?;
    private init(){}
    public  static func getServerManager()->ServerManager
    {
        if ServerManager.sharedInstance == nil{
            ServerManager.sharedInstance = ServerManager();
        }
        return ServerManager.sharedInstance!
    }
    func getMoviesListJson(completion:@escaping(MoviesList?)->())  {
        guard let url = URL(string: Constants.allMoviesUrl) else {return}
        URLSession.shared.dataTask(with: url){(data,respose,error) in
            if error != nil {
                // handle the transport error
                completion(nil)
                return
            }
            do{
                let moviesList = try JSONDecoder().decode(MoviesList.self, from: data!);
                completion(moviesList)
            }
            catch{
                print("error")
                completion(nil)
            }
            }.resume()
    }
    
    func getMovieJson(url:String,completion: @escaping (Movie?) -> ())  {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url){(data,respose,error) in
            if error != nil {
                // handle the transport error
                completion(nil)
                return
            }
            do{
                let movie = try JSONDecoder().decode(Movie.self, from: data!);
                completion(movie)
            }
            catch{
                print("error")
                completion(nil)
            }
            }.resume()
    }
}
