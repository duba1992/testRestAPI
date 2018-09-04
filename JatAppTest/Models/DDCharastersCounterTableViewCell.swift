//
//  DDCharastersCounterTableViewCell.swift
//  JatAppTest
//
//  Created by Duba on 04.09.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit

class DDCharastersCounterTableViewCell: UITableViewCell {

 
    @IBOutlet weak var characterLabel: UILabel!
    
    @IBOutlet weak var sumLabel: UILabel!
    
    var character : String! {
        didSet {
            characterLabel.text = "Character: " + character
        }
    }
    
    var sum : String! {
        didSet {
            sumLabel.text = "Sum: " + sum
        }
    }
}
