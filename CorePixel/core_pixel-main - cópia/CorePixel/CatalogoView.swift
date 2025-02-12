// Ana Jamas, Andreza Marianno, Guilherme Fabbri, Heitor Ivaza
// CatalogoView //

import SwiftUI

struct CatalogoView: View {
    
    //@StateObject var viewModel: CorePixelViewModel
    var viewModelSwift: ModelSwiftData
    
    @State private var selectedGrid: [[Color]] = Array(repeating: Array(repeating: .white, count: 16), count: 16)
    
    let catalogoViewModel : CatalogoViewModel = CatalogoViewModel()
    
    let titulos = ["Coração", "Pizza", "Tomate", "Brasil"]
    
    let columns = [
        GridItem(.flexible(), spacing: 20)
        
    ]
    
    var body: some View {
        
        
            
            NavigationStack {
                
                ZStack {
                    Rectangle()
                        .foregroundStyle(
                            LinearGradient(colors: [Color(red: 0.8705882352941177, green: 0.9372549019607843, blue: 1), Color(red: 0.9490196078431372, green: 0.8588235294117647, blue: 1)], startPoint: .top, endPoint: .bottom)
                        )
                        .zIndex(1.5)
                        .ignoresSafeArea()
                
                VStack{
                    Image("CorePixel")
                        .resizable()
                        .frame(width: 500, height: 100)
                        .padding(50)
                    
                    
                    HStack{
                        
                        
                        Text("Catálogo")
                            .font(.custom("Quantico-Regular", size: 40))
                            .padding(70)
                            .padding(.top, -100)
                            .offset(x: 30)
                        
                        Spacer()
                        
                        
                    }
  
                        HStack{
                            LazyHGrid(rows: columns, spacing: 72) {
                                // trocar viewModel por  viewModelSwift
                                
                                ForEach(0..<4, id: \.self) { index in
                                    NavigationLink(destination: DesenhoView(viewModelSwift: viewModelSwift, initialGrid: selectedGrid, initialDrawing: catalogoViewModel.listaDesenhos[index], premade: true, _premadeID: index, _estaSalvo: false, _desenhoSalvoID: 0)) {
                                        VStack {
                                            MiniPixelPreview(pixels: catalogoViewModel.converterParaPixels(catalogoViewModel.listaDesenhos[index]))
                                                .frame(height: 250)
                                                .frame(width: 250)
                                                .cornerRadius(10)
                                            
                                            ZStack{

                                                  Rectangle()
                                                .frame(width: 250, height: 50)
                                                .cornerRadius(5)
                                                .foregroundColor(Color("AzulCatalogo"))
                                                .padding(.top, -20)
                                                
                                                HStack {
                                                Text(titulos[index])
                                                .font(.custom("Quantico-Regular", size: 20))
                                                .foregroundColor(.black)
                                                .padding(.leading, 20)
                                                Spacer()
                                              }
                                                .padding(.top, -20)
                                            }
                                        }
                                    }
                                }
                            } .offset(x: 73, y: -40)
                            Spacer()
                             
                        }
                    
                   
                    HStack {
                        MeusDesenhosComponente(viewModelSwift: viewModelSwift)
                            .padding(.trailing,15)
                            .navigationBarBackButtonHidden(true)

                        Spacer()

                     
                            NavigationLink(destination: DesenhoView(viewModelSwift: viewModelSwift, initialGrid: selectedGrid, initialDrawing: catalogoViewModel.listaDesenhos[4], premade: false, _premadeID: 4, _estaSalvo: false, _desenhoSalvoID: 0)) {
                                MaoLivreComponente()
                                    .frame(width: 580, height: 330)
                                    .padding(.trailing, 10)
                                    .offset(x: -35, y: 10)
                            }
                            
                        
                        .padding()
                    }
                    .padding()
                    
                    Spacer()
                }
                
                .zIndex(10)
                
            }
                // Removi o .onAppear que chamava carregarDesenho() pois o @Query já cuida disso automaticamente
               /* .onAppear {
                           viewModel.carregarDesenho()
                    
                       }*/
                
        }
            .navigationBarBackButtonHidden(true)
        
           
    }
}
