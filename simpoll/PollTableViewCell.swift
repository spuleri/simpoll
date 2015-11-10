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
    
    private var vote: Int = -1
    private var options: [UIButton]!
    var poll: Poll!
    
    func configureWithPoll(poll:Poll) {
        self.poll = poll
        configureOptionButtons()
        questionLabel.text = poll.question
        optionOneButton.setTitle(poll.option1, forState: .Normal)
        optionTwoButton.setTitle(poll.option2, forState: .Normal)
        updateVoteCounts()
        options = [optionOneButton, optionTwoButton]
    }
    
    func configureOptionButtons() {
        optionOneButton.layer.borderWidth = 1.0;
        optionOneButton.layer.borderColor =  UIColor(red: 209.0/255.0, green: 147.0/255.0, blue: 209.0/255.0, alpha: 1.0).CGColor
        optionOneButton.tag = 0
        optionTwoButton.layer.borderWidth = 1.0;
        optionTwoButton.layer.borderColor =  UIColor(red: 209.0/255.0, green: 147.0/255.0, blue: 209.0/255.0, alpha: 1.0).CGColor
        optionTwoButton.tag = 1
    }
    
    func updateVoteCounts() {
        optionOneVoteLabel.text = (poll.option1Votes == 1) ? "\(poll.option1Votes) vote" : "\(poll.option1Votes) votes"
        optionTwoVoteLabel.text = (poll.option2Votes == 1) ? "\(poll.option2Votes) vote" : "\(poll.option2Votes) votes"
    }
    
    @IBAction func optionButtonTouched(sender: UIButton) {
        selectOption(sender.tag)
    }
    
    func selectOption(option: Int) {
        if (vote != option) {
            if ((vote) != -1) {
                deselectOption()
            }
            vote = option
            options[vote].backgroundColor = UIColor(red: 209.0/255.0, green: 147.0/255.0, blue: 209.0/255.0, alpha: 1.0)
            options[vote].setTitleColor(UIColor.whiteColor(), forState: .Normal)
            poll.incrementOption(vote)
            voteCast()
        }
    }
    
    func deselectOption() {
        options[vote].backgroundColor = UIColor.whiteColor()
        options[vote].setTitleColor(UIColor(red: 209.0/255.0, green: 147.0/255.0, blue: 209.0/255.0, alpha: 1.0), forState: .Normal)
        poll.decrementOption(vote)
    }
    
    func voteCast() {
        updateVoteCounts()
        NetworkGuy.sharedInstance.updatePoll(poll.ID, option1votes: poll.option1Votes, option2votes: poll.option2Votes)
    }
}