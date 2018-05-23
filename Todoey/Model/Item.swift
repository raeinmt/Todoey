//
//  Item.swift
//  Todoey
//
//  Created by Raein Teymouri on 5/23/18.
//  Copyright © 2018 Raein Teymouri. All rights reserved.
//

import Foundation

class Item : Encodable, Decodable {
    
    var title: String = ""
    var done: Bool = false
    
    init() {

    }
    
}
