//
//  Item.swift
//  jphacks
//
//  Created by sekiya on 2019/10/20.
//  Copyright © 2019 sekiya. All rights reserved.
//

import Foundation


struct Item:Codable {
    let id: Int
    let user_id: Int
    let date: String
    let text: String
    let img_url: String
    let map_lat: String
    let map_lon: String
    let like_cnt: Int
}
