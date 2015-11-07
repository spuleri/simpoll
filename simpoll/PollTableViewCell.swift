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
    
    //var poll: Poll!
    
    func configureWithPoll(/*poll:Poll*/) {
        /*
        questionLabel.text = poll.question
        optionOneButton.titleLabel.text = poll.option1
        optionTwoButton.titleLabel.text = poll.option2
        optionOneVoteLabel.text = poll.option1Count + " votes"
        optionTwoVoteLabel.text = poll.option2Count + " votes"
        */
    }
    
    @IBAction func optionOneButtonTouched(sender: AnyObject) {
        // TODO: Increment vote count and update poll
    }
    
    @IBAction func optionTwoButtonTouched(sender: AnyObject) {
        // TODO: Increment vote count and update poll
    }
}