//
//  FeedViewController.swift
//  justChat
//
//  Created by Mohamed Zakaria on 5/26/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    //outlers
    
    @IBOutlet weak var tableView: UITableView!
    
    //variables
    var messageArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DataService.instance.getAllFeedMessages { (returnedMessagesArray) in
            self.messageArray = returnedMessagesArray.reversed()
            self.tableView.reloadData()
        }
    }


}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCell else {return UITableViewCell()}
        
        let message = messageArray[indexPath.row]
        let image = UIImage(named: "defaultProfileImage")
        DataService.instance.getUsername(forUID: message.sender) { (returnedUserName) in
            
            cell.configureCell(profileImage: image!, email: returnedUserName, contentMessage: message.content)
        }

        return cell
    }
}
