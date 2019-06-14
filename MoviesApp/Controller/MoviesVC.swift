//
//  ViewController.swift
//  MoviesApp
//
//  Created by Neria Jerafi on 10.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {
    
    

    @IBOutlet weak var table: UITableView!
    var filteredMoviesTable:[Movie] = []
    var resultSearchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
       VCInit()
        getData()
    }
    func VCInit()  {
        self.table.rowHeight = UITableView.automaticDimension
        self.table.estimatedRowHeight = 120
        let nib = UINib(nibName: "MovieCell", bundle: nil);
        self.table.register(nib, forCellReuseIdentifier: "MovieCell");
        self.table.tableFooterView = UIView()
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.table.tableHeaderView = controller.searchBar
            
            return controller
        })()
    
    }
    func getData()  {
        DispatchQueue.global(qos: .background).async {
            ServerManager.getServerManager().getMoviesListJson { (data) in
                if  let moviesList = data{
                    DataManager.getDataManager().setMoviesArray(moviesList: moviesList)
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                }
                else{
                    print("No Data")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination as! MovieVC;
        guard let indexPath = self.table.indexPathForSelectedRow else { return }
        if self.resultSearchController.isActive{
            VC.movie = self.filteredMoviesTable[indexPath.row]
        }
        else{
            VC.movie = DataManager.getDataManager().getMoviesArray()[indexPath.row]
           
        }
        self.resultSearchController.isActive = false
    }

}
extension MoviesVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if  (resultSearchController.isActive) {
            return self.filteredMoviesTable.count
        }
        else {
            return DataManager.getDataManager().getMoviesArray().count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell;
         if  (resultSearchController.isActive) {
            cell.setMovieCell(movie: self.filteredMoviesTable[indexPath.row])
        }
         else{
            cell.setMovieCell(movie: DataManager.getDataManager().getMoviesArray()[indexPath.row])
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: Constants.movieVCSegue, sender: self)
    }
}
extension MoviesVC:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        self.filteredMoviesTable.removeAll(keepingCapacity: false)
        guard let text = searchController.searchBar.text else { return }
        for item  in DataManager.getDataManager().getMoviesArray() {
            if item.name.lowercased().contains(text.lowercased()){
                self.filteredMoviesTable.append(item)
            }
            
        }
        
        
        self.filteredMoviesTable = self.filteredMoviesTable.sorted(by: {$0.year > $1.year})
        self.table.reloadData()
    }
    
    
}

