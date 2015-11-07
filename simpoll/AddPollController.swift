//
//  AddPollController.swift
//  simpoll
//
//  Created by James on 11/6/15.
//  Copyright © 2015 Sergio Puleri. All rights reserved.
//

import Foundation

class AddPollController: NSObject {
    var parent: PollListViewController!
    
    init(parent: PollListViewController) {
        self.parent = parent
    }
    
    func cancelButtonTouched() {
        parent.dismissAddPollView()
    }
    
    func submitButtonTouched() {
        // TODO: Build a Poll object with the views contents and pass it along
        parent.dismissAddPollView()
    }
}