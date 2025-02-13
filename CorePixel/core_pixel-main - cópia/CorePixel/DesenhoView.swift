// Ana Jamas, Andreza Marianno, Guilherme Fabbri, Heitor Ivaza
// DesenhoView //

import SwiftUI

struct DesenhoView: View {
    
    @State var curColor: Color = .black
    
    @State var gridColors: [[Color]] = Array(repeating: Array(repeating: .white, count: 16), count: 16)
    @State var previousGridColors: [Pixel] = []
    @State var redoGridColors: [Pixel] = []

    @State var gridNumbers: [[Int]]
    
    @State var cleaned : Bool = false
    @State var cleanedDrawing : [Pixel] = []

    
    var colorPalette : [Color] = [Color.white, Color.black, Color.red, Color.blue, Color.yellow, Color.orange, Color.green, Color.purple]
    
    @State var painting: Bool = false
    
    var premadeDrawing : Bool = true
    var premadeID : Int
    @State var locked: Bool = false
    
    @State var desenhoSalvoAlerta : Bool = false
    
    @State var desenhoAlterado : Bool = false
    @State var desenhoAlteradoAlerta : Bool = false
    
    
    var estaSalvo : Bool
    var desenhoSalvoID : Int
    
    let squareSize: CGFloat = 40
    
    @State private var tituloDesenho = ""
    @State private var mostrarAlertaSalvar = false
    
    
    // @ObservedObject var viewModelSwift = CorePixelViewModel()
    var viewModelSwift: ModelSwiftData
    @Environment(\.dismiss) private var dismiss
    // aplica a viewModelSwift
    init(viewModelSwift: ModelSwiftData, initialGrid: [[Color]], initialDrawing: [[Int]], premade : Bool, _premadeID : Int, _estaSalvo : Bool, _desenhoSalvoID : Int) {
            self.viewModelSwift = viewModelSwift
            _gridColors = State(initialValue: initialGrid)
            _gridNumbers = State(initialValue: initialDrawing)
            premadeDrawing = premade
            premadeID = _premadeID
            estaSalvo = _estaSalvo
            desenhoSalvoID = _desenhoSalvoID
 
        }
    
