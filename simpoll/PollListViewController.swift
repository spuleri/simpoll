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
        configureAddPollView()
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
    
    func configureAddPollView() {
        addPollView = NSBundle.mainBundle().loadNibNamed("AddPollView", owner: self, options: nil)[0] as? AddPollView
        addPollView.configure(CGRectMake(0, self.view.frame.size.height,
            self.view.frame.size.width,
            self.view.frame.size.height/2),
            controller: AddPollController(parent: self))
        self.view.addSubview(addPollView)
    }
    
    func showAddPollView() {
        UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseOut, animations: {
            var viewFrame = self.addPollView.frame
            viewFrame.origin.y -= viewFrame.size.height
            
            self.addPollView.frame = viewFrame
            }, completion: { finished in })
    }
    
    func dismissAddPollView() {
        UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseOut, animations: {
            var viewFrame = self.addPollView.frame
            viewFrame.origin.y += viewFrame.size.height
            
            self.addPollView.frame = viewFrame
            }, completion: { finished in })
    }
    
    @IBAction func addPollButtonTouched(sender: AnyObject) {
        showAddPollView()
    }
    
    @IBAction func unwindToPollList(segue:UIStoryboardSegue) {
    }
}

