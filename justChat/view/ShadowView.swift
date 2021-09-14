//
//  ShadowView.swift
//  justChat
//
//  Created by Mohamed Zakaria on 5/25/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.75
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
