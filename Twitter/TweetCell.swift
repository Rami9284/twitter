//
//  TweetCell.swift
//  Twitter
//
//  Created by Judith Ramirez on 2/12/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var tweetlabel: UILabel!
    
    @IBOutlet weak var retweetBtn: UIButton!
    
    @IBOutlet weak var likeBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func favoriteT(_ sender: Any) {
        let toBeFavorited = !favorited
        
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetID, success: {
                self.set_favorited(isFavorited: true)
            }, failure: { (Error) in
                print("favoriting did not succeed\(Error)")
            })
        }
        
    }
    @IBAction func retweetT(_ sender: Any) {
        
    }
    
    var favorited: Bool = false
    var tweetID: Int = -1
    func set_favorited(isFavorited: Bool){
        favorited = isFavorited
        
        if(favorited){
            likeBtn.setImage(UIImage(named:"favor-icon-red"), for:UIControl.State.normal)
        }else{
            likeBtn.setImage(UIImage(named:"favor-icon"), for:UIControl.State.normal)
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
