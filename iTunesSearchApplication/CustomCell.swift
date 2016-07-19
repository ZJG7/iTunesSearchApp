//
//  CustomCell.swift
//  iTunesSearchApplication
//
//  Created by Zaccary Gioffre on 7/18/16.
//  Copyright © 2016 GrizzlySoft. All rights reserved.
//

import UIKit


class CustomCell: UITableViewCell {
    
    
    @IBOutlet weak var trackNameOutlet: UILabel!
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var albumNameOutlet: UILabel!
    @IBOutlet weak var artistNameOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

