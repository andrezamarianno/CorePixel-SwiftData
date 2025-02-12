// Ana Jamas, Andreza Marianno, Guilherme Fabbri, Heitor Ivaza
// CorePixelModel //


/* Crie uma entidade chamada "Desenhos", com os atributos:
    - criacao: date
    - pixels: binary data
    - premadeID: int64
    - titulo: string
    

import SwiftUI
import CoreData

struct Pixel: Codable {
    var linha: Int
    var coluna: Int
    var coresRGB: [CGFloat]
}

class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "PixelArtModel")
        
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
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
*/

