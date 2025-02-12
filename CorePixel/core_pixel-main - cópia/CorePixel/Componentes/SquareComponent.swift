// Ana Jamas, Andreza Marianno, Guilherme Fabbri, Heitor Ivaza
// SquareComponent //

import SwiftUI

struct SquareComponent: View {
    @Binding var corParaPintar: Color
    let posicao: (linha: Int, coluna: Int)
    @Binding var pixelGrid: [[Color]]
    @Binding var numberGrid : [[Int]]
    
  //  var viewModel : CorePixelViewModel
    var viewModelSwift: ModelSwiftData
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 40, height: 40)
                .padding(-3.95)
                .foregroundColor(pixelGrid[posicao.linha][posicao.coluna])
            
            //inseriu viewModelSwift dentro de if
            if(viewModelSwift.getColorID(_color: pixelGrid[posicao.linha][posicao.coluna]) != numberGrid[posicao.linha][posicao.coluna]){
                Text(numberGrid[posicao.linha][posicao.coluna] != -1 ? String(numberGrid[posicao.linha][posicao.coluna]) : "")
                    .foregroundColor(Color.black.opacity(0.5))
                    .font(.custom("Quantico-Regular", size: 15))
            }
            
        }
    }

}
