//
//  ViewController.swift
//  DnDApp
//
//  Created by C4Q on 12/7/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ClassViewController: UIViewController {

    var classes = [ClassList]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        let url = "http://www.dnd5eapi.co/api/classes"
        ClassListAPIClient.manager.getClasses(from: url, completionHandler: {self.classes = $0}, errorHandler: {print($0)})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ClassDetailViewController {
            let classSelected = classes[tableView.indexPathForSelectedRow!.row]
            destination.selectedClass = classSelected
        }
    }
}
extension ClassViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let charClass = classes[indexPath.row]
        let classCell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath)
        classCell.textLabel?.text = charClass.name
        return classCell
    }
}
