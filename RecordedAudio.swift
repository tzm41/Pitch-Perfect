//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Colin Tan on 6/20/15.
//  Copyright © 2015 Colin Tan. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathURL: NSURL!
    var title: String!
    
    init(filePathURL: NSURL!, title: String!) {
        self.filePathURL = filePathURL
        self.title = title
    }
}