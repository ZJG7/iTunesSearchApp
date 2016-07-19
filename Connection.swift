//
//  Connection.swift
//  iTunesSearchApplication
//
//  Created by Zaccary Gioffre on 7/18/16.
//  Copyright © 2016 GrizzlySoft. All rights reserved.
//

import Foundation

/*
A connection class for natively using APIs in swift. With more time I would use SwiftyJSON and AlamoFire to do perform Asynch calls rather than Synch calls. Since we are making a small amount of calls I believe for times sake Synch is ok, although normally I would use Asynch calls.
*/
public class Connection{
    
    //changes spaces for + to properly function
    class func buildUrl(searchString: String) -> String{
        return searchString.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    //returns a json using the API 
    class func getJSONFromSite(urlCall: String) -> NSDictionary{
        
        let urlPath: String = buildUrl(urlCall)
        let url: NSURL = NSURL(string: urlPath)!
        let request1: NSURLRequest = NSURLRequest(URL: url)
        let response: AutoreleasingUnsafeMutablePointer<NSURLResponse? >= nil
        let dataVal: NSData =  try! NSURLConnection.sendSynchronousRequest(request1, returningResponse: response)
        let jsonResult: NSDictionary = try! NSJSONSerialization.JSONObjectWithData(dataVal, options: [NSJSONReadingOptions.AllowFragments, NSJSONReadingOptions.MutableContainers]) as! NSDictionary
        return jsonResult
        
    }
    
    //the api is not returning in the correct format so I have to parse the string
    class func getJSONFromLyricsSite(urlCall: String) -> String{
        let urlPath: String = buildUrl(urlCall)
        let url: NSURL = NSURL(string: urlPath)!
        let request1: NSURLRequest = NSURLRequest(URL: url)
        let response: AutoreleasingUnsafeMutablePointer<NSURLResponse? >= nil
        let dataVal: NSData =  try! NSURLConnection.sendSynchronousRequest(request1, returningResponse: response)
        let datastring = NSString(data: dataVal, encoding:NSUTF8StringEncoding)
        let data = datastring as! String
        let array = data.characters.split{$0 == ":"}.map(String.init)
        let indexStartOfText = array[3].startIndex.advancedBy(1)
        let indexEndOfText = array[3].endIndex.advancedBy(-8)
        let index = indexStartOfText..<indexEndOfText
        var lyrics = array[3].substringWithRange(index)
        return lyrics
        
      
    }
    
    
}