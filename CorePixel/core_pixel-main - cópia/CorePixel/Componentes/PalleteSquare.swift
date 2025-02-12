// Ana Jamas, Andreza Marianno, Guilherme Fabbri, Heitor Ivaza
// PalleteSquare //

import SwiftUI

struct PalleteSquare: View {
    var color : Color
    @Binding var curColor: Color
   // var viewModel : CorePixelViewModel
    var viewModelSwift: ModelSwiftData
    
    var selectedSize : CGFloat = 60
    var notSelectedSize : CGFloat = 45
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: curColor == color ? selectedSize : notSelectedSize, height: curColor == color ? selectedSize : notSelectedSize)
                .foregroundColor(color)
                .onTapGesture {
                    curColor = color
                }
                .cornerRadius(5)
            
        }
    }
}

