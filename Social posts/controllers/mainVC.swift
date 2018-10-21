//
//  ViewController.swift
//  Social posts
//
//  Created by Ahmed Hamdy Gomaa on 9/30/18.
//  Copyright © 2018 Ahmed Hamdy Gomaa. All rights reserved.
//

import UIKit

class mainVC: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var mainSegmantControlOutlet: UISegmentedControl!
    @IBOutlet weak var contentTableView: UITableView!
    private var postsList : [UserPostModel] = [UserPostModel]()
    private var custemList : [UserPostModel] = [UserPostModel]()
    private var selectedCategory : String = Categories.funny
    private var hasUserMadeCustomList : Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        NetworkManager.sharedInstance.getAllPosts { (userPosts) in
            self.postsList = userPosts
            self.contentTableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hasUserMadeCustomList {
            return custemList.count
        } else {
            return postsList.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! UserPostTableViewCell
        if hasUserMadeCustomList {
            cell.ConfigureCell(userPost: custemList[indexPath.row])
        } else {
            cell.ConfigureCell(userPost: postsList[indexPath.row])
        }
        return cell
    }

    @IBAction func UserSelectedControl(_ sender: UISegmentedControl) {
        selectedCategory = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        custemList.removeAll()
        for i in 0...postsList.count - 1 {
            if postsList[i].category == selectedCategory {
                custemList.append(postsList[i])
            }
        }
        hasUserMadeCustomList = true
        self.contentTableView.reloadData()
    }

}

