//
//  PostView.swift
//  CommentsController
//
//  Created by Paul Semionov on 02.09.15.
//  Copyright (c) 2015 Paul Semionov. All rights reserved.
//

import UIKit

class PostView: UIView {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> PostView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
        ).instantiateWithOwner(nil, options: nil)[0] as? PostView
    }
    
    override func layoutSubviews() {
        self.textLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.textLabel.frame)
        self.authorLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.authorLabel.frame)

        super.layoutSubviews()
    }
}
