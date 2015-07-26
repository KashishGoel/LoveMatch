//
//  ChatViewController.swift
//  LoveMatch
//
//  Created by Kashish Goel on 2015-07-26.
//  Copyright (c) 2015 Kashish Goel. All rights reserved.
//

import Foundation

class ChatViewController: JSQMessagesViewController {
    var messages: [JSQMessage] = []
    
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
    
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = currentUser()!.id
        self.senderDisplayName = currentUser()!.name
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
        // Do any additional setup after loading the view.
    }
    
    func sendersDisplayName() -> String! {
    
    return currentUser()!.id
    
    }
    
    func sendersId() -> String! {
    return currentUser()!.id
    
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        var data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        var data = self.messages[indexPath.row]
        if data.senderId == PFUser.currentUser()?.objectId {
        return outgoingBubble
        }
        else {
        return incomingBubble
        }
        
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        let m = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        self.messages.append(m)
        finishSendingMessage()
    }
}
