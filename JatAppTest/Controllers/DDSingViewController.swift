//
//  DDSingViewController.swift
//  JatAppTest
//
//  Created by Duba on 03.09.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit
protocol DDSingDelegate : class {
    func getUser(user : DDUser)
}
class DDSingViewController: UIViewController {
    
    weak var delegate : DDSingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func emptyTextFields(textFields: [DDDesignableTextField], onViewController : UIViewController) -> Bool {
        
        for i in 0..<textFields.count {
            if (textFields[i].text?.isEmpty)! {
                alertForEmptyEmailPassword(index: i, onViewController: onViewController)
                return true
            }
        }
        return false
        
    }

    func matchPassword(textFields: [DDDesignableTextField]) -> Bool {
        if textFields[2].text != textFields[3].text {
            showAlert(withMessage: "Password does not match")
            return false
        }
        return true
    }
    func alertForEmptyEmailPassword(index : Int, onViewController : UIViewController) {
        var message : String!
        var myIndex = index
        if onViewController is DDSignInViewController {
            myIndex = index + 1
        }
        switch myIndex {
        case 0:
            message = "Please enter your login"
            break
        case 1:
            message = "Please enter your email"
            break
        case 2:
            message = "Please enter your password"
            break
            
        default:
            message = "Error Empty"
        }
        showAlert(withMessage: message)
        
    }
    
    func showAlert(withMessage : String) {
        let alert = UIAlertController(title: "Alert", message: withMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
