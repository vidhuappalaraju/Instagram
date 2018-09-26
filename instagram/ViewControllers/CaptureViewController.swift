//
//  CaptureViewController.swift
//  instagram
//
//  Created by Vidhu Appalaraju on 9/26/18.
//  Copyright © 2018 Vidhu Appalaraju. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var captionText: UITextField!
    @IBOutlet weak var postImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        postImageView.image = originalImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class Post: PFObject, PFSubclassing {
        @NSManaged var media : PFFile
        @NSManaged var author: PFUser
        @NSManaged var caption: String
        @NSManaged var likesCount: Int
        @NSManaged var commentsCount: Int
        
        /* Needed to implement PFSubclassing interface */
        class func parseClassName() -> String {
            return "Post"
        }
        
        /**
         * Other methods
         */
        
        /**
         Method to add a user post to Parse (uploading image file)
         
         - parameter image: Image that the user wants upload to parse
         - parameter caption: Caption text input by the user
         - parameter completion: Block to be executed after save operation is complete
         */
        class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
            // use subclass approach
            let post = Post()
            
            // Add relevant fields to the object
            post.media = getPFFileFromImage(image: image)! // PFFile column type
            post.author = PFUser.current()! // Pointer column type that points to PFUser
            post.caption = caption!
            post.likesCount = 0
            post.commentsCount = 0
            
            // Save object (following function will save the object in Parse asynchronously)
            post.saveInBackground(block: completion)
        }
        
        /**
         Method to convert UIImage to PFFile
         
         - parameter image: Image that the user wants to upload to parse
         
         - returns: PFFile for the the data in the image
         */
        class func getPFFileFromImage(image: UIImage?) -> PFFile? {
            // check if image is not nil
            if let image = image {
                // get image data and check if that is not nil
                if let imageData = UIImagePNGRepresentation(image) {
                    return PFFile(name: "image.png", data: imageData)
                }
            }
            return nil
        }
    }
    
    @IBAction func onSubmit(_ sender: Any) {
//        Post.registerSubclass()
//        Post.postUserImage(image: postImageView.image, withCaption: captionText.text) { (success: Bool, error: Error?) in
//            
//           self.performSegue(withIdentifier: "postSegue", sender: nil)
//        }
//        
        
    }
    
    @IBAction func onTap(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
}
