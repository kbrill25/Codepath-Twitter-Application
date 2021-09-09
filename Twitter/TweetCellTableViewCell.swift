//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Grace Brill on 9/5/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    //create outlets for image/username/content
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    //create outlets for the buttons
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    //create actions for the buttons
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        
        //favorite
        if(toBeFavorited)
        {
            //call the API
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                //change button colors
                self.setFavorite(true)
                
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
        }
        
        //unfavorite
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                //change button colors
                self.setFavorite(false)
                
            }, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")
            })
        }
    }
    
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Retweet failed, this is your error: \(error)")
        })
    }
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    func setRetweeted(_ isRetweeted:Bool){
        if(isRetweeted){
            //retweet button to green
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        
        else{
            //retweet button to gray
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
        
    }
    
    func setFavorite(_ isFavorited:Bool)  {
        favorited = isFavorited
        if(favorited){
            //set to new logo
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        
        else{
            //gray logo
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
            
        }

    }
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
