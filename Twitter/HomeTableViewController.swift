//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Grace Brill on 9/5/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    //var can change
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    
    //refresh control variable
    let myRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call the loadTweet function
        loadTweet()
        
        //refreshing the tweets
        myRefreshControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    @objc func loadTweet()
    {
        //when we first load tweets
        numberOfTweets = 20
        
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": numberOfTweets]
        
        //call the api
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            //clean the array up
            self.tweetArray.removeAll()
            
            for tweet in tweets
            {
                //repopulate the tweetArray by appending the tweet
                self.tweetArray.append(tweet)
            }
            
            //make sure to reload data
            //anytime we make an API call we repopulate the list to reload data with content
            self.tableView.reloadData()
            
            //end the refresh
            self.myRefreshControl.endRefreshing()
            
        }, failure: { (Error) in
            print("Could not retrieve tweets")
        })
        
    }
    
    func loadMoreTweet()
    {
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        //increase the number of tweets
        numberOfTweets = numberOfTweets + 20
        
        let myParams = ["count": numberOfTweets]
        
        //call the api
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            //clean the array up
            self.tweetArray.removeAll()
            
            for tweet in tweets
            {
                //repopulate the tweetArray by appending the tweet
                self.tweetArray.append(tweet)
            }
            
            //make sure to reload data
            //anytime we make an API call we repopulate the list to reload data with content
            self.tableView.reloadData()
        }, failure: { (Error) in
            print("Could not retrieve tweets")
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweet()
        }
    }
    
    
    
    

    @IBAction func onLogout(_ sender: Any) {
        //logout with the api
        TwitterAPICaller.client?.logout()
        
        //return back to the login screen
        self.dismiss(animated: true, completion: nil)
        
        //set value to key to false so we can logout successfully
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        //setting the username
        cell.userNameLabel.text = user["name"] as? String
        
        //setting the tweet content
        cell.tweetContent.text =  tweetArray[indexPath.row]["text"] as? String
        
        //setting the image
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data{
            cell.profileImageView.image = UIImage(data: imageData)
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

}

