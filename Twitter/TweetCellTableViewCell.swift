//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by ivan on 2021/10/8.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var reTweetButton: UIButton!
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: {(error) in
                print("Favorite did not succeed: \(error)")
            
            })
        }
        
        else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: { self.setFavorite(false)}, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")
            })
        }
    }
    
  
   
    @IBAction func retweet(_ sender: Any){
        TwitterAPICaller.client?.reTweet(tweetId: tweetId, success:{self.setRetweeted(true)} , failure: {(error) in print("Error is retweeting\(error)")}
        )
    }
    func setRetweeted (_ isRetweeted:Bool) {
        if (isRetweeted) {
            reTweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            reTweetButton.isEnabled = false
        }
        else{
            reTweetButton.setImage(UIImage(named:"retweet-icon"), for:
                                    UIControl.State.normal)
            reTweetButton.isEnabled = true
        }
    }
    
    func setFavorite (_ isFavorited:Bool) {
        favorited = isFavorited
        if (favorited) {
            favButton.setImage((UIImage(named:"favor-icon-red")), for: UIControl.State.normal)
        }
        else{
            favButton.setImage((UIImage(named:"favor-icon")), for: UIControl.State.normal)
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
