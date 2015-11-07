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
    
    var endpoint = "https://reddit.com/.json"
    
    func getAllPolls(){
        
        Alamofire.request(.GET, endpoint)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on " + self.endpoint)
                    print(response.result.error!)
                    return
                }
                
                if let value: AnyObject = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let posts = JSON(value)
                                        
                    if let title = posts["data"]["children"][0]["data"]["title"].string {
                        // to access a field:
                        print("The title is: " + title)
                    } else {
                        print("error parsing /posts/1")
                    }
                }
        }
        
    }
}