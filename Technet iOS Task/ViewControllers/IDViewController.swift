//
//  IDViewController.swift
//  Technet iOS Task
//
//  Created by Tom Holmes on 07/09/2022.
//

import Foundation
import UIKit

class IDViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idLabel.text = String(id)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap() {
        self.dismiss(animated: true)
    }
    
}
