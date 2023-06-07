//
//  DogDataArray.swift
//  random-dogs
//
//  Created by 이지수 on 2023/06/07.
//

import Foundation


struct DogDataArray: Codable {
    let dogDataArray: [DogData]
}

struct DogData: Codable {
    let id: String
    let url: String
    let width: Int
    let height: Int
}
