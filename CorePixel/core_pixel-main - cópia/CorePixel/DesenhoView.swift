// Ana Jamas, Andreza Marianno, Guilherme Fabbri, Heitor Ivaza
// DesenhoView //

import SwiftUI

struct DesenhoView: View {
    
    @State var curColor: Color = .black
    @State var gridColors: [[Color]] = Array(repeating: Array(repeating: .white, count: 16), count: 16)
    @State var previousGridColors: [[[Color]]] = [[[]]]
    @State var gridNumbers: [[Int]]
    var colorPalette : [Color] = [Color.white, Color.black, Color.red, Color.blue, Color.yellow, Color.orange, Color.green, Color.purple]
    
@State var painting: Bool = false
    
    var premadeDrawing : Bool = true
    var premadeID : Int
    @State var locked: Bool = false
    
    @State var desenhoSalvoAlerta : Bool = false
    
    var estaSalvo : Bool
    var desenhoSalvoID : Int
    
    let squareSize: CGFloat = 40
    
    @State private var tituloDesenho = ""
    @State private var mostrarAlertaSalvar = false
    
    
   // @ObservedObject var viewModel = CorePixelViewModel()
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
                            dismiss()
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
                                        Text(locked == false ? "Bloquear" : "Desbloquear")
                                            .foregroundColor(.black)
                                            .font(.custom("Quantico-Regular", size: 15))
                                    }
                                }
                                
                                Button {
                                    if(previousGridColors.count > 0){
                                        if(previousGridColors[0] != [[]]){
                                            gridColors = previousGridColors[0]
                                            previousGridColors.removeAll()
                                        }
                                    }
                                } label: {
                                    VStack {
                                        Image("desfazer")
                                            .opacity(previousGridColors.count > 0 ? 1 : 0.3)
                                        Text("Desfazer")
                                            .foregroundColor(previousGridColors.count > 0 ? .black : .gray)
                                            .font(.custom("Quantico-Regular", size: 15))
                                    }
                                }.disabled(previousGridColors.count > 0 ? false : true)
                                
                                
                                Spacer()
                                
                                Button("Apagar") {
                                    savePreviousAction()
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
                                    //troca para viewModelSwift
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
                                        //troca para viewModelSwift
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
                                            if locked == true {
                                                if gridColors[row][column] == Color.white {
                                                    if(!premadeDrawing){
                                                        savePreviousAction()
                                                        gridColors[row][column] = curColor
                                                    } else {
                                                        //troca para viewModelSwift
                                                        if(viewModelSwift.getColorID(_color: curColor) == gridNumbers[row][column])
                                                        {
                                                            savePreviousAction()
                                                            gridColors[row][column] = curColor
                                                        }
                                                    }
                                                }
                                            } else {
                                                if(!premadeDrawing){
                                                    savePreviousAction()
                                                    gridColors[row][column] = curColor
                                                } else {
                                                    // troca para viewModelSwift
                                                    if(viewModelSwift.getColorID(_color: curColor) == gridNumbers[row][column])
                                                    {
                                                        savePreviousAction()
                                                        gridColors[row][column] = curColor
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
                                    // troca para viewModelSwift
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
                            // troca para viewModelSwift
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
                    .onAppear(){
                        previousGridColors.removeAll()
                    }
                    
                    .navigationBarBackButtonHidden(true)
                    
                    Spacer()
                }.padding(.trailing, 125)
            }
        }
    
    
    func savePreviousAction(){
        if(previousGridColors.count == 0){
            previousGridColors.append(gridColors)
        } else {
            if(previousGridColors[previousGridColors.count - 1] != gridColors){
                previousGridColors.append(gridColors)
            }
        }
        if(previousGridColors.count > 2){
            previousGridColors.remove(at: 0)
        }
    }
}

