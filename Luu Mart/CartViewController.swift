//
//  CartViewController.swift
//  Luu Mart
//
//  Created by Stanley Phu on 12/4/17.
//  Copyright © 2017 Stanley Phu. All rights reserved.
//

import UIKit
import Firebase
import Braintree
import BraintreeDropIn
import SVProgressHUD

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cartTableView: UITableView!
    
//    var venmoDriver : BTVenmoDriver?
//    var venmoButton : UIButton?
//    var apiClient : BTAPIClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Venmo
//        self.apiClient = BTAPIClient(authorization: "1f55e1ead39f2c557eb9a8cc4b4e2e4d1b895f17d2cbc2879369f04109eec3ad")!
//
//        self.venmoDriver = BTVenmoDriver(apiClient: self.apiClient)
//        // setup venmo button..
//        self.venmoButton?.isHidden = self.venmoDriver?.isiOSAppAvailableForAppSwitch() ?? true

        // Do any additional setup after loading the view.
        cartTableView.delegate = self
        cartTableView.dataSource = self

        cartTableView.register(UINib(nibName: "CartItemCell", bundle: nil), forCellReuseIdentifier: "cartItemCell")

        configureTableView()
        cartTableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cartItemCell", for: indexPath) as! CartItemCell

        cell.callback = {
            SVProgressHUD.showError(withStatus: "Deleted!")
            SVProgressHUD.dismiss(withDelay: 1)
            self.cartTableView.reloadData()
        }
        cell.tag = indexPath.row
        cell.cartItemName.text = ShoppingCart.shoppingCart.cartItems[indexPath.row].itemName
        cell.cartItemPrice.text = ShoppingCart.shoppingCart.cartItems[indexPath.row].itemPrice
        cell.cartItemImageView.image = ShoppingCart.shoppingCart.cartItems[indexPath.row].itemImage

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingCart.shoppingCart.cartItems.count
    }

    func configureTableView() {
        cartTableView.rowHeight = UITableViewAutomaticDimension
        cartTableView.estimatedRowHeight = 120.0
        
        //cartTableView.separatorStyle = .none
        cartTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ShoppingCart.shoppingCart.cartItems.remove(at: indexPath.row)
        cartTableView.reloadData()
    }
    
    @IBAction func purchaseButtonClicked(_ sender: UIButton) {
        showDropIn(clientTokenOrTokenizationKey: "sandbox_p8fd8ndh_8t99xbx476vx2yh4")
    }
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                print(result)
                print(result.paymentMethod)
                print(result.paymentDescription)
                print(result.paymentOptionType)
                
                SVProgressHUD.showSuccess(withStatus: "Purchased!")
                SVProgressHUD.dismiss(withDelay: 1)
                self.clearCart()
                
                // Use the BTDropInResult properties to update your UI
                // result.paymentOptionType
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    func clearCart() {
        ShoppingCart.shoppingCart.cartItems = []
        cartTableView.reloadData()
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

