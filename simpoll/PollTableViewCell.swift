//
//  PollTableViewCell.swift
//  simpoll
//
//  Created by James on 11/7/15.
//  Copyright © 2015 Sergio Puleri. All rights reserved.
//

import UIKit

class PollTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionOneButton: UIButton!
    @IBOutlet weak var optionTwoButton: UIButton!
    @IBOutlet weak var optionOneVoteLabel: UILabel!
    @IBOutlet weak var optionTwoVoteLabel: UILabel!
    
    var poll: Poll!
    
    func configureWithPoll(poll:Poll) {
        self.poll = poll
        configureOptionButtons()
        questionLabel.text = poll.question
        optionOneButton.setTitle(poll.option1, forState: .Normal)
        optionTwoButton.setTitle(poll.option2, forState: .Normal)
        updateVoteCounts()
    }
    
    func configureOptionButtons() {
        optionOneButton.layer.borderWidth = 1.0;
        optionOneButton.layer.borderColor =  UIColor(red: 209.0/255.0, green: 147.0/255.0, blue: 209.0/255.0, alpha: 1.0).CGColor
        optionTwoButton.layer.borderWidth = 1.0;
        optionTwoButton.layer.borderColor =  UIColor(red: 209.0/255.0, green: 147.0/255.0, blue: 209.0/255.0, alpha: 1.0).CGColor
    }
    
    func updateVoteCounts() {
        optionOneVoteLabel.text = "\(poll.option1Votes) votes"
        optionTwoVoteLabel.text = "\(poll.option2Votes) votes"
    }
    
    func disableVoteButtons() {
        optionOneButton.enabled = false
        optionTwoButton.enabled = false
    }
    
    @IBAction func optionOneButtonTouched(sender: AnyObject) {
        optionOneButton.backgroundColor = UIColor(red: 209.0/255.0, green: 147.0/255.0, blue: 209.0/255.0, alpha: 1.0)
        optionOneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        poll.incrementOption1()
        voteCast()
    }
    
    @IBAction func optionTwoButtonTouched(sender: AnyObject) {
        optionTwoButton.backgroundColor = UIColor(red: 209.0/255.0, green: 147.0/255.0, blue: 209.0/255.0, alpha: 1.0)
        optionTwoButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        poll.incrementOption2()
        voteCast()
    }
    
    func voteCast() {
        updateVoteCounts()
        NetworkGuy.sharedInstance.updatePoll(poll.ID, option1votes: poll.option1Votes, option2votes: poll.option2Votes)
        disableVoteButtons()
    }
}