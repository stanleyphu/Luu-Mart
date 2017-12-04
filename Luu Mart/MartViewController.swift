//
//  MartViewController.swift
//  Luu Mart
//
//  Created by Stanley Phu on 12/3/17.
//  Copyright © 2017 Stanley Phu. All rights reserved.
//

import UIKit

class MartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var itemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemTableView.delegate = self
        itemTableView.dataSource = self
        
        itemTableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "itemCell")
        
        configureTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        
        let itemArray = ["Bread with Nutella", "Chips"]
        let priceArray = ["$1.00", "$0.50"]
        
        cell.itemName.text = itemArray[indexPath.row]
        cell.itemPrice.text = priceArray[indexPath.row]
        cell.itemImageView.image = UIImage(named: "profile")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func configureTableView() {
        itemTableView.rowHeight = UITableViewAutomaticDimension
        itemTableView.estimatedRowHeight = 120.0
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
