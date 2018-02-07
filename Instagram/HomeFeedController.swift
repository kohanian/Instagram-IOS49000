//
//  HomeFeedController.swift
//  Instagram
//
//  Created by Kyle Ohanian on 2/6/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import DateToolsSwift

class PostCell: UITableViewCell {
    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var postImage: PFImageView!
    @IBOutlet weak var likeText: UILabel!
    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var captionText: UILabel!
    @IBOutlet weak var commentsText: UILabel!
}

class HomeFeedController: UIViewController, UITableViewDelegate,
UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages {
            return messages.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = postsTableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        let currPost = messages?[indexPath.row] as! Post?
        
        
        postCell.postImage.file = currPost?.media
        postCell.postImage.loadInBackground()
        
        postCell.usernameText.text = currPost?.author.username
        postCell.captionText.text = currPost?.caption
        postCell.timeLeft.text = currPost?.createdAt?.timeAgoSinceNow
        return postCell
    }
    

    @IBOutlet weak var postsTableView: UITableView!
    var messages: [PFObject]?
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.dataSource = self
        postsTableView.delegate = self
        // construct PFQuery
        fetchPosts()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        postsTableView.insertSubview(refreshControl, at: 0)
        
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        fetchPosts()
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
    }

    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchPosts() {
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the array of object returned by the call
                self.messages = posts
                self.postsTableView.reloadData();
            } else {
                print(error?.localizedDescription)
            }
        }
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
