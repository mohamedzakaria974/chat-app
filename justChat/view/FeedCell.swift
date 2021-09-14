//
//  FeedCell.swift
//  justChat
//
//  Created by Mohamed Zakaria on 5/26/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    //outlets
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contentMessageLabel: UILabel!
    
    func configureCell(profileImage: UIImage, email: String, contentMessage: String) {
        self.profileImage.image = profileImage
        self.emailLabel.text = email
        self.contentMessageLabel.text = contentMessage
        
    }
    
}
