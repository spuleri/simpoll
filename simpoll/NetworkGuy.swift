//
//  NetworkGuy.swift
//  simpoll
//
//  Created by Sergio Puleri on 11/7/15.
//  Copyright © 2015 Sergio Puleri. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkGuy {
    
    static let sharedInstance = NetworkGuy()
    
    let testJSON = JSON(["poll1":["question":"is it time for bed?", "option1": "yes", "option2": "no", "option1Votes": 5, "option2Votes": 1, "created": NSDate(), "privatePoll": true],
        "poll2":["question":"is it not time for bed?", "option1": "yes", "option2": "no", "option1Votes": 11, "option2Votes": 1, "created": NSDate(), "privatePoll": false],
        "poll3":["question":"is it time for bed?", "option1": "yes", "option2": "no", "option1Votes":156, "option2Votes": 1, "created": NSDate(), "privatePoll": true],
        "poll4":["question":"is it not time for bed?", "option1": "yes", "option2": "no", "option1Votes": 51, "option2Votes": 1, "created": NSDate(), "privatePoll": false]])
    
    // TODO: Remove - test endpoint to actually make an async request
    let endpoint = "https://reddit.com/.json"
    
    let pollBuilder = PollBuilder()
    
    func getAllPolls(completionClosure: ([Poll]) -> Void){
        
        Alamofire.request(.GET, endpoint)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on " + self.endpoint)
                    print(response.result.error!)
                    return
                }
                
                if let value: AnyObject = response.result.value {
                    // send dummy JSON for now instead of real response
                    let polls = self.pollBuilder.buildListOfPolls(self.testJSON)
                    
                     completionClosure(polls)
                    
                }
        }
        
        func createPoll(question: String , option1: String, option2: String) -> Poll {
            let newPoll =  self.pollBuilder.buildPollFromStrings(question, option1: option1, option2: option2)
            
            // TODO: make post request to create poll
            
            return newPoll
            
        }
        
    
        
    }
}