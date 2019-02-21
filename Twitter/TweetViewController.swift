//
//  TweetViewController.swift
//  Twitter
//
//  Created by Judith Ramirez on 2/18/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    
    @IBOutlet weak var tweetBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.delegate = self
        tweetTextView.text = "Go ahead, type a post"
        //tweetTextView.becomeFirstResponder()
        tweetTextView.textColor = UIColor.lightGray
        tweetTextView.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if tweetTextView.textColor == UIColor.lightGray{
            tweetTextView.text = nil
            tweetTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if tweetTextView.text.isEmpty{
            tweetTextView.text = "Go ahead, type a post"
            tweetTextView.textColor = UIColor.gray
        }
    }
    

    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, succcess: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet\(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
