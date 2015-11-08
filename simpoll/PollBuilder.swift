//
//  PollBuilder.swift
//  simpoll
//
//  Created by Sergio Puleri on 11/7/15.
//  Copyright © 2015 Sergio Puleri. All rights reserved.
//

import Foundation
import SwiftyJSON

class PollBuilder {
    
    func buildListOfPolls(pollsJSON: JSON) -> [Poll] {
        var listOfPolls = [Poll]()
        
        for (_,subJson):(String, JSON) in pollsJSON {
            
            let poll = buildPollFromJSON(subJson)
            listOfPolls.append(poll)
        }
        
        return listOfPolls
    }
    
    func buildPollFromJSON(pollJSON: JSON) -> Poll {
        return Poll(question: pollJSON["question"].stringValue, option1: pollJSON["option1"].stringValue, option2: pollJSON["option2"].stringValue, option1Votes: pollJSON["option1votes"].intValue, option2Votes: pollJSON["option2votes"].intValue, created: NSDate(), ID: pollJSON["id"].stringValue)
    }
}