//
//  HomeViewController.swift
//  instagram
//
//  Created by Vidhu Appalaraju on 9/26/18.
//  Copyright © 2018 Vidhu Appalaraju. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBAction func onLogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        fetchPictures()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
         tableView.insertSubview(refreshControl, at: 0)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstagramCell", for: indexPath) as! InstagramCell
        let post = self.posts[indexPath.row]
        let postMedia = post.media as PFFile //posts[indexPath.row]["media"] as! PFFile
        postMedia.getDataInBackground{ (imageData: Data?, error: Error?) in
            if (error == nil) {
                if let imageData = imageData {
                    let image = UIImage(data: imageData)
                    cell.instagramPicture.image = image
                }
            }
        }
        cell.instagramCaption.text = posts[indexPath.row]["caption"] as? String
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        fetchPictures()
    }
    
    func fetchPictures(){
        // construct query
        let query = Post.query()
        query?.includeKey("media")
        query?.includeKey("author")
        query?.addDescendingOrder("createdAt")
        query?.limit = 20
        
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
               self.posts = posts as! [Post]
               self.tableView.reloadData()
               self.refreshControl.endRefreshing()
            }
            else{
                 print(error?.localizedDescription)
            }
        }
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPictures()
    }
    
    
    
}
