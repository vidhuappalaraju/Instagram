//
//  DetailsViewController.swift
//  instagram
//
//  Created by Vidhu Appalaraju on 10/2/18.
//  Copyright © 2018 Vidhu Appalaraju. All rights reserved.
//

import UIKit
import Parse
import AFNetworking

class DetailsViewController: UIViewController {

    @IBOutlet weak var instaPicture: UIImageView!
    @IBOutlet weak var instaUsername: UILabel!
    @IBOutlet weak var instaLikes: UILabel!
    @IBOutlet weak var instaDate: UILabel!
    @IBOutlet weak var instaCaption: UILabel!
    
    var post: Post!
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
         let result1 = dateFormatter.string(from: date)
        if let post = post {
            let postMedia = post.media as PFFile
            postMedia.getDataInBackground{ (imageData: Data?, error: Error?) in
                if (error == nil) {
                    if let imageData = imageData {
                        let image = UIImage(data: imageData)
                        self.instaPicture.image = image
                    }
                }
            }
            self.instaUsername.text = post.author.username
            self.instaDate.text = result1
            self.instaLikes.text = String(post.likesCount)
            self.instaCaption.text = post.caption
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
