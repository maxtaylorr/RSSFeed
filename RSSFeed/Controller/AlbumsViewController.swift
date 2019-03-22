//
//  AlbumViewController.swift
//  RSSFeed
//
//  Created by Max Taylor on 3/19/19.
//  Copyright © 2019 Max Taylor. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var albumsTableView: UITableView!
    var albums = [Album]()
    let FETCH_URL_DATA = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/10/explicit.json"
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumsTableView.rowHeight = 75
        self.title = "Top 10 Albums"
        
        getAlbumResults()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
        if let cell = cell as? AlbumsTableViewCell {
            let album = albums[indexPath.row]
            cell.configure(album: album)
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAlbumResults()
        albumsTableView.reloadData()
    }
    
    func getAlbumResults() {
        var albumResults = [Album]()
        var index = 0;
        
        let url = URL(string: FETCH_URL_DATA)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let jsonSerialize = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    let json = jsonSerialize
                    
                    var query = json?["feed"] as? [String : Any]
                    
                    let jsonItems = query?["results"] as? [[String : Any]]
                    
                    for item in jsonItems! {
                        albumResults.append(Album(name: self.isValidString(item: item["name"] as! String),
                                                  artistName: self.isValidString(item: item["artistName"]),
                                                  artworkURL: URL(string: (item["artworkUrl100"]) as! String)!,
                                                  index: index,
                                                  date: self.getReleaseDate(date: item["releaseDate"] as! String)))
                        index += 1;
                    }
                    
                    // setting albums declared outside getAlbumResults equal to albumResults
                    // also clearing albumResults for future use
                    self.albums = albumResults
                    albumResults.removeAll()
                    
                    DispatchQueue.main.async {
                        self.albumsTableView.reloadData()
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    // validating json strings just in case
    
    func isValidString(item: Any?) -> String {
        if item != nil {
            return (item as? String)!
        }
        return ""
    }
    
    // the iTunes RSS returns this date in a funky way so just reformatting it
    
    func getReleaseDate(date: String) -> String {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormatter.date(from: date)!
        dateFormatter.dateFormat = "MM-dd-yyy"
        return dateFormatter.string(from: newDate)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "AlbumDetailView", sender: self)
    }
    
    // sending the selected album to the new detail view controller
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "AlbumDetailView") {
            
            let controller = segue.destination as? AlbumViewController
            let path = albumsTableView.indexPathForSelectedRow
            let row = path?.row
            controller!.detailAlbum = albums[row!]
        }
    }
    
    func numberOfSections(in albumsTableView: UITableView) -> Int {
        return 1
    }
}
