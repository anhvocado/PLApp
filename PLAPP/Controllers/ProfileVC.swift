//
//  ProfileVC.swift
//  PLAPP
//
//  Created by AnhNTV3 on 26/03/2024.
//

import UIKit

class ProfileVC: UIViewController {
    weak var delegate: MainTabbarShowHideDelegate?
    var fullItems: [UniqloProduct] = []
    var itemsMightLike: [UniqloProduct] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PROFILE"
    }
    
    @IBAction func onProfileDetail(_ sender: Any) {
        let vc = HomeVC()
        vc.title = "User Information"
        self.push(to: vc)
    }
    
    @IBAction func onOrderList(_ sender: Any) {
        let vc = OrderListVC()
        vc.title = "Orders"
        self.push(to: vc)
    }
    
    @IBAction func onWishlist(_ sender: Any) {
        let vc = ListItemVC()
        vc.title = "Wishlist"
        self.push(to: vc)
    }
    
    @IBAction func onLogout(_ sender: Any) {
        SharedData.accessToken = nil
        SharedData.userId = nil
        SharedData.password = nil
        SharedData.email = nil
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.changeRoot(LoginVC())
    }
}
