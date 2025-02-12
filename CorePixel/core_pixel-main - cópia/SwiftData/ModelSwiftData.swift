import SwiftUI
import SwiftData

@Model
class Desenhos {
    var titulo: String
    var criacao: Date
    var pixels: Data
    var premadeID: Int64
    
    init(titulo: String, criacao: Date, pixels: Data, premadeID: Int64) {
        self.titulo = titulo
        self.criacao = criacao
        self.pixels = pixels
        self.premadeID = premadeID
    }
}

struct Pixel: Codable {
    var linha: Int
    var coluna: Int
    var coresRGB: [CGFloat]
}

extension Color {
    func toComponents() -> [CGFloat] {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return [red, green, blue, alpha]
    }
    
    static func fromComponents(_ components: [CGFloat]) -> Color {
        Color(UIColor(red: components[0],
                     green: components[1],
                     blue: components[2],
                     alpha: components[3]))
    }
}

