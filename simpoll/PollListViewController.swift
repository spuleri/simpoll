//
//  ViewController.swift
//  simpoll
//
//  Created by Sergio Puleri on 11/6/15.
//  Copyright © 2015 Sergio Puleri. All rights reserved.
//

import UIKit

class PollListViewController: UIViewController {
    @IBOutlet weak var addPollButton: UIButton!
    
    var addPollView: AddPollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddPollButton()
        
        addPollView = AddPollView(frame: CGRectMake(0,0,0,0), controller: AddPollController(parent: self))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func configureAddPollButton() {
        addPollButton.layer.masksToBounds = false;
        addPollButton.layer.shadowOffset = CGSizeMake(0.0,1.0);
        addPollButton.layer.shadowRadius = 1.0;
        addPollButton.layer.shadowOpacity = 0.6;
        addPollButton.layer.cornerRadius = addPollButton.frame.size.width/2;
    }
    
    func showAddPollView() {
        // TODO: Animate view onscreen
    }
    
    func dismissAddPollView() {
        // TODO: Animate view offscreen
    }
    
    @IBAction func unwindToPollList(segue:UIStoryboardSegue) {
    }
}

