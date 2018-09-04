//
//  DDCharastersCounterTableViewController.swift
//  JatAppTest
//
//  Created by Duba on 04.09.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit

class DDCharactersCounterTableViewController: UITableViewController {

    var characters = [(key: Character, value: Int)]()
    
    struct Indificators {
        static let charactersCounterCell = "charactersCounterCell"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return characters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charactersCounterCell", for: indexPath) as! DDCharastersCounterTableViewCell
        
        
        let object = characters[indexPath.row]
        cell.character = String(object.key)
        if cell.character == " " {
            cell.character = "Space"
        }
        cell.sum = String(object.value)
        
        

        return cell
    }
    
    //MARK: - Actions
    
 
    @IBAction func doneBarButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func sortBarButtonAction(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: "Sort by", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let character = UIAlertAction(title: "Characters", style: .default) { [unowned self] (action) in
            
            self.characters = self.characters.map { $0 }.sorted { $0.key < $1.key }
            self.tableView.reloadData()
        }
        let sum = UIAlertAction(title: "Sum", style: .default) { [unowned self] (action) in
            self.characters = self.characters.map { $0 }.sorted { $0.value < $1.value }
            self.tableView.reloadData()
        }
        actionSheet.addAction(character)
        actionSheet.addAction(sum)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
        
    }
}
    
    
    
   

