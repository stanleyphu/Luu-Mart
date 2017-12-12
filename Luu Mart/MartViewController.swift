//
//  MartViewController.swift
//  Luu Mart
//
//  Created by Stanley Phu on 12/3/17.
//  Copyright © 2017 Stanley Phu. All rights reserved.
//

import UIKit
import Firebase
import Vision

class MartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var itemsArray : [Item] = [Item]()
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var itemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemTableView.delegate = self
        itemTableView.dataSource = self
        
        itemTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "itemCell")
        
        configureTableView()
        retrieveItems()
        
        // Try uploading image
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.allowsEditing = false
//
//        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let selectedPhoto = info[UIImagePickerControllerOriginalImage]
//        dismiss(animated: true, completion: nil)
//
//        var data = Data()
//        data = UIImageJPEGRepresentation(selectedPhoto as! UIImage, 0.8)!
//        // set upload path
//        let filePath = "images/\("userPhoto").jpg"
//        let metaData = StorageMetadata()
//        metaData.contentType = "image/jpg"
//        let imageRef = Storage.storage().reference().child(filePath)
//        imageRef.putData(data, metadata: metaData) { (metaData, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            } else {
//                //store downloadURL
//                let downloadURL = metaData!.downloadURL()!.absoluteString
//                print(downloadURL)
//                //store downloadURL at database
//                //self.databaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues(["userPhoto": downloadURL])
//            }
//
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        
        cell.itemName.text = itemsArray[indexPath.row].itemName
        cell.itemPrice.text = itemsArray[indexPath.row].itemPrice
        //cell.itemImageView.image = UIImage(named: "profile")
        
        let imageRef = Storage.storage().reference().child("images/\(itemsArray[indexPath.row].itemName).jpg")
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            }
            else {
                let image = UIImage(data: data!)
                cell.itemImageView.image = image
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func configureTableView() {
        itemTableView.rowHeight = UITableViewAutomaticDimension
        itemTableView.estimatedRowHeight = 120.0
        
        itemTableView.allowsSelection = false
    }
    
    func retrieveItems() {
        
        let itemsDB = Database.database().reference().child("Items")
        
        itemsDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            let name = snapshotValue["Name"]!
            let price = snapshotValue["Price"]!
            
            let newItem = Item()
            newItem.itemName = name
            newItem.itemPrice = price
            
            self.itemsArray.append(newItem)
            
            self.configureTableView()
            self.itemTableView.reloadData()
        }
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToCart" {
            print("go to cart!")
        }
    }
    */

}
