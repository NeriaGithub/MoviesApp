//
//  MovieVC.swift
//  MoviesApp
//
//  Created by Neria Jerafi on 10.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import UIKit

class MovieVC: UIViewController {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
   var movie:Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
      initVC()
        // Do any additional setup after loading the view.
    }
    
    
    
    func initVC()  {
        self.title = self.movie!.name
        if self.movie!.imageUrl != nil{
            getImage(url: self.movie!.imageUrl!)
            self.movieDescriptionLabel.text = self.movie!.description!
        }
        else{
           DispatchQueue.global(qos: .background).async {
            ServerManager.getServerManager().getMovieJson(url: Constants.getSpesificMovieUrl(id: self.movie!.id)) { (data) in
                if let movieData = data{
                    DispatchQueue.main.async {
                        self.movieDescriptionLabel.text = movieData.description!
                    }
                    
                    DataManager.getDataManager().addMovieData(movie: movieData)
                    self.getImage(url: movieData.imageUrl!)
                }
            }
        }
        }
    }
    
    func getImage(url:String) {
        DispatchQueue.global(qos: .background).async {
            if let imageUrl = URL(string: url){
                do{
                    let imageData = try Data(contentsOf: imageUrl);
                    DispatchQueue.main.async {
                        self.movieImageView.image = UIImage(data: imageData, scale: 1.0);
                        if self.movieImageView.image == nil{
                            
                            self.movieImageView?.image = UIImage(named: "noIcon")
                        }
                    }
                }
                catch{}
            }
        }
    }

    

}
