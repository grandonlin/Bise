//
//  LocationImageVC.swift
//  Bise
//
//  Created by Grandon Lin on 2017-12-13.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class LocationImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var locationImageView: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        if currentOwner.hasLocationImage == true {
            locationImageView.image = currentOwner.locationImage
        }
    }

    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            locationImageView.image = selectedImage
            currentOwner.locationImage = selectedImage
            currentOwner.hasLocationImage = true
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func getImage(owner: Owner) -> UIImage {
        let image = owner.locationImage
        return image
    }
    
    @IBAction func nextBtnPressed(_ sender: UIBarButtonItem) {
        if let locationImage = locationImageView.image {
            if let imgData = UIImageJPEGRepresentation(locationImage, 1) {
                let imageID = "Location Image"
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                DataService().STORE_IMAGE.child("Location Photo").child(ownerID!).child(imageID).putData(imgData, metadata: metadata) { (data, error) in
                    if error != nil {
                        self.sendAlertWithoutHandler(alertTitle: "Error", alertMessage: "\(error?.localizedDescription)!", actionTitle: ["Cancel"])
                    } else {
                        let imgUrl = data?.downloadURL()?.absoluteString
                        DataService().OWNERS_CURRENT_REF.child("Location Information").child("Location Image URL").setValue(imgUrl)
                    }
                }
                
            }
        }
        performSegue(withIdentifier: "OwnerScheduleVC", sender: nil)
    }
    
    
    @IBAction func xBtnPressed(_ sender: UIButton) {
        locationImageView.image = UIImage(named: "emptyImage")
        currentOwner.locationImage = UIImage(named: "emptyImage")!
    }
    
    
}
