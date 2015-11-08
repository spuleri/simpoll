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
    @IBOutlet weak var pollField: UITextField!
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
        self.frame = CGRectMake(0, frame.height, frame.width, heightOfElements())
        self.controller = controller
        optionOneField.delegate = self
        optionTwoField.delegate = self
        pollField.delegate = self
        
        configureUI()
    }
    
    func heightOfElements() -> CGFloat {
        return (cancelButton.frame.origin.y + cancelButton.frame.height + 8)
    }
    
    // MARK: Target Action
    // ------------------------------------------------------------------------------- Target Action
    
    @IBAction func cancelButtonTouched(sender: AnyObject) {
        clearFields()
        self.endEditing(true)
        controller.cancelButtonTouched()
    }
    
    @IBAction func submitButtonTouched(sender: AnyObject) {
        controller.submitButtonTouched(pollField.text!, option1: optionOneField.text!, option2: optionTwoField.text!)
    }
    
    func clearFields() {
        optionOneField.text = ""
        optionTwoField.text = ""
        pollField.text = ""
    }
    
    
    // MARK: UI Config
    // ----------------------------------------------------------------------------------- UI Config
    
    func configureUI() {
        configureButton(cancelButton)
        configureButton(submitButton)
        configureInsetView(optionOneView)
        configureInsetView(optionTwoView)
        configureInsetView(pollView)
        changePlaceholderColor(pollField)
        changePlaceholderColor(optionOneField)
        changePlaceholderColor(optionTwoField)
    }
    
    func configureButton(button: UIButton) {
        button.layer.borderWidth = 1.0;
        button.layer.borderColor =  UIColor(red: 209.0/255.0, green: 147.0/255.0, blue: 209.0/255.0, alpha: 1.0).CGColor
    }
    
    func configureInsetView(view: UIView) {
        view.layer.masksToBounds = true;
        view.layer.shadowOffset = CGSizeMake(-1.0,-1.0);
        view.layer.shadowRadius = 0;
        view.layer.shadowOpacity = 0.2;
        view.layer.cornerRadius = 4.0;
    }
    
    func changePlaceholderColor(field: UITextField) {
        let str = NSAttributedString(string: field.placeholder!, attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        field.attributedPlaceholder = str
    }
    
    // MARK: Text Field Delegate
    // ------------------------------------------------------------------------- Text Field Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        controller.keyboardDismissed()
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