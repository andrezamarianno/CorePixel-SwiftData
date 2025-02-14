// Ana Jamas, Andreza Marianno, Guilherme Fabbri, Heitor Ivaza
// CorePixelApp //


//VERSÃO CORE DATA
/*import SwiftUI

@main
struct YourAppName: App {
    let persistenceController = PersistenceController.shared
    let viewModel : CorePixelViewModel = CorePixelViewModel()
    
    var body: some Scene {
        WindowGroup {
            CatalogoView(viewModel: viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
*/

import SwiftUI
import SwiftData

@main
struct CorePixelApp: App {
    let container: ModelContainer
    @State private var viewModelSwift: ModelSwiftData
    
    init() {
        do {
            container = try ModelContainer(for: Desenhos.self)
            viewModelSwift = ModelSwiftData(modelContext: container.mainContext)
        } catch {
            fatalError("erro no ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
//            CatalogoView(viewModelSwift: viewModelSwift)
            SplashView(viewModelSwift: viewModelSwift)
        }
        .modelContainer(container)
    }
}
