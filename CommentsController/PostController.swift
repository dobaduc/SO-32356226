//
//  PostController.swift
//  CommentsController
//
//  Created by Paul Semionov on 01.09.15.
//  Copyright (c) 2015 Paul Semionov. All rights reserved.
//

import UIKit

class PostController: CommentsController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var templateInputContainerView: InputContainerView!
    
    var comments: [[String: String]] = [
        [
            "message": "Now imagine we attach this to the View or TableView in your ViewController! Our inputAccessView will automatically be animated into a docked position at the bottom if the View becomes the first responder.",
            "name": "Mathew"
        ],
        [
            "message": "A little more reading reveals this...",
            "name": "Grace"
        ],
        [
            "message": "That sounds like what we're after. A bit more info...",
            "name": "Stacey"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let postView = PostView.loadFromNibNamed("PostView") {
            postView.setNeedsUpdateConstraints()
            postView.updateConstraintsIfNeeded()
                        
            postView.setNeedsLayout()
            postView.layoutIfNeeded()
            
            let height = postView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
            postView.frame.size.height = height
            
            self.postView = postView
        }
        
        if let accessoryView = InputContainerView.loadFromNibNamed("InputContainerView") {
            templateInputContainerView.inputField.inputAccessoryView = accessoryView
            accessoryView.sendButton.addTarget(self, action: "send", forControlEvents: .TouchUpInside)
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == templateInputContainerView.inputField {
            if let accessoryView = templateInputContainerView.inputField.inputAccessoryView as? InputContainerView {
                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(0.4 * Double(NSEC_PER_SEC)))
                dispatch_after(delay, dispatch_get_main_queue(), { () -> Void in
                    accessoryView.inputField.becomeFirstResponder()
                    self.scrollToBottom()
                    let point = accessoryView.convertPoint(accessoryView.frame.origin, toView: self.view)
                    self.tableView.contentInset.bottom = self.tableView.frame.size.height - point.y
                    self.tableView.scrollIndicatorInsets.bottom = self.tableView.contentInset.bottom
                })
            }
        }
        
        return true
    }
    
    // MARK: - UITableView delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - UITableView data source

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentCell
        
        let comment = self.comments[indexPath.row]
        
        cell.messageLabel.text = comment["message"]
        cell.nameLabel.text = comment["name"]
        
        return cell
    }
    
    func send() {
        if let accessoryView = templateInputContainerView.inputField.inputAccessoryView as? InputContainerView {
            self.comments.append([
                "message": accessoryView.inputField.text,
                "name": "Paul"
            ])
            
            accessoryView.inputField.text = ""
        }
        
        self.reload()
        self.scrollToBottom()
    }
    
    func scrollToBottom() {
        self.tableView.scrollToRowAtIndexPath(
            NSIndexPath(forRow: self.comments.count - 1, inSection: 0),
            atScrollPosition: .Bottom,
            animated: true
        )
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
