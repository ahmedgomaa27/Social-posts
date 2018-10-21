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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let labelTapGesture = UITapGestureRecognizer(target: self, action:#selector(labelTapped))
        self.numLikesLabel.addGestureRecognizer(labelTapGesture)
        self.numLikesLabel.isUserInteractionEnabled = true
    }

    func ConfigureCell(userPost: UserPostModel)  {
        userPostData = userPost
        self.userNameLabel.text = userPost.userName
        self.timeLabel.text = Utils.convertDateToString(date: userPost.timestamp.dateValue())
        self.postTextLabel.text = userPost.postTxt
        self.numLikesLabel.text = "\(userPost.numOfLikes)"
    }


   @objc public func labelTapped() {
    guard let userData = userPostData else {
        return
    }
    userData.numOfLikes += 1
    self.numLikesLabel.text = "\(userData.numOfLikes)"
    NetworkManager.sharedInstance.updateDocument(userPostData: userData)
    }

}
