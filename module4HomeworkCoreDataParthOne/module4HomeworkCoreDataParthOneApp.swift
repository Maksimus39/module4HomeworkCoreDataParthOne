import SwiftUI
import CoreData

@main
struct module4HomeworkCoreDataParthOneApp: App {
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "db")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    @State private var coreDataManager: CoreDataManager
    @State private var viewModel: ContentViewModel
    
    init() {
        let manager = CoreDataManager(container: persistentContainer)
        _coreDataManager = State(initialValue: manager)
        _viewModel = State(initialValue: ContentViewModel(coreManager: manager))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environment(viewModel)
        }
    }
}
