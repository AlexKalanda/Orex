//
//  Ext+Array.swift
//  OREX
//
//  Created by admin on 28/10/2024.
//

import Foundation

extension Array {
    var str: String {
        var res: String = ""
        for i in self {
            res.append("\(i)\n")
        }
        return res
    }
}
