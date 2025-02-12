// Ana Jamas, Andreza Marianno, Guilherme Fabbri, Heitor Ivaza
// botaoSalvarComponente //

import SwiftUI

struct botaoSalvar: View {
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 250, height: 60)
                .cornerRadius(10)
                .foregroundColor(Color("VerdeSalvar"))
              
            
            Text("Salvar")
                .foregroundStyle(Color.white)
                .bold()
                .font(.custom("Quantico-Regular", size: 30))
        }
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    botaoSalvar(action: {
        print("chama o alerta de salvar")
    })
}

