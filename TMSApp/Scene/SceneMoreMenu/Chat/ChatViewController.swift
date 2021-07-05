//
//  ChatViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/20/21.
//

import UIKit
import MessageKit
import InputBarAccessoryView

//struct Sender: SenderType {
//    var senderId: String
//    var displayName: String
//}
//
//struct Message: MessageType {
//    var sender: SenderType
//    var messageId: String
//    var sentDate: Date
//    var kind: MessageKind
//}

//class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
class ChatViewController: UIViewController {
    
    //    let currentUser = Sender(senderId: "self", displayName: "Nontawatkb")
    //    let otherUser = Sender(senderId: "other", displayName: "User")
    //    var messages = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        messages.append(setMessageModel(sender: currentUser, text: "สวัสดีครับ"))
        //        messages.append(setMessageModel(sender: otherUser, text: "หวัดดีงับ"))
        //        messages.append(setMessageModel(sender: currentUser, text: "มีเวลาว่างวันละ 1-2 ชั่วโมงไหมครับ"))
        //        messages.append(setMessageModel(sender: otherUser, text: "มีค่ะ"))
        //        messages.append(setMessageModel(sender: currentUser, text: "อยากมีรายได้เสริมไหมครับ"))
        //        messages.append(setMessageModel(sender: otherUser, text: "สนใจค่าาา"))
        //
        //        messagesCollectionView.messagesDataSource = self
        //        messagesCollectionView.messagesLayoutDelegate = self
        //        messagesCollectionView.messagesDisplayDelegate = self
        //        messageInputBar.delegate = self
        
    }
    
    //    func currentSender() -> SenderType {
    //        return currentUser
    //    }
    //
    //    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
    //        return messages[indexPath.section]
    //    }
    //
    //    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
    //        return messages.count
    //    }
    //
    //    func cellBottomLabelAttributedText(for message: MessageKit.MessageType, at indexPath: IndexPath) -> NSAttributedString? {
    //
    //        return NSAttributedString(string: "Read", attributes: [NSAttributedString.Key.font: UIFont.PrimaryText(size: 12), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    //    }
    //
    //    func messageTopLabelAttributedText(for message: MessageKit.MessageType, at indexPath: IndexPath) -> NSAttributedString? {
    //        let name = message.sender.displayName
    //        return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.PrimaryText(size: 12)])
    //    }
    //
    //    private func setMessageModel(sender: SenderType, text: String) -> MessageType {
    //
    //        var myMutableString = NSMutableAttributedString()
    //        myMutableString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font:UIFont.PrimaryText(size: 16), NSAttributedString.Key.foregroundColor: isFromCurrentSender(sender: sender) ? UIColor.white : UIColor.black])
    //
    //        return Message(sender: sender, messageId: "\(self.messages.count)", sentDate: Date().addingTimeInterval(-86400), kind: .attributedText(myMutableString))
    //    }
    //
    //    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
    //
    //        return .bubble
    //    }
    //
    //    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
    //        return isFromCurrentSender(sender: message.sender) ? UIColor.Primary : UIColor.lightGray.withAlphaComponent(0.1)
    //    }
    //
    //    func isFromCurrentSender(sender: SenderType) -> Bool {
    //        return sender.senderId == "self"
    //    }
    //
}

//extension ChatViewController: InputBarAccessoryViewDelegate {
//
//    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
//        messages.append(setMessageModel(sender: currentUser, text: text))
//        inputBar.inputTextView.text = ""
//
//        messagesCollectionView.scrollToLastItem()
//        messagesCollectionView.reloadData()
//    }
//
//}
