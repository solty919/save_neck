import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        //初期データ生成
        (1...5).forEach {
            let neckDay = NeckDay(context: viewContext)
            neckDay.latitude = 1.11
            neckDay.longitude = 1.11
            neckDay.date = Calendar.current.date(byAdding: .day, value: -$0, to: Date.now)
        }
        (1...3).forEach {
            let neckDay = NeckDay(context: viewContext)
            neckDay.latitude = 1.11
            neckDay.longitude = 1.11
            neckDay.date = Calendar.current.date(byAdding: .day, value: -$0, to: Date.now)
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NeckDay")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
