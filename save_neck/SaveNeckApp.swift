import SwiftUI

@main
struct SaveNeckApp: App {
    private let persistence = PersistenceController.preview
    var body: some Scene {
        WindowGroup {
            Main()
                .environment(\.managedObjectContext, persistence.container.viewContext)
        }
    }
}
