// Ana Jamas, Andreza Marianno, Guilherme Fabbri, Heitor Ivaza
// MaoLivreComponente //

import SwiftUI

struct MaoLivreComponente: View {
    var body: some View {
        
        ZStack{
          
            
            Rectangle()
                .frame(width: 580, height: 330)
                .cornerRadius(10)
                .foregroundColor(Color("AzulCatalogo"))
       
                Spacer()
                Image("pixelsAmao")
                .resizable()
                .frame(width: 580, height: 330)
     
            VStack{
                Spacer()
                HStack{
                    Text("Pintando à mão livre!")
                        .font(.custom("Quantico-Regular", size: 30))
                        .foregroundStyle(Color("BW"))
                        .frame(width: 300)
                }
            }.padding(500)
            
        }
    }
}


#Preview {
    MaoLivreComponente()
}
