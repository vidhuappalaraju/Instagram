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
    @IBOutlet weak var instaTime: UILabel!
    @IBOutlet weak var instaDate: UILabel!
    
    var post: Post!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
