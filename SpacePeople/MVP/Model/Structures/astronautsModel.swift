//
//  Astronauts.swift
//  SpacePeople
//
//  Created by Yegor Geronin on 04.03.2022.
//

import Foundation

struct apiResult:   Decodable {
    let people:     [astronaut]
    let message:    String
    let number:     Int
}

struct astronaut:   Decodable {
    let craft:      String
    let name:       String
}