    var body: some View {
        ZStack {
         
            
            HStack {
                
                VStack {
                    
                    Spacer()
                        .frame(height: 50)
                    HStack {
                        Spacer()
                            .frame(width: 80)
                        Button(action: {
                            if(desenhoAlterado){
                                desenhoAlteradoAlerta.toggle()
                            }else{
                                dismiss()
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .font(.system(size: 30, weight: .bold))
                        }
                    }
                   
                    Spacer()
                    .zIndex(99)
                }
                
               
                    
                    Spacer()
                    
                    VStack {
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 105, height: 400)
                                .foregroundColor(Color.azulToolBar.opacity(0.75))
                                .cornerRadius(6)
                                .padding(.trailing, 50)
                            
                            VStack (spacing: 30){
                                
                                Button {
                                    locked.toggle()
                                } label: {
                                    VStack {
                                        Image(locked == false ? "lockOpen" : "lockClosed")
                                        Text(locked == false ? "Não sobrepor" : "Sobrepor")
                                            .foregroundColor(.black)
                                            .font(.custom("Quantico-Regular", size: 15))
                                    }
                                }
                                
                                Button {
                                    
                                } label: {
                                    VStack {
                                        Image("desfazer")
                                            .opacity(previousGridColors.count > 0 || cleaned ? 1 : 0.3)
                                        Text("Desfazer")
                                            .foregroundColor(previousGridColors.count > 0 || cleaned ? .black : .gray)
                                            .font(.custom("Quantico-Regular", size: 15))
                                    }
                                }.disabled(previousGridColors.count > 0 || cleaned ? false : true)
                                    .simultaneousGesture(
                                        LongPressGesture(minimumDuration: 0.5)
                                            .onEnded {_ in
                                                if(previousGridColors.count > 10)
                                                {
                                                    for _ in 1...10 {
                                                        let _pixel = previousGridColors[previousGridColors.count - 1]
                                                        saveRedoAction(_pixel: Pixel(linha: _pixel.linha, coluna: _pixel.coluna, coresRGB: gridColors[_pixel.linha][_pixel.coluna].toComponents()))
                                                                       
                                                        gridColors[_pixel.linha][_pixel.coluna] = Color.fromComponents(_pixel.coresRGB)
                                                        
                                                        previousGridColors.remove(at: previousGridColors.count - 1)
                                                    }
                                                }
                                                else
                                                {
                                                    for _ in 1...previousGridColors.count {
                                                        let _pixel = previousGridColors[previousGridColors.count - 1]
                                                        
                                                        saveRedoAction(_pixel: Pixel(linha: _pixel.linha, coluna: _pixel.coluna, coresRGB: gridColors[_pixel.linha][_pixel.coluna].toComponents()))
                                                        
                                                        gridColors[_pixel.linha][_pixel.coluna] = Color.fromComponents(_pixel.coresRGB)
                                                        
                                                        previousGridColors.remove(at: previousGridColors.count - 1)
                                                    }
                                                }
                                            }
                                    ).highPriorityGesture(
                                        TapGesture()
                                            .onEnded {
                                                if(cleaned)
                                                {
                                                    for i in 0..<cleanedDrawing.count{
                                                        let _pixel = cleanedDrawing[i]
                                                        gridColors[_pixel.linha][_pixel.coluna] = Color.fromComponents(_pixel.coresRGB)
                                                    }
                                                    
                                                    cleaned = false
                                                    cleanedDrawing.removeAll()
                                                }
                                                
                                                if(previousGridColors.count > 0)
                                                {
                                                    let _pixel = previousGridColors[previousGridColors.count - 1]
                                                    
                                                    saveRedoAction(_pixel: Pixel(linha: _pixel.linha, coluna: _pixel.coluna, coresRGB: gridColors[_pixel.linha][_pixel.coluna].toComponents()))
                                                    
                                                    gridColors[_pixel.linha][_pixel.coluna] = Color.fromComponents(_pixel.coresRGB)
                                                    
                                                    
                                                    previousGridColors.remove(at: previousGridColors.count - 1)
                                                }
                                            }
                                    )
                                
                                Button(){
                                    
                                    if(redoGridColors.count > 0)
                                    {
                                        let _pixel = redoGridColors[redoGridColors.count - 1]
                                        
                                        savePreviousAction(_pixel: Pixel(linha: _pixel.linha, coluna: _pixel.coluna, coresRGB: gridColors[_pixel.linha][_pixel.coluna].toComponents()))
                                        
                                        gridColors[_pixel.linha][_pixel.coluna] = Color.fromComponents(_pixel.coresRGB)
                                        
                                        redoGridColors.remove(at: redoGridColors.count - 1)

                                    }
                                    
                                } label: {
                                    VStack {
                                        Image("Refazer")
                                            .opacity(redoGridColors.count > 0 ? 1 : 0.3)
                                        Text("Refazer")
                                            .foregroundColor(redoGridColors.count > 0 ? .black : .gray)
                                            .font(.custom("Quantico-Regular", size: 15))
                                    }
                                }.disabled(redoGridColors.count > 0 ? false : true)
                                
                                
                                Spacer()
                                
                                Button("Limpar") {
                                    
                                    if(!cleaned)
                                    {
                                        cleaned = true;
                                        for i in 0..<gridColors.count {
                                            for j in 0..<gridColors.count {
                                                
                                                if(gridColors[i][j] != Color.white){
                                                    cleanedDrawing.append(Pixel(linha: i, coluna: j, coresRGB: gridColors[i][j].toComponents()))
                                                }
                                                
                                            }
                                        }
                                    }
                                    
                                    gridColors = Array(repeating: Array(repeating: .white, count: 16), count: 16)
                                    
                                }.foregroundColor(Color.red)
                                    .font(.custom("Quantico-Regular", size: 18))
                            }.padding(.trailing, 50)
                                .frame(height: 335)
                        }
                        
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            
                            botaoSalvar(action: {
                                
                                if(!estaSalvo){
                                    mostrarAlertaSalvar = true
                                } else {
                                    viewModelSwift.editarDesenho(pixels: gridColors, desenho: viewModelSwift.desenhos[desenhoSalvoID])
                                    desenhoSalvoAlerta = true
                                }
                                
                            })
                            
                        }
                        .padding(.leading, 400)
                        
                        GeometryReader { geometry in
                            VStack {
                                ForEach(0..<16, id: \.self) { i in
                                    HStack {
                                        ForEach(0..<16, id: \.self) { j in
                                            SquareComponent(corParaPintar: $curColor,
                                                            posicao: (linha: i, coluna: j),
                                                            pixelGrid: $gridColors, numberGrid: $gridNumbers, viewModelSwift: viewModelSwift)
                                            .frame(width: squareSize, height: squareSize)
                                            .border(Color.gray, width: 0.3)
                                            .padding(-3.95)
                                        }
                                    }
                                }
                            }
                            .gesture(
                                
                                DragGesture(minimumDistance: 0)
                                    .onChanged { value in
                                        painting = true
                                        let location = value.location
                                        let column = Int(location.x / squareSize)
                                        let row = Int(location.y / squareSize)
                                        
                                        if row >= 0, row < 16, column >= 0, column < 16 {
                                            
                                            if(!desenhoAlterado){
                                                desenhoAlterado = true
                                            }
                                            
                                            if locked == true {
                                                if gridColors[row][column] == Color.white {
                                                    if(!premadeDrawing){
                                                        savePreviousAction(_pixel: Pixel(linha: row, coluna: column, coresRGB: Color.white.toComponents()))
                                                        gridColors[row][column] = curColor
                                                        
                                                        cleanActions()
                                                    } else {
                                                        if(viewModelSwift.getColorID(_color: curColor) == gridNumbers[row][column])
                                                        {
                                                            savePreviousAction(_pixel: Pixel(linha: row, coluna: column, coresRGB: Color.white.toComponents()))
                                                            gridColors[row][column] = curColor
                                                            
                                                            cleanActions()
                                                        }
                                                    }
                                                }
                                            } else {
                                                if(!premadeDrawing){
                                                    savePreviousAction(_pixel: Pixel(linha: row, coluna: column, coresRGB: gridColors[row][column].toComponents()))
                                                    gridColors[row][column] = curColor
                                                    
                                                    cleanActions()
                                                } else {
                                                    if(viewModelSwift.getColorID(_color: curColor) == gridNumbers[row][column])
                                                    {
                                                        savePreviousAction(_pixel: Pixel(linha: row, coluna: column, coresRGB: gridColors[row][column].toComponents()))
                                                        gridColors[row][column] = curColor
                                                        
                                                        cleanActions()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .onEnded { _ in
                                        painting = false
                                    }
                            )
                        }
                        .frame(width: squareSize * 16, height: squareSize * 16)
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 550, height: 105)
                                .foregroundColor(Color.azulToolBar.opacity(0.75))
                                .cornerRadius(6)
                            
                            HStack {
                                ForEach(0..<colorPalette.count){ i in
                                    PalleteSquare(color: colorPalette[i], curColor: $curColor, viewModelSwift: viewModelSwift)
                                        .overlay {
                                            if(viewModelSwift.getColorID(_color: colorPalette[i]) != -1){
                                                Text("\(viewModelSwift.getColorID(_color: colorPalette[i]))")
                                                    .foregroundStyle(viewModelSwift.getColorID(_color: colorPalette[i]) == 0 ? Color.white : Color.black)
                                                    .font(.custom("Quantico-Regular", size: 16))
                                            }
                                            
                                        }.padding(.horizontal, 5)
                                    
                                }
                                
                            }.frame(width: 505)
                            
                        }.padding(.top, 30)
                        Spacer()
                    }
                    .alert("Salvar Desenho", isPresented: $mostrarAlertaSalvar) {
                        TextField("Título do desenho", text: $tituloDesenho)
                        Button("Cancelar", role: .cancel) {}
                        Button("Salvar") {
                            viewModelSwift.salvarDesenho(titulo: tituloDesenho, pixels: gridColors, premadeID: Int64(premadeID))
                            tituloDesenho = ""
                            dismiss()
                        }
                    }
                    .alert("Desenho salvo", isPresented: $desenhoSalvoAlerta) {
                        Button("OK", role: .cancel) {
                            dismiss()
                        }
                    }
                    .alert("Tem certeza que deseja voltar? As alterações não salvas serão perdidas.", isPresented: $desenhoAlteradoAlerta){
                        Button("Cancelar", role: .cancel) {}
                        Button("Voltar", role: .destructive) {
                            dismiss()
                        }
                    }
                    .onAppear(){
                        previousGridColors.removeAll()
                    }
                    
                    .navigationBarBackButtonHidden(true)
                    
                    Spacer()
                }.padding(.trailing, 125)
            }
        }
    
    
    func savePreviousAction(_pixel : Pixel){
        
        if(previousGridColors.count >= 50)
        {
            previousGridColors.remove(at: 0)
        }
        
        if(previousGridColors.count > 0){
            var lastPixel = previousGridColors[previousGridColors.count - 1]
            if(lastPixel.coluna != _pixel.coluna || lastPixel.linha != _pixel.linha){
                previousGridColors.append(_pixel)
            }
        }
        else
        {
            previousGridColors.append(_pixel)
        }
    }
    
    func saveRedoAction(_pixel: Pixel){
        
        if(redoGridColors.count >= 50){
            redoGridColors.remove(at: 0)
        }

        redoGridColors.append(_pixel)
    }
    
    func cleanActions(){
        if(cleaned){
            previousGridColors.removeAll()
            
            cleaned = false
            cleanedDrawing.removeAll()
        }
        
        redoGridColors.removeAll()
    }
}

