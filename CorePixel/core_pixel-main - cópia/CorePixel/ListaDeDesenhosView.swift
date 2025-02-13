// Ana Jamas, Andreza Marianno, Guilherme Fabbri, Heitor Ivaza
// ListaDeDesenhos //

import SwiftUI
//import CoreData
import SwiftData

struct ListaDeDesenhos: View {
   // @ObservedObject var viewModel: CorePixelViewModel
   
       var viewModelSwift: ModelSwiftData
    @State private var vaiParaContent = false
    @State private var selectedGrid: [[Color]]?
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter
    }

    var catalogoViewModel : CatalogoViewModel = CatalogoViewModel()

    @Environment(\.dismiss) var dismiss
    @State var isPremade : Bool = false
    @State var premadeID : Int64 = 0
    
    @State var desenhoSalvoID : Int = 0
    
    @State var apagarDesenhoAlerta : Bool = false
 
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundStyle(
                    LinearGradient(colors: [Color(red: 0.8705882352941177, green: 0.9372549019607843, blue: 1), Color(red: 0.9490196078431372, green: 0.8588235294117647, blue: 1)], startPoint: .top, endPoint: .bottom)
                )
                .zIndex(1.5)
                .ignoresSafeArea()
            
            
            
            VStack {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .font(.system(size: 30, weight: .bold))
                        }
                        .padding(.leading, 20)
                        
                        Text("Meus desenhos")
                            .bold()
                            .font(.custom("Quantico-Regular", size: 30))
                            .padding(50)
                        Spacer()
                    }
                    Spacer()
                }
                .zIndex(5.0)
            
            
            
            
            
            NavigationStack {
                Spacer()
                    .frame(height: 100)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 70) {
                        
                       
                        ForEach(viewModelSwift.desenhos) { desenhando in
                            ZStack {
                                
                                VStack {
                                    MiniPixelPreview(pixels: viewModelSwift.carregarPixels(from: desenhando))
                                        .frame(height: 400)
                                        .frame(width: 400)
                                        .cornerRadius(10)
                                    
                                    
                                    ZStack {
                                        
                                        Rectangle()
                                            .frame(width: 400, height: 80)
                                            .cornerRadius(5)
                                            .foregroundColor(Color("AzulCatalogo"))
                                            .padding(.top, -35)
                                        VStack{
                                            HStack{
                                                Text(desenhando.titulo ?? "Sem título")
                                                    .font(.custom("Quantico-Regular", size: 25))
                                                    .padding(.horizontal, 20)
                                                
                                                
                                                Text(desenhando.criacao ?? Date(), formatter: dateFormatter)
                                                    .font(.custom("Quantico-Regular", size: 25))
                                                    .foregroundColor(.secondary)
                                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                                    .padding(.trailing, 20)
                                                
                                            }
                                        }
                                        .padding(.top, -32)
                                        Spacer()
                                        
                                    }
                                    .padding(.horizontal, 20)
                                }
                                
                                Button(){
                                    apagarDesenhoAlerta.toggle()
                                    
                                    for i in 0..<viewModelSwift.desenhos.count{
                                        if(desenhando == viewModelSwift.desenhos[i]){
                                            desenhoSalvoID = i
                                        }
                                    }
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.white.opacity(0.6))
                                            .cornerRadius(4)
                                        
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }.font(.title)
                                    .padding(.leading, 325)
                                    .padding(.bottom, 380)
                            }
                            .onTapGesture {
                                selectedGrid = viewModelSwift.carregarPixels(from: desenhando)
                                vaiParaContent = true
                                premadeID = desenhando.premadeID
                                if(premadeID == 0 || premadeID == 1 || premadeID == 2){
                                    isPremade = true
                                } else {
                                    isPremade = false
                                }
                                
                                for i in 0..<viewModelSwift.desenhos.count{
                                    if(desenhando == viewModelSwift.desenhos[i]){
                                        desenhoSalvoID = i
                                    }
                                }
                            }
                            
                        }
                    }
                    .padding()
                    
                    
                }
                
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $vaiParaContent) {
                if let grid = selectedGrid {
                    DesenhoView(viewModelSwift: viewModelSwift, initialGrid: grid, initialDrawing: catalogoViewModel.listaDesenhos[Int(premadeID)], premade: isPremade, _premadeID: 3, _estaSalvo: true, _desenhoSalvoID: desenhoSalvoID)
                       // .navigationBarBackButtonHidden(true)
                }
            }
            // Removi o .onAppear que chamava carregarDesenho() pois o fetchDesenhos já cuida disso automaticamente
           /* .onAppear {
                       viewModel.carregarDesenho()
                
                   }*/
            .alert("Deseja apagar o desenho? \nEle será excluído permanentemente!", isPresented: $apagarDesenhoAlerta) {
                Button("Cancelar", role: .cancel) {
                    
                }
                Button("Apagar", role: .destructive) {
                    viewModelSwift.excluirDesenho(viewModelSwift.desenhos[desenhoSalvoID])
                }
            }
            
            .zIndex(10)
        }
        
    }
}

