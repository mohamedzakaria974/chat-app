//
//  GroupsFeedCell.swift
//  justChat
//
//  Created by Mohamed Zakaria on 5/29/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import UIKit

class GroupsFeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    func configureCell(profileImage: UIImage, email: String, content: String) {
        
        self.profileImage.image = profileImage
        self.emailLabel.text = email
        self.contentLabel.text = content
        
    }

}
