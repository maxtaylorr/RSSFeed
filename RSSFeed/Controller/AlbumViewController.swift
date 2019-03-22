//
//  AlbumViewController.swift
//  RSSFeed
//
//  Created by Max Taylor on 3/21/19.
//  Copyright © 2019 Max Taylor. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    var detailAlbum: Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumName.text = detailAlbum?.name
        artistName.text = detailAlbum?.artistName
        releaseDate.text = detailAlbum?.date
        
        let imageUrl = detailAlbum!.artworkURL
        let imageData = try! Data(contentsOf: imageUrl)
        let image = UIImage(data: imageData)
        
        albumImage.image = image
        
        // Do any additional setup after loading the view.
    }
}
