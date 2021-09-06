//
//  LoginViewController.swift
//  Twitter
//
//  Created by Grace Brill on 9/5/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func onLoginButton(_ sender: Any) {
        let myUrl = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: myUrl, success: {
            //do not ask user to login again
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            
            //perform segue to move to next screen
            self.performSegue(withIdentifier: "loginToHome", sender: self)
            
        }, failure: { Error in
                print("Could not login")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //once your page shows up, what do you want to do
    override func viewDidAppear(_ animated: Bool) {
        
        //check the user's default for userLoggedIn
        if(UserDefaults.standard.bool(forKey: "userLoggedIn") == true)
        {
            //go straight to the segue
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
}
