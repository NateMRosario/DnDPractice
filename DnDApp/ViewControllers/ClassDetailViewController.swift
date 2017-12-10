//
//  ClassDetailViewController.swift
//  DnDApp
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ClassDetailViewController: UIViewController {
    
    var selectedClass: ClassList?
    
    var classDetails: ClassDetail?{
        didSet {
            loadClassInfo()
        }
    }
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var hitDie: UILabel!
    @IBAction func savingThrowButtonPressed(_ sender: UIButton) {
    }
    @IBAction func skillsButtonPressed(_ sender: UIButton) {
    }
    @IBAction func equipmentButtonPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadClassInfo()
        self.title = selectedClass?.name
    }

    func loadClassInfo() {
        let completion: (ClassDetail) -> Void = {(onlineDetails: ClassDetail) in
            self.classDetails = onlineDetails
        }
        ClassDetailAPIClient.manager.getClassDetails(from: (selectedClass?.url)!, completionHandler: completion , errorHandler: {print($0)})
        hitDie.text = "Hit Die: \(classDetails?.hit_die ?? 0)"
    }

}
