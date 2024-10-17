import Foundation

class DataStore {
    static var hiraganaList: [Kana] = []
    static var katakanaList: [Kana] = []
    static var mixedList: [Kana] = []

    static func loadKanas() {
        hiraganaList = loadJson(fileName: "hiragana.json")
        katakanaList = loadJson(fileName: "katakana.json")
        mixedList = hiraganaList + katakanaList // Adiciona as duas listas
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
            return hiraganaList[position]
        case "katakana":
            return katakanaList[position]
        case "mixed":
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
