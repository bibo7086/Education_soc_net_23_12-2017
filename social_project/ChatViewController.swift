//
//  ChatViewController.swift
//  social_project
//
//  Created by Saeed Ali on 1/20/18.
//  Copyright © 2018 Saeed Ali. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    static let getMessagesPath = "/chat/getMessages/"
    static let chatSendMessagePath = "/chat/sendMessage/"
    static let chatGetNewMessagesPath = "/chat/getNewMessages/"
    static let cellIdentifier = "chatTableViewCell"
    
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var MessageTextField: UITextField!
    @IBOutlet weak var MessageView: UIView!
    @IBOutlet weak var SendButton: UIButton!
    
    var targetID: Int!
    var chatRecord: [Chats] = [] //contains a record of the current chat
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.00, green: 0.22, blue: 0.47, alpha: 1.00)
        navigationController?.navigationBar.isTranslucent = false
        MessageView.bindToKeyboard()
        
        MessageTextField.clearsOnBeginEditing = true
        
        
        chatTableView.separatorStyle = .none
        chatTableView.rowHeight = UITableViewAutomaticDimension
        fetchMessages()
        
        
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ChatViewController.fetchNewMessages)), userInfo: nil, repeats: true)
    }
    
    
  
    
    func fetchMessages(){
        let id = String(describing: targetID!)
        let URLParams = ["id": id, "start": "0", "limit": "30"]
        let _ = ProfileViewController.sharedWebClient.load(path: ChatViewController.getMessagesPath , method: .get, params: URLParams){(data, error) in
            
            /* GUARD: was there an error */
            
            guard (error == nil) else {
                print(error?.errorDescription! as Any)
                return
            }
            
            /*  Get records from parsed Data */
            guard let records = data?["records"] as? NSArray else {
                print("There was an error parsing the data")
                return
            }
            
            self.chatRecord =  Chats.modelsFromDictionaryArray(array: records)
            
            DispatchQueue.main.async {
                self.chatTableView.reloadData()
            }
        }
    }
    
    
    func sendMessage( textToUpload: String, completionHandler: @escaping CompletionHandler )
    {
        let id = String(describing: targetID!)
        let bodyObject: [String : Any] = ["target_id": id, "message": textToUpload]
        let _   = CommentViewController.sharedWebClient.load(path: ChatViewController.chatSendMessagePath, method: .post, params: bodyObject){(data, error) in
            
            // was the comment succesffully posted
            // Was the Post successfully posted?
            guard (error == nil) else {
                print(error?.errorDescription as Any)
                completionHandler(false)
                return
            }
            completionHandler(true)
            
            
        }
    }
    
    func fetchNewMessages(){
        let id = String(describing: targetID!)
        let URLParams = ["id": id]
        let _ = ProfileViewController.sharedWebClient.load(path: ChatViewController.chatGetNewMessagesPath , method: .get, params: URLParams){(data, error) in
            
            /* GUARD: was there an error */
            
            guard (error == nil) else {
                print(error?.errorDescription! as Any)
                return
            }
            
            /*  Get records from parsed Data */
            guard let records = data?["records"] as? NSArray else {
                print("There was an error parsing the data")
                return
            }

            let localRecord =  Chats.modelsFromDictionaryArray(array: records)
            
            for message in localRecord {
                self.chatRecord.append(message)
                print(message.dictionaryRepresentation())
                
            }
            
            DispatchQueue.main.async {
                self.chatTableView.reloadData()

            }
            
        }
        
        
        
    }
    
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if MessageTextField.text != nil {
            SendButton.isEnabled = false
            sendMessage(textToUpload: MessageTextField.text!){ (isComplete) in
                if isComplete {
                    self.SendButton.isEnabled = true
                    self.fetchMessages()
                }
                else {
                    self.SendButton.isEnabled = true
                    print("There was an error sending the message")
                }
                
            }
      MessageTextField.text = ""
        }
        
        
    }
    
    
    
    @IBAction func MessagesButtonPressed(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
}


extension ChatViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRecord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = chatTableView.dequeueReusableCell(withIdentifier: ChatViewController.cellIdentifier, for: indexPath) as! chatTableViewCell
        
        if(chatRecord[indexPath.row].to_id  == targetID ){
            cell.receivedMessageview.isHidden = true
            cell.sentMessageView.isHidden = false
            cell.sentMessageLabel.text = chatRecord[indexPath.row].msg
        }
        else {
            cell.sentMessageView.isHidden = true
            cell.receivedMessageview.isHidden = false
            
            cell.receiveMessageLabel.text = chatRecord[indexPath.row].msg
        }
        cell.selectionStyle = .none
        return cell
    }
    
}
