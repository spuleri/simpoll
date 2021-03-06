//
//  PollModel.swift
//  simpoll
//
//  Created by Sergio Puleri on 11/6/15.
//  Copyright © 2015 Sergio Puleri. All rights reserved.
//

import Foundation

class Poll {
    
    var question: String
    var option1: String
    var option2: String
    var option1Votes: Int
    var option2Votes: Int
    var created: NSDate
    var ID: String
    
    init(question: String, option1: String, option2: String, option1Votes: Int, option2Votes: Int, created: NSDate, ID: String) {
        self.question = question
        self.option1 = option1
        self.option2 = option2
        self.option1Votes = option1Votes
        self.option2Votes = option2Votes
        self.created = created
        self.ID = ID
    }
    
    func incrementOption(option: Int) {
        option == 0 ? ++self.option1Votes : ++self.option2Votes;
    }
    
    func decrementOption(option: Int) {
        option == 0 ? --self.option1Votes : --self.option2Votes;
    }
}