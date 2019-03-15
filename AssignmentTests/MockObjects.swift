//
//  MockObjects.swift
//  AssignmentTests
//
//  Created by Soroush Shahi on 3/15/19.
//  Copyright © 2019 Soroush Shahi. All rights reserved.
//

import Foundation
@testable import Assignment



struct Strings {
    static let batman = "batman"
    static let invalid = "mzqtw"
    static let path = "kqjL17yufvn9OVLyXYpvtyrFfak.jpg"
    static let size = "w500"
}


struct Posters {
    static let obj = Poster(id: 200, filePath: "")
    static let invalidObj = Poster(id: 1, filePath: "")

}


class MockUserDefaults : UserDefaults {
    
    convenience init() {
        self.init(suiteName: "Mock User Defaults")!
    }
    
    override init?(suiteName suitename: String?) {
        UserDefaults().removePersistentDomain(forName: suitename!)
        super.init(suiteName: suitename)
    }
    
}


