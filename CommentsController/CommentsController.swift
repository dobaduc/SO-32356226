//
//  CommentsController.swift
//  CommentsController
//
//  Created by Paul Semionov on 01.09.15.
//  Copyright (c) 2015 Paul Semionov. All rights reserved.
//

import UIKit

class CommentsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var postView: UIView! {
        didSet {
            self.tableView.tableHeaderView = self.postView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.tableView.tableFooterView = UIView(frame: CGRectMake(0, 0, self.tableView.bounds.size.width, 1))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload() {
        self.tableView.reloadData()
    }
    
    // MARK: - UITableView delegate
}
