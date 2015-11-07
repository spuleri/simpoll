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
    
    @IBAction func optionOneButtonTouched(sender: AnyObject) {
    }
    
    @IBAction func optionTwoButtonTouched(sender: AnyObject) {
    }
}