//
//  UserPostTableViewCell.swift
//  Social posts
//
//  Created by Ahmed Hamdy Gomaa on 10/19/18.
//  Copyright © 2018 Ahmed Hamdy Gomaa. All rights reserved.
//

import UIKit

class UserPostTableViewCell: UITableViewCell {


    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numLikesLabel: UILabel!
    private var userPostData: UserPostModel?

    @IBOutlet weak var starImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let labelTapGesture = UITapGestureRecognizer(target: self, action:#selector(favIconTapped))
        self.starImageView.addGestureRecognizer(labelTapGesture)
        self.starImageView.isUserInteractionEnabled = true
    }

    func ConfigureCell(userPost: UserPostModel)  {
        userPostData = userPost
        self.userNameLabel.text = userPost.userName
        self.timeLabel.text = Utils.convertDateToString(date: userPost.timestamp.dateValue())
        self.postTextLabel.text = userPost.postTxt
        self.numLikesLabel.text = "\(userPost.numOfLikes)"
        guard let userData = userPostData else {
            return
        }
        if UserDefaults.standard.value(forKey: userData.documentId) != nil {
             self.starImageView.image = #imageLiteral(resourceName: "heart_blue")
        } else {
            self.starImageView.image = #imageLiteral(resourceName: "heart_white")
        }
    }


   @objc public func favIconTapped() {
    guard let userData = userPostData else {
        return
    }
    if UserDefaults.standard.value(forKey: userData.documentId) == nil {
        self.starImageView.image = #imageLiteral(resourceName: "heart_blue")
        userData.numOfLikes += 1
        self.numLikesLabel.text = "\(userData.numOfLikes)"
        NetworkManager.sharedInstance.updateDocument(userPostData: userData)
        UserDefaults.standard.set(userData.documentId, forKey: userData.documentId)
    }
    }

}
