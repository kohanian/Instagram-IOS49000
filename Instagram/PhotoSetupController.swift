//
//  PhotoSetupController.swift
//  Instagram
//
//  Created by Kyle Ohanian on 2/6/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//

import UIKit

class PhotoSetupController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var pickedImage: UIImageView!
    
    @IBOutlet weak var caption: UITextField!
    @IBAction func onCancel(_ sender: Any) {
        self.performSegue(withIdentifier: "fromSharingSegue", sender: nil)
    }
    
    @IBAction func onShare(_ sender: Any) {
        // Actually share
        let post = Post()
        post.postUserImage(image: pickedImage.image, withCaption: caption.text, withCompletion: {(succeeded, error) -> Void in
            if succeeded {
                self.performSegue(withIdentifier: "fromSharingSegue", sender: nil)
            } else {
                let alertController = UIAlertController.init(title: nil, message: "There was an error in posting your picture", preferredStyle: .alert)
                
                let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in
                })
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    @IBAction func onChoosePhoto(_ sender: Any) {
        let vc1 = UIImagePickerController()
        vc1.delegate = self
        vc1.allowsEditing = true
        vc1.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc1, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let alertController = UIAlertController.init(title: nil, message: "Device has no camera.", preferredStyle: .alert)
            
            let okAction = UIAlertAction.init(title: "Alright", style: .default, handler: {(alert: UIAlertAction!) in
            })
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        else{
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.camera
            
            self.present(vc, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        pickedImage.image = editedImage
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
