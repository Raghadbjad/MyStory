//
//  MyStoryApp.swift
//  MyStory
//
//  Created by Raghad on 14/06/1446 AH.
//

import SwiftUI

//@main
//struct MyStoryApp: App {
//    var body: some Scene {
//        WindowGroup {
//            Splash()
//        }
//    }
//}

import SwiftUI
import SwiftData

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
//            LogInPage()
            Splash()
        }
        .modelContainer(for: [Story.self]) // إضافة SwiftData Container
    }
}
