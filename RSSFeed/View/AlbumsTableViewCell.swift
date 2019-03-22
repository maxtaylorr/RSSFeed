//
//  AlbumsTableViewCell.swift
//  RSSFeed
//
//  Created by Max Taylor on 3/21/19.
//  Copyright © 2019 Max Taylor. All rights reserved.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(album: Album) {
        albumName.sizeToFit()
        artistName.sizeToFit()
        albumName.adjustsFontForContentSizeCategory = true
        albumName.text = album.name
        artistName.text = album.artistName
        
        let imageUrl = album.artworkURL
        let imageData = try! Data(contentsOf: imageUrl)
        let image = UIImage(data: imageData)
        
        albumImage.image = image
        
    }

}
