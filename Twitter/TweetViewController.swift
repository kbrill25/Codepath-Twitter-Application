//
//  TweetViewController.swift
//  Twitter
//
//  Created by Grace Brill on 9/7/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBAction func cancel(_ sender: Any) {
        //dismiss the controller
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tweet(_ sender: Any) {
        
        //check that not empty
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error in posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        
        //if the text is not empty
        else{
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //display the keyboard and cursor
        tweetTextView.becomeFirstResponder()
        
        

        // Do any additional setup after loading the view.
    }

}
