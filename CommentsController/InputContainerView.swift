//
//  InputContainerView.swift
//  CommentsController
//
//  Created by Paul Semionov on 01.09.15.
//  Copyright (c) 2015 Paul Semionov. All rights reserved.
//

import UIKit

class InputContainerView: UIView {
    
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> InputContainerView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
        ).instantiateWithOwner(nil, options: nil)[0] as? InputContainerView
    }
}
