//
//  ImageCell.swift
//  Technet iOS Task
//
//  Created by Tom Holmes on 07/09/2022.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var durationWrapper: UIView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        durationWrapper.layer.cornerRadius = 7
        durationWrapper.layer.maskedCorners = [.layerMinXMinYCorner]
    }

}
