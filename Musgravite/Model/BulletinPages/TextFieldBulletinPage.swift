//
//  TextFieldBulletinPage.swift
//  Musgravite
//
//  Created by Fernando Martin Garcia Del Angel on 11/11/18.
//  Copyright © 2018 Aabo Technologies. All rights reserved.
//

import Foundation
import BLTNBoard

class TextFieldBulletinPage: BLTNPageItem {
    @objc public var textField: UITextField!
    @objc public var textInputHandler: ((BLTNActionItem, String?) -> Void)? = nil
    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        textField = interfaceBuilder.makeTextField(placeholder: "Primer nombre", returnKey: .done, delegate: self)
        return [textField]
    }
    
    override func tearDown() {
        super.tearDown()
        textField?.delegate = nil
    }
    
    override func actionButtonTapped(sender: UIButton) {
        textField.resignFirstResponder()
        super.actionButtonTapped(sender: sender)
    }
    
}

extension TextFieldBulletinPage: UITextFieldDelegate {
    
    @objc open func isInputValid(text: String?) -> Bool {
        if text == nil || text!.isEmpty {
            return false
        }
        return true
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if isInputValid(text: textField.text) {
            textInputHandler?(self, textField.text)
        } else {
            descriptionLabel!.textColor = .red
            descriptionLabel!.text = "Debes ingresar texto para continuar"
            textField.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        }
        
    }

}
