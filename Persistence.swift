//
//  Persistence.swift
//  MyStory
//
//  Created by Raghad on 23/06/1446 AH.
//

//import CoreData
//
//class PersistenceController {
//    static let shared = PersistenceController()
//
//    // الحاوية لقاعدة البيانات
//    let container: NSPersistentContainer
//
//    init(inMemory: Bool = false) {
//        container = NSPersistentContainer(name: "Model") // تأكد من أن الاسم هنا هو نفس اسم ملف .xcdatamodeld
//        if inMemory {
//            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
//        }
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                fatalError("Unresolved error \(error), \(error.localizedDescription)")
//            }
//        }
//    }
//
//    // السياق الذي يستخدم للوصول إلى البيانات
//    var viewContext: NSManagedObjectContext {
//        return container.viewContext
//    }
//}
