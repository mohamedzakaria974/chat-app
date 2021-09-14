//
//  DataService.swift
//  justChat
//
//  Created by Mohamed Zakaria on 5/23/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    //create user 
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool ) -> () ) {
        
        if groupKey != nil {
        REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message, "senderID": uid])
            
           sendComplete(true)
            
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderID": uid])
            sendComplete(true)
        }
    }
    
    func getUsername(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapShot) in
            
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userSnapShot {
                
                if user.key == uid {
                    handler((user.childSnapshot(forPath: "email").value as! String))
                }
            }
        }
    }
    
    func getAllFeedMessages(handler: @escaping (_ message: [Message]) -> ()) {
        
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderID = message.childSnapshot(forPath: "senderID").value as! String
                let message = Message(content: content, senderID: senderID)
                messageArray.append(message)
                
            }
            
            handler(messageArray)
        }
        
    }
    
    func getAllMessagesFor(desiredGroup group: Group, handler: @escaping (_ messagesArray: [Message]) -> ()) {
        
        var groupMessageArray = [Message]()
        REF_GROUPS.child(group.key).child("messages").observeSingleEvent(of: .value) { (groupMessageSnapShot) in
            
            guard let groupmsgSnpaShot = groupMessageSnapShot.children.allObjects as? [DataSnapshot] else {return}
            
            for groupMsg in groupmsgSnpaShot {
                let content = groupMsg.childSnapshot(forPath: "content").value as! String
                let senderID = groupMsg.childSnapshot(forPath: "senderID").value as! String
                let grpMessage = Message(content: content, senderID: senderID)
                
                
               groupMessageArray.append(grpMessage)
            }
            
            handler(groupMessageArray)
        }
        
    }
    
    
    func getEmail(forSearchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()) {
        
        var emailArry = [String]()
        REF_USERS.observe(.value) { (userSnapShot) in
            
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userSnapShot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if email.contains(query) == true && email != Auth.auth().currentUser?.email {
                    emailArry.append(email)
                }
            }
            
            return handler(emailArry)
        }
        
    }
    
    func getIDs(forUsernames usernames: [String], handler: @escaping (_ uidArrat: [String]) -> ()) {
        
        REF_USERS.observe(.value) { (userSnapShot) in
            
            var idArray = [String]()
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userSnapShot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if usernames.contains(email) {
                    idArray.append(user.key)
                }
            }
            
            handler(idArray)
        }
    }
    
    func createGroup(withTitle title: String, withDescription description: String, forUserIds id: [String] , hanlder: @escaping(_ groupCreated: Bool) -> ()) {
        
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": id])
        hanlder(true)
    }
    
    func getAllGroups(handler: @escaping (_ groupsArray: [Group]) -> ()) {
        
        var groupsArray = [Group]()
        
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for groups in groupSnapshot {
                
                let memberArray = groups.childSnapshot(forPath: "members").value as! [String]
                
                if memberArray.contains((Auth.auth().currentUser?.uid)!) {
                    
                    let title = groups.childSnapshot(forPath: "title").value as! String
                    let description = groups.childSnapshot(forPath: "description").value as! String
                    let key = groups.key
                
                    let group = Group(title: title, description: description, key: key, members: memberArray, memberCount: memberArray.count)
                    
                    groupsArray.append(group)
                }
                
            }
            
            handler(groupsArray)
        }
    }
    
    func getEmailsFor(group: Group, handler:@escaping (_ emailArray: [String]) -> ()) {
        
        var emailArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (userSnapShot) in
            
            guard let userSnapShot = userSnapShot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapShot {
                
                if group.members.contains(user.key) {
                    
                    let email = user.childSnapshot(forPath: "email").value as! String
                    emailArray.append(email)
                    
                }
            }
            
            handler(emailArray)
        }
    }
    
}
