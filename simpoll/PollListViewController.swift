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
    var refreshControl: UIRefreshControl!
    
    // MARK: Lifecycle
    // ----------------------------------------------------------------------------------- Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        pollTableView.delegate = self
        pollTableView.dataSource = self
        
        getPolls()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getPolls() {
        NetworkGuy.sharedInstance.getAllPolls { (polls:[Poll]) -> Void in
            self.polls = polls
            self.pollTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: UI Config
    // ----------------------------------------------------------------------------------- UI Config

    func configureUI() {
        configureAddPollButton()
        configureTopView()
        configureAddPollView()
        configureRefreshControl()
        
        pollTableView.estimatedRowHeight = 130.0
        pollTableView.rowHeight = UITableViewAutomaticDimension
    }
    
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
        topView.backgroundColor = UIColor.blackColor()
        topView.alpha = 0.0
        self.view.addSubview(topView)
        
        let tapTopView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissAddPollView")
        self.topView.addGestureRecognizer(tapTopView)
    }
    
    func configureAddPollView() {
        addPollView = NSBundle.mainBundle().loadNibNamed("AddPollView", owner: self, options: nil)[0] as? AddPollView
        addPollView.configure(self.view.frame, controller: AddPollController(parent: self))
        self.view.addSubview(addPollView)
        
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "dismissAddPollView")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.addPollView.addGestureRecognizer(swipeDown)
    }
    
    func configureRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "getPolls", forControlEvents: UIControlEvents.ValueChanged)
        self.pollTableView.addSubview(refreshControl)
    }
    
    // MARK: AddPollView
    // --------------------------------------------------------------------------------- AddPollView
    
    func showAddPollView() {
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: {
            var viewFrame = self.addPollView.frame
            viewFrame.origin.y = self.view.frame.size.height - viewFrame.size.height
            self.addPollView.frame = viewFrame
            self.topView.alpha = 0.6
            }, completion: { finished in })
    }
    
    func dismissAddPollView() {
        UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseOut, animations: {
            var viewFrame = self.addPollView.frame
            viewFrame.origin.y = self.view.frame.size.height
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
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return polls.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            return UIView()
        }
        return UIView(frame: CGRectMake(0,0,8,0))
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0.0
        }
        return 8.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: PollTableViewCell = pollTableView.dequeueReusableCellWithIdentifier("PollCell") as! PollTableViewCell
        
        cell.configureWithPoll(polls[indexPath.section])
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowDetail" {
            let cell = sender as! PollTableViewCell
            let detailViewController = segue.destinationViewController as! PollDetailViewController
            detailViewController.poll = cell.poll
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
    }
}

