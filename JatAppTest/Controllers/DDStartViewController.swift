//
//  DDStartViewController.swift
//  JatAppTest
//
//  Created by Duba on 03.09.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit

class DDStartViewController: UIViewController {


    weak var user : DDUser!
    
    struct Indificators {
        static let segueToSingIn = "segueToSingIn"
        static let segueToSingUp = "segueToSingUp"
        static let segueToTextView = "segueToTextView"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Indificators.segueToSingIn {
            
                if let nextVC = segue.destination as? DDSignInViewController  {
                    nextVC.delegate = self
                }
            } else if segue.identifier == Indificators.segueToSingUp  {
                if let nextVC = segue.destination as? DDSingUpViewController  {
                nextVC.delegate = self
            }
        } else if  segue.identifier == Indificators.segueToTextView {
            if let nav = segue.destination as? UINavigationController {
                if let nextVC = nav.topViewController as? DDTextViewController {
                    nextVC.user = user
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
      
}

extension DDStartViewController : DDSingDelegate {
    func getUser(user: DDUser) {
        self.user = user
          performSegue(withIdentifier: Indificators.segueToTextView, sender: self)
       
    }
}

