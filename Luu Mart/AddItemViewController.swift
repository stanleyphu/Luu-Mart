//
//  AddItemViewController.swift
//  Luu Mart
//
//  Created by Stanley Phu on 12/10/17.
//  Copyright © 2017 Stanley Phu. All rights reserved.
//

import UIKit
import Firebase

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var productPriceField: UITextField!
    @IBOutlet weak var addItemButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemImageView.layer.borderWidth = 2
        itemImageView.layer.borderColor = UIColor.gray.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func choosePhotoPressed(_ sender: UIButton) {
        sender.setTitle("", for: .normal)
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage {
            itemImageView.image = selectedPhoto
        }
        
        itemImageView.layer.borderWidth = 0
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addItemPressed(_ sender: UIButton) {
        // Upload image to Firebase Storage
        var data = Data()
        data = UIImageJPEGRepresentation(itemImageView.image!, 0.8)!
        // set upload path
        let filePath = "images/\(productNameField.text!).jpg"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        let imageRef = Storage.storage().reference().child(filePath)
        imageRef.putData(data, metadata: metaData) { (metaData, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                print("Uploaded product photo!")
                //store downloadURL
                //let downloadURL = metaData!.downloadURL()!.absoluteString
                //print(downloadURL)
                //store downloadURL at database
                //self.databaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues(["userPhoto": downloadURL])
            }
            
        }
        
        //Store product information in database
        productNameField.endEditing(true)
        productNameField.isEnabled = false
        productPriceField.endEditing(true)
        productPriceField.isEnabled = false
        addItemButton.isEnabled = false
        
        let itemsDB = Database.database().reference().child("Items")
        
        let itemDictionary = ["Name": productNameField.text!,
                              "Price": "$\(productPriceField.text!)"]
        
        itemsDB.childByAutoId().setValue(itemDictionary) {
            (error, reference) in
            
            if error != nil {
                print(error!)
            }
            else {
                print("Item saved successfully!")
            }
            
            self.itemImageView.image = nil
            self.productNameField.isEnabled = true
            self.productPriceField.isEnabled = true
            self.addItemButton.isEnabled = true
            self.productNameField.text = ""
            self.productPriceField.text = ""
            
        }
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
