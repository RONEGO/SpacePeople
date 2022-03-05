//
//  spaceStationsModel.swift
//  SpacePeople
//
//  Created by Yegor Geronin on 05.03.2022.
//

import Foundation

struct searchImages:    Decodable {
    let results:    [webImage]
}

struct webImage:        Decodable {
    let urls:       imageQuality
}

struct imageQuality:    Decodable {
    let regular:    String
    let small:      String
}
