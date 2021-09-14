//
//  Group.swift
//  justChat
//
//  Created by Mohamed Zakaria on 5/29/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import Foundation

class Group {
    
    public private (set) var key : String
    public private (set)var groupTitle: String
    public private (set)var groupDescription: String
    public private (set)var memberCount: Int
    public private (set)var members: [String]
    
    init(title: String, description: String, key: String, members: [String], memberCount: Int) {
        
        self.key = key
        self.groupTitle = title
        self.groupDescription = description
        self.memberCount = memberCount
        self.members = members
    }
    
}
