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
    
    // MARK: Initialization
    // ------------------------------------------------------------------------------ Initialization
    
    init(parent: PollListViewController) {
        self.parent = parent
    }
    
    // MARK: Target Action
    // ------------------------------------------------------------------------------- Target Action
    
    func keyboardDismissed() {
        parent.setAddPollViewFrameForHeight(parent.view.frame.height)
    }
    func cancelButtonTouched() {
        parent.dismissAddPollView()
    }
    
    func submitButtonTouched(question:String, option1:String, option2:String) {
        if (!question.isEmpty && !option1.isEmpty && !option2.isEmpty) {
            NetworkGuy.sharedInstance.createPoll(question, option1: option1, option2: option2)
        }
        parent.dismissAddPollView()
    }
}