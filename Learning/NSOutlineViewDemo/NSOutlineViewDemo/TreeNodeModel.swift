//
//  TreeNodeModel.swift
//  NSOutlineViewDemo
//
//  Created by 戴植锐 on 2018/3/7.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class TreeNodeModel: NSObject {
    var name: String?
    lazy var childNodes: Array = {
       return [TreeNodeModel]()
    }()
}
