import Foundation

class DataStore {
    static var hiraganaList: [Kana] = []
    static var katakanaList: [Kana] = []
    static var mixedList: [Kana] = []

    static func loadKanas() {
        hiraganaList = loadJson(fileName: "hiragana.json")
        katakanaList = loadJson(fileName: "katakana.json")
        mixedList = hiraganaList + katakanaList
    }

    private static func loadJson(fileName: String) -> [Kana] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            print("Arquivo \(fileName) não encontrado.")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let kanaList = try JSONDecoder().decode([Kana].self, from: data)
            return kanaList
        } catch {
            print("Erro ao carregar o arquivo JSON: \(error)")
            return []
        }
    }

    static func getKana(listType: String, position: Int) -> Kana {
        switch listType {
        case "hiragana":
            guard position < hiraganaList.count else { fatalError("Índice fora do limite.") }
            return hiraganaList[position]
        case "katakana":
            guard position < katakanaList.count else { fatalError("Índice fora do limite.") }
            return katakanaList[position]
        case "mixed":
            guard position < mixedList.count else { fatalError("Índice fora do limite.") }
            return mixedList[position]
        default:
            fatalError("Tipo de lista inválido")
        }
    }

    static func getSize(listType: String) -> Int {
        switch listType {
        case "hiragana":
            return hiraganaList.count
        case "katakana":
            return katakanaList.count
        case "mixed":
            return mixedList.count
        default:
            fatalError("Tipo de lista inválido")
        }
    }
}
