//
//  LyricsViewController.swift
//  iTunesSearchApplication
//
//  Created by Zaccary Gioffre on 7/18/16.
//  Copyright © 2016 GrizzlySoft. All rights reserved.
//

import UIKit

class LyricsViewController: UIViewController{
    
    let defaults = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var trackNameOutlet: UILabel!
    @IBOutlet weak var artistNameOutlet: UILabel!
    @IBOutlet weak var albumNameOutlet: UILabel!    
    @IBOutlet weak var lyricsOutlet: UITextView!
    
    @IBAction func backFunc(sender: AnyObject) {
        
        //reset the defaults upon leaving view
        defaults.setValue("", forKey: "artist")
        defaults.setValue("", forKey: "song")
        defaults.setValue("", forKey: "albumName")
        defaults.setValue("", forKey: "imageAddress")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set and load all of the data 
         let artist = defaults.valueForKey("artist") as! String
        let song = defaults.valueForKey("song") as! String
        let albumName = defaults.valueForKey("albumName") as! String
        let imageAddress = defaults.valueForKey("imageAddress") as! String
        
        artistNameOutlet.text = artist
        trackNameOutlet.text = song
        albumNameOutlet.text = albumName

        let url = imageAddress

        imageViewOutlet.imageFromUrl(url)
        let result = Connection.getJSONFromLyricsSite("http://lyrics.wikia.com/api.php?action=lyrics&artist="+artist+"&song="+song+"&fmt=json")
       // let lyrics = result["lyrics"] as! String
        
        lyricsOutlet.text = result
    }
    
}

//allows the loading of an image from a url
extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
}