// Ana Jamas, Andreza Marianno, Guilherme Fabbri, Heitor Ivaza
// CorePixelViewModel //

/*import SwiftUI
import CoreData

class CorePixelViewModel: ObservableObject {
    @Published var desenhos: [Desenhos] = []
    private let context = PersistenceController.shared.container.viewContext
    
    func salvarDesenho(titulo: String, pixels: [[Color]], premadeID : Int64) {
        let desenhando = Desenhos(context: context)
        desenhando.titulo = titulo
        desenhando.criacao = Date()
        desenhando.premadeID = premadeID
        
  
        var pixelData: [Pixel] = []
        for (i, linha) in pixels.enumerated() {
            for (j, color) in linha.enumerated() {
                let pixel = Pixel(linha: i,
                                coluna: j,
                                coresRGB: color.toComponents())
                pixelData.append(pixel)
            }
        }
        
        if let encodedPixels = try? JSONEncoder().encode(pixelData) {
            desenhando.pixels = encodedPixels
        }
        
        try? context.save()
        carregarDesenho()
    }
    
    func editarDesenho(pixels: [[Color]], desenho: Desenhos) {
        
        var pixelData: [Pixel] = []
        for (i, linha) in pixels.enumerated() {
            for (j, color) in linha.enumerated() {
                let pixel = Pixel(linha: i,
                                coluna: j,
                                coresRGB: color.toComponents())
                pixelData.append(pixel)
            }
        }
        
        if let encodedPixels = try? JSONEncoder().encode(pixelData) {
            desenho.pixels = encodedPixels
        }
        
        do {
            try context.save()
        } catch {
            print("Erro ao editar o arquivo do CoreData.")
        }
        
        carregarDesenho()
    }
    
    func carregarDesenho() {
        let request = NSFetchRequest<Desenhos>(entityName: "Desenhos")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Desenhos.criacao, ascending: false)]
        
        desenhos = (try? context.fetch(request)) ?? []
    }
    
    func carregarPixels(from desenhando: Desenhos) -> [[Color]] {
        var grid = Array(repeating: Array(repeating: Color.white, count: 16), count: 16)
        
        if let pixelsData = desenhando.pixels,
           let pixelArray = try? JSONDecoder().decode([Pixel].self, from: pixelsData) {
            for pixel in pixelArray {
                grid[pixel.linha][pixel.coluna] = Color.fromComponents(pixel.coresRGB)
            }
        }
        
        return grid
    }
    
    func excluirDesenho(_ desenhando: Desenhos) {
        context.delete(desenhando)
        try? context.save()
        carregarDesenho()
    }
    
    func getColorID(_color : Color) -> Int{
        switch(_color){
            
        case Color.white:
            return -1
            
        case Color.black:
            return 0
            
        case Color.red:
            return 1
            
        case Color.blue:
            return 2
            
        case Color.yellow:
            return 3
            
        case Color.orange:
            return 4
            
        case Color.green:
            return 5
            
        case Color.purple:
            return 6
            
        default:
            return 99
        }
    }
    
    func getIDColor(_id : Int) -> Color{
        switch(_id){
            
        case -1:
            return Color.white
        
        case 0:
            return Color.black
            
        case 1:
            return Color.red
            
        case 2:
            return Color.blue
            
        case 3:
            return Color.yellow
            
        case 4:
            return Color.orange
            
        case 5:
            return Color.green
            
        case 6:
            return Color.purple
        
        default:
            return Color.white
        }
    }
}
*/
