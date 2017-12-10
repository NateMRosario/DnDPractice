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
        hitDie.text = "Hit Die: \(classDetails?.hitDie ?? 0)"
        guard let classes = classDetails else {return}
        switch classes.name.lowercased() {
        case "barbarian":
            detailImageView.image = #imageLiteral(resourceName: "barbarian")
        case "bard":
            detailImageView.image = #imageLiteral(resourceName: "bard")
        case "cleric":
            detailImageView.image = #imageLiteral(resourceName: "cleric")
        case "druid":
            detailImageView.image = #imageLiteral(resourceName: "druid")
        case "fighter":
            detailImageView.image = #imageLiteral(resourceName: "fighter")
        case "monk":
            detailImageView.image = #imageLiteral(resourceName: "monk")
        case "paladin":
            detailImageView.image = #imageLiteral(resourceName: "paladin")
        case "ranger":
            detailImageView.image = #imageLiteral(resourceName: "ranger")
        case "rogue":
            detailImageView.image = #imageLiteral(resourceName: "rogue")
        case "sorcerer":
            detailImageView.image = #imageLiteral(resourceName: "sorcerer")
        case "warlock":
            detailImageView.image = #imageLiteral(resourceName: "warlock")
        case "wizard":
            detailImageView.image = #imageLiteral(resourceName: "wizard")
        default:
            break
        }
        
    }
    
}
