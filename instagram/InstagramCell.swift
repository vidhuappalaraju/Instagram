//
//  InstagramCell.swift
//  instagram
//
//  Created by Vidhu Appalaraju on 9/27/18.
//  Copyright © 2018 Vidhu Appalaraju. All rights reserved.
//

import UIKit
import Parse
import AFNetworking

class InstagramCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
    @IBOutlet weak var instagramPicture: UIImageView!
    
    @IBOutlet weak var instagramCaption: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    var instagramPost: Post! {
//        didSet {
//            if let urlString = instagramPost.media.url {
//                self.instagramPicture.setImageWith(URL(string: urlString)!)
//            }
//
//        }
//    }
    


}
