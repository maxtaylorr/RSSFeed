//
//  Album.swift
//  RSSFeed
//
//  Created by Max Taylor on 3/19/19.
//  Copyright © 2019 Max Taylor. All rights reserved.
//

import Foundation

struct Album {
    let name: String
    let artistName: String
    let artworkURL: URL
    let index: Int
    let date: String
    
    init(name: String, artistName: String, artworkURL: URL, index: Int, date: String) {
        self.name = name
        self.artistName = artistName
        self.artworkURL = artworkURL
        self.index = index
        self.date = date
    }
}
