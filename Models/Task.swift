//
//  Task.swift
//  TODOLISTWITHRxSwiftApp
//
//  Created by IwasakIYuta on 2022/01/10.
//

import Foundation

enum Priority: Int, CaseIterable {
    case high
    case medium
    case low
    
}

struct Task {
    
    let title: String
    let priority: Priority //３パターンなんで列挙型
}
