import SwiftUI
import SwiftData

@Observable
class ModelSwiftData {
    private var modelContext: ModelContext
    var desenhos: [Desenhos] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchDesenhos()
    }
    private func fetchDesenhos() {
            let descriptor = FetchDescriptor<Desenhos>(sortBy: [SortDescriptor(\.criacao, order: .reverse)])
            desenhos = (try? modelContext.fetch(descriptor)) ?? []
        }
    
    func salvarDesenho(titulo: String, pixels: [[Color]], premadeID: Int64) {
        let pixelData = encodePixels(pixels)
        let desenho = Desenhos(titulo: titulo, criacao: Date(), pixels: pixelData, premadeID: premadeID)
        modelContext.insert(desenho)
        try? modelContext.save()
        fetchDesenhos()
    }
    
    func editarDesenho(pixels: [[Color]], desenho: Desenhos) {
        desenho.pixels = encodePixels(pixels)
        try? modelContext.save()
        fetchDesenhos()
    }
    
    func carregarPixels(from desenho: Desenhos) -> [[Color]] {
        var grid = Array(repeating: Array(repeating: Color.white, count: 16), count: 16)
        
        if let pixelArray = try? JSONDecoder().decode([Pixel].self, from: desenho.pixels) {
            for pixel in pixelArray {
                grid[pixel.linha][pixel.coluna] = Color.fromComponents(pixel.coresRGB)
            }
        }
        
        return grid
    }
    
    func excluirDesenho(_ desenho: Desenhos) {
        modelContext.delete(desenho)
        try? modelContext.save()
        fetchDesenhos()
    }
    
    private func encodePixels(_ pixels: [[Color]]) -> Data {
        var pixelData: [Pixel] = []
        for (i, linha) in pixels.enumerated() {
            for (j, color) in linha.enumerated() {
                let pixel = Pixel(linha: i,
                                coluna: j,
                                coresRGB: color.toComponents())
                pixelData.append(pixel)
            }
        }
        
        return (try? JSONEncoder().encode(pixelData)) ?? Data()
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

