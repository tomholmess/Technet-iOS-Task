//
//  ImageViewerViewController.swift
//  Technet iOS Task
//
//  Created by Tom Holmes on 07/09/2022.
//

import Foundation
import UIKit
import SDWebImage

class ImageViewerViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var imageUrl: String?
    var imageDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let url = imageUrl {
            mainImageView.sd_setImage(with: URL(string: url))
        }
        
        descriptionLabel.text = imageDescription
    }
    
}
