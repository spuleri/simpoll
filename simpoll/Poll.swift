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
    var privatePoll = true
    
    init(question: String, option1: String, option2: String, option1Votes: Int, option2Votes: Int, created: NSDate, privatePoll: Bool) {
        // Initialize
        self.question = question
        self.option1 = option1
        self.option2 = option2
        self.option1Votes = option1Votes
        self.option2Votes = option2Votes
        self.created = created
        self.privatePoll = privatePoll
    }
    
    func incrementOption1() {
        self.option1Votes++
    }
    
    func incrementOption2() {
        self.option2Votes++
    }
    
}