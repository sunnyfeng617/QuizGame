import SwiftUI

@main
struct Quiz_GameApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CategoryView()
                    .navigationTitle("Categories")
            }
        }
    }
}
