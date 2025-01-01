//
//  Story.swift
//  MyStory
//
//  Created by Raghad on 17/06/1446 AH.
//
import SwiftUI
import Foundation
import SwiftData

//@Model
//final class Story {
//    var title: String
//    var background: String
//    var character: String
//    var audioRecording: URL?
//    var finalVideo: URL?
//    var date: Date
//
//    init(title: String = "", background: String = "", character: String = "", audioRecording: URL? = nil, finalVideo: URL? = nil, date: Date = .now) {
//        self.title = title
//        self.background = background
//        self.character = character
//        self.audioRecording = audioRecording
//        self.finalVideo = finalVideo
//        self.date = date
//    }
//}

import SwiftData

@Model
class Story {
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
