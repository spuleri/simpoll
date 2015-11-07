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
	var topView: UIView!
    
    // MARK: Lifecycle
    // ----------------------------------------------------------------------------------- Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddPollButton()
        configureTopView()
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
    
    func configureTopView() {
        // Create view to cover top half of screen when AddPollView is up
        topView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        topView.backgroundColor = UIColor.blackColor()//.colorWithAlphaComponent(0.0)
        topView.alpha = 0.0
        self.view.addSubview(topView)
        
        // Add tap gesture recognizer on top view to dismiss new poll modal
        let tapTopView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissAddPollView")
        self.topView.addGestureRecognizer(tapTopView)
        
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
            self.topView.alpha = 0.6
            }, completion: { finished in })
    }
    
    func dismissAddPollView() {
        UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseOut, animations: {
            var viewFrame = self.addPollView.frame
            viewFrame.origin.y += viewFrame.size.height
            self.topView.alpha = 0.0
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowDetail" {
            let cell = sender as! PollTableViewCell
            let indexPath = self.pollTableView.indexPathForCell(cell)
            let selectedPoll = self.polls[indexPath!.row]
            let detailViewController = segue.destinationViewController as! PollDetailViewController
            detailViewController.poll = selectedPoll
        }
    }
    
}

