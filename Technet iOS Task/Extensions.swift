//
//  Extensions.swift
//  Technet iOS Task
//
//  Created by Tom Holmes on 07/09/2022.
//

import Foundation
import UIKit

extension UITextField {

    func setupRightImage(imageName: String) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 15, height: 15))
        imageView.image = UIImage(named: imageName)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        imageContainerView.addSubview(imageView)
        rightView = imageContainerView
        rightViewMode = .always
        self.tintColor = .lightGray
    }
}
