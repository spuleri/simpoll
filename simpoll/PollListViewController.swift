//
//  ViewController.swift
//  simpoll
//
//  Created by Sergio Puleri on 11/6/15.
//  Copyright © 2015 Sergio Puleri. All rights reserved.
//

import UIKit

class PollListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var addPollButton: UIButton!
    @IBOutlet weak var pollTableView: UITableView!
    
    var addPollView: AddPollView!
    var polls: [Poll] = []
    
    // MARK: Lifecycle
    // ----------------------------------------------------------------------------------- Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddPollButton()
        configureAddPollView()
        
        pollTableView.delegate = self
        pollTableView.dataSource = self
        
        getPolls()
        
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "dismissAddPollView")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.addPollView.addGestureRecognizer(swipeDown)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getPolls() {
        NetworkGuy.sharedInstance.getAllPolls { (polls:[Poll]) -> Void in
            self.polls = polls
            self.pollTableView.reloadData()
        }
    }
    
    // MARK: UI Config
    // ----------------------------------------------------------------------------------- UI Config

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
    
    // MARK: AddPollView
    // --------------------------------------------------------------------------------- AddPollView
    
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
    
    // MARK: Target Action
    // ------------------------------------------------------------------------------- Target Action
    
    @IBAction func addPollButtonTouched(sender: AnyObject) {
        showAddPollView()
    }
    
    // MARK: Table View Delegate and Datasource
    // ---------------------------------------------------------- Table View Delegate and Datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return polls.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: PollTableViewCell = pollTableView.dequeueReusableCellWithIdentifier("PollCell") as! PollTableViewCell
        
        cell.configureWithPoll(polls[indexPath.row])
        
        return cell
    }
}

