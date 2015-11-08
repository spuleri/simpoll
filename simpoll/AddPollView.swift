//
//  AddPollView.swift
//  simpoll
//
//  Created by James on 11/6/15.
//  Copyright © 2015 Sergio Puleri. All rights reserved.
//

import UIKit

class AddPollView: UIView, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var optionTwoField: UITextField!
    @IBOutlet weak var optionOneField: UITextField!
    @IBOutlet weak var pollTextView: UITextView!
    @IBOutlet weak var optionOneView: UIView!
    @IBOutlet weak var optionTwoView: UIView!
    @IBOutlet weak var pollView: UIView!
    
    var controller: AddPollController!
    
    // MARK: Initialization
    // ------------------------------------------------------------------------------ Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    func configure(frame:CGRect, controller:AddPollController) {
        self.frame = frame
        self.controller = controller
        optionOneField.delegate = self
        optionTwoField.delegate = self
        pollTextView.delegate = self
        
        configureUI()
    }
    
    // MARK: Target Action
    // ------------------------------------------------------------------------------- Target Action
    
    @IBAction func cancelButtonTouched(sender: AnyObject) {
        clearFields()
        controller.cancelButtonTouched()
    }
    
    @IBAction func submitButtonTouched(sender: AnyObject) {
        controller.submitButtonTouched(pollTextView.text, option1: optionOneField.text!, option2: optionTwoField.text!)
    }
    
    func clearFields() {
        optionOneField.text = ""
        optionTwoField.text = ""
        pollTextView.text = "Enter your poll here!"
    }
    
    // MARK: UI Config
    // ----------------------------------------------------------------------------------- UI Config
    
    func configureUI() {
        configureButton(cancelButton)
        configureButton(submitButton)
        configureInsetView(optionOneView)
        configureInsetView(optionTwoView)
        configureInsetView(pollView)
    }
    
    func configureButton(button: UIButton) {
        button.layer.masksToBounds = false;
        button.layer.shadowOffset = CGSizeMake(0.0,1.0);
        button.layer.shadowRadius = 1.0;
        button.layer.shadowOpacity = 0.6;
        button.layer.cornerRadius = 4.0;
    }
    
    func configureInsetView(view: UIView) {
        view.layer.masksToBounds = true;
        view.layer.shadowOffset = CGSizeMake(-1.0,-1.0);
        view.layer.shadowRadius = 0;
        view.layer.shadowOpacity = 0.2;
        view.layer.cornerRadius = 4.0;
    }
    
    // MARK: Text Field Delegate
    // ------------------------------------------------------------------------- Text Field Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // MARK: Text View Delegate
    // -------------------------------------------------------------------------- Text View Delegate
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}