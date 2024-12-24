//
//  ReviewPage.swift
//  MyStory
//
//  Created by Raghad on 18/06/1446 AH.
//
//
//import SwiftUI
//import AVFoundation
//import _AVKit_SwiftUI
//import SwiftData
//
//struct ReviewPage: View {
//    @Environment(\.modelContext) var modelContext
//    @Query var stories: [Story]  // تأكد أن اسم الحقل يبدأ بحرف صغير
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Image("Background")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//                
//                VStack {
//                    List {
//                        ForEach(stories) { story in
//                            HStack {
//                                Text(story.title)  // عرض العنوان
//                                Spacer()
//                                Text(story.date, style: .date)  // عرض التاريخ بصيغة جميلة
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Try")
//            .toolbar {
//                Button("Add Sample", action: addSamples)
//            }
//        }
//    }
//    
//    func addSamples() {
//        let sampleStory = Story(title: "Sample Story", background: "School", character: "SadBoy")
//        modelContext.insert(sampleStory)
//    }
//}
//
//#Preview {
//    ReviewPage()
//}
