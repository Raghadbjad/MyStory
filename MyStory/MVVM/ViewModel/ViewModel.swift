




//import SwiftUI
//import SwiftData
//import Foundation
//import Combine
//
//
//    class ViewModel: ObservableObject {
//        @Published var stories: [Story] = []
//        @Published var selectedBackground: String = ""
//        @Published var selectedCharacter: String = ""
//        
//        private var context: ModelContext
//        
//        init(context: ModelContext) {
//            self.context = context
//            fetchStories()
//        }
//        
//        func fetchStories() {
//            let request = FetchDescriptor<Story>()
//            if let fetchedStories = try? context.fetch(request) {
//                self.stories = fetchedStories
//            }
//        }
//        
//        func addStory(title: String, background: String, character: String) {
//            let newStory = Story(title: title, background: background, character: character, date: Date())
//            context.insert(newStory)
//            saveChanges()
//            fetchStories()
//        }
//        
//        func saveChanges() {
//            do {
//                try context.save()
//            } catch {
//                print("Error saving context: \(error.localizedDescription)")
//            }
//        }
//    }

    
//
//    func addStory() {
//        
//    }
//    
//    func deleteStory() {
//        
//    }
//
//    func ChooseBackground(){
//        
//    }
//    
//    func ChooseCharcter(){
//        
//    }
//    
//    func AuodiRecording(){
//        
//        
//    }
//    
//    func PlaySound(){
//        
//        
//    }
    
    
    

