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
    @IBOutlet weak var titleLabel: UILabel!
    
    var imageUrl: String?
    var imageDescription: String?
    var imageTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let url = imageUrl {
            titleLabel.isHidden = true
            mainImageView.sd_setImage(with: URL(string: url))
        }
        
        if let title = titleLabel {
            titleLabel.isHidden = true
            titleLabel.text = imageTitle
        }
        
        descriptionLabel.text = imageDescription
    }
    
}
