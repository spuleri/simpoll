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
        optionOneButton.titleLabel?.text = poll.option1
        optionTwoButton.titleLabel?.text = poll.option2
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
        poll.incrementOption1()
        updateVoteCounts()
        disableVoteButtons()
    }
    
    @IBAction func optionTwoButtonTouched(sender: AnyObject) {
        poll.incrementOption2()
        updateVoteCounts()
        disableVoteButtons()
    }
}