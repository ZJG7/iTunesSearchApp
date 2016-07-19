//
//  ViewController.swift
//  iTunesSearchApplication
//
//  Created by Zaccary Gioffre on 7/18/16.
//  Copyright © 2016 GrizzlySoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarOutlet: UITextField!
    @IBOutlet weak var scrollViewOutlet: UIScrollView!
    
    var songArray:[Song] = [Song]()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.blackColor()
        self.tableView.rowHeight = 150.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //set values for next view
        let artist = self.songArray[indexPath.row].artistName
        let song = self.songArray[indexPath.row].trackName
        let albumName = self.songArray[indexPath.row].albumName
        let imageAddress = self.songArray[indexPath.row].imageAddress
        defaults.setValue(artist, forKey: "artist")
        defaults.setValue(song, forKey: "song")
        defaults.setValue(albumName, forKey: "albumName")
        defaults.setValue(imageAddress, forKey: "imageAddress")
        
        //segue to next view on touch
        [self.performSegueWithIdentifier("showSongInformation", sender: self)]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! CustomCell
        
        
        //set the cell data
        if (self.songArray.count != 0) {
            cell.trackNameOutlet.text = self.songArray[indexPath.row].trackName
            cell.albumNameOutlet.text = self.songArray[indexPath.row].albumName
            cell.artistNameOutlet.text = self.songArray[indexPath.row].artistName
            let url = self.songArray[indexPath.row].imageAddress
            cell.imageViewOutlet.imageFromUrl(url)
            
        }
        return cell
    }
    
    
    @IBAction func searchButtonFunc(sender: AnyObject) {
        let searchString:String = searchBarOutlet.text as String!
        //checks for empty string
        if(searchString.isEmpty){
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Empty Search Key!"
            alertView.message = "Please Enter Something to Search."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else{
            //gets the data and adds it to the array
            let data = Connection.getJSONFromSite("https://itunes.apple.com/search?term="+searchString)
            let dataCount = data["resultCount"] as! Int
            let results = data["results"]
            songArray = [Song]()
            var i = 0
            while(i < dataCount){
                let result = results![i]
                //add to songArray
                let kind = result["kind"] as! String
                if(kind == "song"){
                    let artistName = result["artistName"] as! String
                    let trackName = result["trackName"] as! String
                    let albumName = result["collectionName"] as! String
                    let albumImage = result["artworkUrl60"] as! String
                    let song = Song.init(trackName: trackName, artistName: artistName, albumName: albumName, imageAddress: albumImage)
                    songArray.append(song)
                }
                i++
            }

            //load the table
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                return
             })
        }
        
    }
    
}