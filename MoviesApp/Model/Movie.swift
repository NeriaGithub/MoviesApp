//
//  Movie.swift
//  MoviesApp
//
//  Created by Neria Jerafi on 10.6.2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import Foundation
struct Movie: Decodable  {
    let id: String
    let name: String
    let year: String
    var description:String?
    var imageUrl:String?
}
