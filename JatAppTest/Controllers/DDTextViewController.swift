//
//  DDTextViewController.swift
//  JatAppTest
//
//  Created by Duba on 03.09.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit

class DDTextViewController: UIViewController {
    
    var user : DDUser!
    let request = DDAPIRequest.instance
    var characters = [(key: Character, value: Int)]()
    struct Indificators {
        static let segueToCharastersCounter = "segueToCharastersCounter"
    }
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadText()
        textView.isEditable = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func loadText() {
        request.getText(withAccessToken: user.accessToken!) { (text, errorMessage) in
            if let text = text {
                self.textView.text = text
            }
        }

    }
    
    private func countCharaster() -> [(key: Character, value: Int)] {
        var dict = [Character : Int]()
        if var text = textView.text {
        text = text.uppercased()
             dict = text.reduce([:]) { (res, char) -> Dictionary<Character,Int>  in
                let counter = res[char] ?? 0
                var res = res
                res[char] = counter + 1
                
                return res
                
            }
        }
        let array = dict.map { $0 }.sorted { $0.key < $1.key }
        return array
    }
    
    
    //MARK: - Actions
    @IBAction func countTextButtonAction(_ sender: Any) {
        
        characters = countCharaster()
        performSegue(withIdentifier: Indificators.segueToCharastersCounter, sender: self)
        
    }
    
    @IBAction func refreshTextBarButtonAction(_ sender: Any) {
        loadText()
    }
    

    @IBAction func logOutBarButtonAction(_ sender: Any) {

        dismiss(animated: true) { [unowned self] in
           self.show(DDStartViewController(), sender: nil)
        }
    }

    
    // MARK: - Navigation

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Indificators.segueToCharastersCounter  {
            
            if let nav = segue.destination as? UINavigationController {
                if let nextVC = nav.topViewController as? DDCharactersCounterTableViewController {
                    nextVC.characters = characters
                   
                }
            }
        }
    }
}
 


