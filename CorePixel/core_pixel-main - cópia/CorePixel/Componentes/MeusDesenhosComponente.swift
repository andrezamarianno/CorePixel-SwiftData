// Ana Jamas, Andreza Marianno, Guilherme Fabbri, Heitor Ivaza
// MeusDesenhosComponente //

import SwiftUI
import SwiftData
// importou swiftData

struct MeusDesenhosComponente: View {
    //@ObservedObject var viewModel: CorePixelViewModel

       var viewModelSwift: ModelSwiftData
    @State private var navigateToListaDeDesenhos = false
    
    let columns = [
        GridItem(.fixed(60), spacing: 30),
        GridItem(.fixed(60), spacing: 30),
        GridItem(.fixed(60), spacing: 30),
        GridItem(.fixed(60), spacing: 30),
        GridItem(.fixed(60), spacing: 30)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .frame(width: 580, height: 330)
                    .cornerRadius(10)
                    .foregroundColor(Color("fundoComp"))
                    .onTapGesture {
                    navigateToListaDeDesenhos = true
                     }
                
                VStack {
                    HStack {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(0..<15) { index in
                                // troca para viewModelSwift
                                if index < viewModelSwift.desenhos.count {
                                    let desenho = viewModelSwift.desenhos[viewModelSwift.desenhos.count - 1 - index]
                                    VStack {
                                        MiniPixelPreview(pixels: viewModelSwift.carregarPixels(from: desenho))
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(5)
                                            .onTapGesture {
                                                navigateToListaDeDesenhos = true
                                            }
                                    }
                                } else {
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(5)
                                        .opacity(0.5)
                                        .onTapGesture {
                                            navigateToListaDeDesenhos = true
                                        }
                                }
                            }
                        }
                        .frame(width: 400)
                        .padding(.leading, 150)
                        .padding(.top, 50)
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Rectangle()
                        .frame(width: 580, height: 80)
                        .cornerRadius(5)
                        .foregroundColor(Color("AzulCatalogo"))
                        .overlay(
                            HStack {
                                Text("Meus desenhos")
                                    .font(.custom("Quantico-Regular", size: 30))
                                    .foregroundStyle(Color("BW"))
                                    .padding(.leading)
                                Spacer()
                            }
                        )
                        .onTapGesture {
                        navigateToListaDeDesenhos = true
                        }
                }
            }
            // troca para viewModelSwift
            .navigationDestination(isPresented: $navigateToListaDeDesenhos) {
                ListaDeDesenhos(viewModelSwift: viewModelSwift)
            }
        }
        .navigationBarBackButtonHidden(true)
        // Removi o .onAppear que chamava carregarDesenho() pois o @Query já cuida disso automaticamente
       /* .onAppear {
                   viewModel.carregarDesenho()
            
               }*/
    }
}

/*#Preview {
    MeusDesenhosComponente(viewModel: CorePixelModel())
}*/

// container temporário apenas para preview:
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Desenhos.self, configurations: config)
    let context = container.mainContext
    
    return MeusDesenhosComponente(viewModelSwift: ModelSwiftData(modelContext: context))
        .modelContainer(container)
}
