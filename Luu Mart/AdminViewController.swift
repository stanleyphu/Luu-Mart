//
//  AdminViewController.swift
//  Luu Mart
//
//  Created by Stanley Phu on 12/10/17.
//  Copyright © 2017 Stanley Phu. All rights reserved.
//

import UIKit
import Firebase

class AdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var itemsArray : [Item] = [Item]()

    @IBOutlet weak var adminTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        adminTableView.delegate = self
        adminTableView.dataSource = self
        
        adminTableView.register(UINib(nibName: "AdminItemCell", bundle: nil), forCellReuseIdentifier: "adminItemCell")

        configureTableView()
        retrieveItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "adminItemCell", for: indexPath) as! AdminItemCell
        
        cell.adminItemName.text = itemsArray[indexPath.row].itemName
        //cell.itemImageView.image = UIImage(named: "profile")
        
        let imageRef = Storage.storage().reference().child("images/\(itemsArray[indexPath.row].itemName).jpg")
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            }
            else {
                let image = UIImage(data: data!)
                cell.adminItemImageView.image = image
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func configureTableView() {
        adminTableView.rowHeight = UITableViewAutomaticDimension
        adminTableView.estimatedRowHeight = 110.0
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
            self.adminTableView.reloadData()
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            print("Signed out!")
        }
        catch {
            print("error: there was a problem logging out")
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
