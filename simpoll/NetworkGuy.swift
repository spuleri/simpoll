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
    
    let baseURL = "http://simpoll-remote.cloudapp.net"
    let latestEndpoint = "/polls_chron/"
    let mostVotesEndpoint = "/polls_top/"
    let pollEndpoint = "/poll/"
    let newPollEndpoint = "/polls/"
    let updatePollEndpoint = "/poll/" // + pollID
    
    let pollBuilder = PollBuilder()
    
    func getAllPolls(completionClosure: ([Poll]) -> Void) {
        let URL = baseURL + latestEndpoint
        Alamofire.request(.GET, URL)
            .responseJSON { response in
                guard response.result.error == nil else {
                    print("Error calling GET on " + URL)
                    print(response.result.error!)
                    return
                }
            
            let polls = self.pollBuilder.buildListOfPolls(JSON(response.result.value!))
            
            completionClosure(polls)

        }
    }
    
    func createPoll(question: String , option1: String, option2: String) {
        let newPollJSON = [
            "question": question,
            "option1": option1,
            "option2": option2
        ]
        
        let URL = baseURL + newPollEndpoint
        
        Alamofire.request(.POST, URL, parameters: newPollJSON, encoding: .JSON).responseJSON { response in
            guard response.result.error == nil else {
                print("error calling GET on " + URL)
                print(response.result.error!)
                return
            }
        }
    }
    
    func updatePoll(id: String , option1votes: Int, option2votes: Int) {
        let newPollJSON: [String : AnyObject] = [
            "id": id,
            "option1votes": option1votes,
            "option2votes": option2votes
        ]
        
        let URL = baseURL + updatePollEndpoint + id
        
        Alamofire.request(.PUT, URL, parameters: newPollJSON, encoding: .JSON).responseJSON { response in
            guard response.result.error == nil else {
                print("error calling GET on " + URL)
                print(response.result.error!)
                return
            }
        }
    }
}