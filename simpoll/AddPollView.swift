//
//  AddPollView.swift
//  simpoll
//
//  Created by James on 11/6/15.
//  Copyright © 2015 Sergio Puleri. All rights reserved.
//

import UIKit

class AddPollView: UIView {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var optionTwoField: UITextField!
    @IBOutlet weak var optionOneField: UITextField!
    @IBOutlet weak var pollTextView: UITextView!
    
    var controller: AddPollController!
    
    init(frame:CGRect, controller:AddPollController) {
        super.init(frame: frame);
        self.controller = controller
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    @IBAction func cancelButtonTouched(sender: AnyObject) {
        controller.cancelButtonTouched()
    }
    
    @IBAction func submitButtonTouched(sender: AnyObject) {
        controller.submitButtonTouched()
    }
}