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
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var imageUrl: String?
    var imageDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = imageUrl {
            mainImageView.sd_setImage(with: URL(string: url))
            topImageView.sd_setImage(with: URL(string: url))
            bottomImageView.sd_setImage(with: URL(string: url))
            
            blurImageView(imageView: topImageView)
            blurImageView(imageView: bottomImageView)
        }
        
        descriptionLabel.text = imageDescription
    }
    
    func blurImageView(imageView: UIImageView) {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds;
        imageView.addSubview(blurView)
    }
}
