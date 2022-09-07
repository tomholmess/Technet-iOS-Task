//
//  VideoObject.swift
//  Technet iOS Task
//
//  Created by Tom Holmes on 07/09/2022.
//

import Foundation

struct Video: Codable {
    var id: Int
    var title, description, duration, releaseDate: String?
    var images: [Image]?
}

struct Image: Codable {
    var url: String?
    var type: String?
}
