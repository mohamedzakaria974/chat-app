//
//  GroupCell.swift
//  justChat
//
//  Created by Mohamed Zakaria on 5/29/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    
    //outlets
    
    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var groupDescriptionLabel: UILabel!
    @IBOutlet weak var membersCountLabel: UILabel!
    

    func configureCell(groupTitle title: String, groupDescription description: String, memberCount: Int) {
        
        groupTitleLabel.text = title
        groupDescriptionLabel.text = description
        membersCountLabel.text = "\(memberCount)"
    }


}
