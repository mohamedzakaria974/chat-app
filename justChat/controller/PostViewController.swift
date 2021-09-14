//
//  PostViewController.swift
//  justChat
//
//  Created by Mohamed Zakaria on 5/27/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController {
    
    //outlets
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        sendButton.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.emailLabel.text = Auth.auth().currentUser?.email
    }

    @IBAction func sendButtonPressed(_ sender: Any) {
        
        if textView.text != nil && textView.text != "Type something here to send ..." {
            sendButton.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (success) in
                if success {
                    self.sendButton.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendButton.isEnabled = false
                    print("something went wrong")
                }
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension PostViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}



