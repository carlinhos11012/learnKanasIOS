import SwiftUI
import CoreData

struct MainView: View {
    @State private var difficultyLevel: Double = 1
    @State private var listType: String = "hiragana"
    @State private var inputText: String = ""
    @State private var randomKanaList: [Kana] = []
    @State private var answer: String = ""
    @State private var showPortuguese: Bool = false

    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack {
            Text("Dificuldade: \(Int(difficultyLevel))")
                .font(.headline)
                .padding(.top, 20)

            Slider(value: $difficultyLevel, in: 1...3, step: 1)
                .padding()
                .onChange(of: difficultyLevel) { newValue in
                    updateKanaViews(level: Int(newValue))
                }

            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(randomKanaList, id: \.id) { kana in
                        VStack {
                            Text(kana.kana)
                                .font(.largeTitle)
                                .padding()
                            if showPortuguese {
                                Text(kana.portuguese)
                                    .font(.subheadline)
                            } else {
                                Text(kana.portuguese)
                                    .font(.subheadline)
                                    .opacity(0)
                            }
                        }
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                        .padding(5)
                    }
                }
            }
            .frame(height: 200)
            .padding()

            TextField("Digite a resposta", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: inputText) { newValue in
                    if newValue.lowercased() == answer.lowercased() {
                        updateKanaViews(level: Int(difficultyLevel))
                        inputText = ""
                        saveScore()
                    }
                }

            Button(action: {
                showPortuguese.toggle()
            }) {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            .padding()

            Spacer()

            HStack {
                Button("Hiragana") {
                    listType = "hiragana"
                    updateKanaViews(level: Int(difficultyLevel))
                }
                .padding()

                Button("Katakana") {
                    listType = "katakana"
                    updateKanaViews(level: Int(difficultyLevel))
                }
                .padding()

                Button("Misto") {
                    listType = "mixed"
                    updateKanaViews(level: Int(difficultyLevel))
                }
                .padding()
            }
        }
        .onAppear {
            DataStore.loadKanas()
            updateKanaViews(level: Int(difficultyLevel))
        }
    }

    private func updateKanaViews(level: Int) {
        randomKanaList.removeAll()
        answer = ""
        for _ in 0..<level {
            let position = Int.random(in: 0..<DataStore.getSize(listType: listType))
            let kana = DataStore.getKana(listType: listType, position: position)
            randomKanaList.append(kana)
            answer += kana.portuguese
        }
    }

    private func saveScore() {
        // Cria uma busca para encontrar o KanaScore existente para o listType atual
        let fetchRequest: NSFetchRequest<KanaScore> = KanaScore.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "listType == %@", listType)
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            
            if let existingScore = results.first {
                // Incrementa o score do tipo existente
                existingScore.score += 1
            } else {
                // Caso não exista, cria um novo
                let newScore = KanaScore(context: viewContext)
                newScore.listType = listType
                newScore.score = 1
            }
            
            // Salva as alterações no contexto
            try viewContext.save()
        } catch {
            print("Erro ao salvar o score para o tipo \(listType): \(error)")
        }
    }

}
