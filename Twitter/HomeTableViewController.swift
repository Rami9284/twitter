//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Judith Ramirez on 2/11/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController:


UITableViewController {
    
    //container for all tweets
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    @objc func loadtweet(){
        numberOfTweets = 20
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myparams = ["count":numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: myparams as [String : Any], success: { (tweets: [NSDictionary]) in
            for tweet in tweets {
               // self.tweetArray.removeAll()
                self.tweetArray.append(tweet)
                
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }
        }, failure: { (Error) in
            print("Could not retrive tweets!")
        })
    }
    
    func loadMoreTweets(){
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        numberOfTweets = numberOfTweets + 20
        
        let myParams = ["count": numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: myParams as [String : Any], success: { (tweets: [NSDictionary]) in
            for tweet in tweets {
                // self.tweetArray.removeAll()
                self.tweetArray.append(tweet)
                
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }
        }, failure: { (Error) in
            print("Could not retrive tweets! Oh no!")
        })
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count{
            loadMoreTweets()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadtweet()
        
        myRefreshControl.addTarget(self, action: #selector(loadtweet), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
   override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       // self.loadtweet()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        cell.nameLabel.text = user["name"] as? String
        cell.tweetlabel.text = tweetArray[indexPath.row]["text"] as! String
        
        //image
        let imageUrl = URL(string:(user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.pictureView.image = UIImage(data: imageData)
            //cell.provideImageData.image = UIImage(data: imageData)
        }
        
        cell.set_favorited(isFavorited: tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetID = tweetArray[indexPath.row]["id"] as! Int
        cell.setRetweeted(isRetweeted: tweetArray[indexPath.row]["retweeted"] as! Bool)
    
        return cell
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
 
    

}
