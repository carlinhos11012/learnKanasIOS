import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: MainView()) {
                    Text("Página Principal")
                        .font(.title)
                        .padding()
                }

                NavigationLink(destination: ProfileView()) {
                    Text("Perfil")
                        .font(.title)
                        .padding()
                }
            }
        }
    }
}
