//
//  song.swift
//  iTunesSearchApplication
//
//  Created by Zaccary Gioffre on 7/18/16.
//  Copyright © 2016 GrizzlySoft. All rights reserved.
//

import Foundation

//a class to act as a song
public class Song{
    
    //all of the song data
    var trackName:String = ""
    var artistName:String = ""
    var albumName:String = ""
    var imageAddress:String = ""
    
    //constructor
    init (trackName:String, artistName: String, albumName:String, imageAddress:String){
        self.trackName = trackName
        self.artistName = artistName
        self.albumName = albumName
        self.imageAddress = imageAddress
    }
}