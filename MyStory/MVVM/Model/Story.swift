//
//  Story.swift
//  MyStory
//
//  Created by Raghad on 17/06/1446 AH.
//
import SwiftUI
import Foundation
import SwiftData

@Model
final class Story {
    @Attribute(.unique) var id: UUID
    var title: String
    var background: String
    var character: String
    var audioRecording: URL?
    var finalVideo: URL?
    var date: Date

    init(
        id: UUID = UUID(),
        title: String,
        background: String,
        character: String,
        audioRecording: URL? = nil,
        finalVideo: URL? = nil,
        date: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.background = background
        self.character = character
        self.audioRecording = audioRecording
        self.finalVideo = finalVideo
        self.date = date
    }
}
