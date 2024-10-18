import SwiftUI
import CoreData

struct ProfileView: View {
    // FetchRequest para Hiragana
    @FetchRequest(
        entity: KanaScore.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "listType == %@", "hiragana")
    ) var hiraganaScores: FetchedResults<KanaScore>
    
    // FetchRequest para Katakana
    @FetchRequest(
        entity: KanaScore.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "listType == %@", "katakana")
    ) var katakanaScores: FetchedResults<KanaScore>
    
    // FetchRequest para Misto
    @FetchRequest(
        entity: KanaScore.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "listType == %@", "mixed")
    ) var mixedScores: FetchedResults<KanaScore>
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Hiragana")) {
                    if let score = hiraganaScores.first {
                        Text("Pontuação: \(score.score)")
                    } else {
                        Text("Sem pontuação")
                    }
                }
                
                Section(header: Text("Katakana")) {
                    if let score = katakanaScores.first {
                        Text("Pontuação: \(score.score)")
                    } else {
                        Text("Sem pontuação")
                    }
                }
                
                Section(header: Text("Misto")) {
                    if let score = mixedScores.first {
                        Text("Pontuação: \(score.score)")
                    } else {
                        Text("Sem pontuação")
                    }
                }
            }
            .navigationTitle("Perfil")
        }
    }
}
