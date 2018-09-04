//
//  DDSingOutViewController.swift
//  JatAppTest
//
//  Created by Duba on 03.09.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit



class DDSingUpViewController: DDSingViewController {
    let request = DDAPIRequest.instance
    
    @IBOutlet var textFields: [DDDesignableTextField]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
 
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - Actions
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        if self.emptyTextFields(textFields: textFields, onViewController: self) {
            return
        }
        if self.matchPassword(textFields: textFields) == false {
            return
        }
        
        if let login = textFields[0].text, let email = textFields[1].text, let password = textFields[2].text {
            request.singUp(withLogin: login, email: email, andPassword: password) { [unowned self] (user, error) in
                if let error = error {
                    self.showAlert(withMessage: error)
                    return
                }
                if let user = user {
                    self.delegate?.getUser(user : user)
                    self.textFields = nil
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    
    }

}

//MARK:- TextFieldDelegate
extension DDSingUpViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let index = getActiveTextField(textField as! DDDesignableTextField)
            else {
                return false
        }
        if index == textFields.count - 1 {
            
            
            registerButtonAction(self)
            return true
        }
        return textFields[index + 1].becomeFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
     
        guard let index = getActiveTextField(textField as! DDDesignableTextField)
            else {
                return false
        }
        for i in (0..<index).reversed() {
            if textFields[i].text == ""{
                textFields[i].shake()
                textFields[i].becomeFirstResponder()
                return false;
            }
        }
        
        return true;
    }
    
    func getActiveTextField(_ textField: DDDesignableTextField  ) -> Int?{
        guard let index = textFields.index(of: textField ) else {
            return nil
        }
        return index
        
        
    }
}
