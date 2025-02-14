// Ana Jamas, Andreza Marianno, Guilherme Fabbri, Heitor Ivaza
// AboutView //


import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Sobre o Aplicativo")
                    .font(.largeTitle)
                    .bold()
                
                Text("Feito por: Ana Jamas, Andreza Marianno, Guilherme Fabbri, Heitor Lopes")
                
            }
            
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Termos de Uso - CorePixel")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)
                
                Text("Última atualização: 12/02/2025")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                SectionHeader(title: "1. Aceitação dos Termos")
                Text("Ao acessar e utilizar o CorePixel, você concorda com os termos descritos neste documento. Se não concordar com qualquer parte, recomendamos que não utilize o aplicativo.")
                
                SectionHeader(title: "2. Coleta e Armazenamento de Dados")
                Text("O CorePixel armazena as seguintes informações relacionadas aos seus desenhos:")
                BulletPointList(items: [
                    "O desenho criado por você;",
                    "O título do desenho definido por você;",
                    "A data de criação do desenho."
                ])
                Text("Esses dados são armazenados para que você possa acessá-los posteriormente e gerenciar seus desenhos de maneira eficiente.")
                
                SectionHeader(title: "3. Uso do Aplicativo")
                Text("O usuário se compromete a:")
                BulletPointList(items: [
                    "Não utilizar o CorePixel para criar ou armazenar conteúdos ofensivos, ilegais ou que violem direitos de terceiros;",
                    "Respeitar as diretrizes de uso e não comprometer o funcionamento do aplicativo;",
                    "Garantir que possui os direitos necessários sobre os conteúdos que criar e armazenar no CorePixel."
                ])
                
                SectionHeader(title: "4. Direitos e Responsabilidades")
                Text("O CorePixel se reserva o direito de:")
                BulletPointList(items: [
                    "Alterar ou remover conteúdos que violem estes termos;",
                    "Suspender ou encerrar contas que desrespeitem nossas diretrizes;",
                    "Modificar os Termos de Uso conforme necessário, com aviso prévio aos usuários."
                ])
                
                SectionHeader(title: "5. Segurança e Privacidade")
                Text("Tomamos medidas para proteger seus dados, mas não garantimos segurança absoluta contra acessos não autorizados. Recomendamos que você utilize senhas seguras e proteja seu dispositivo.")
                
                SectionHeader(title: "6. Alterações nos Termos de Uso")
                Text("Podemos atualizar este documento periodicamente. Notificaremos os usuários sobre alterações significativas. O uso contínuo do CorePixel após as alterações implica na aceitação dos novos termos.")
                
                SectionHeader(title: "7. Contato")
                Text("Caso tenha dúvidas sobre estes Termos de Uso, entre em contato conosco pelo e-mail: guilherme.ffabbri@senacsp.edu.br")
                
                Text("Obrigado por utilizar o CorePixel!")
                    .bold()
                    .padding(.top, 10)
                
                Text("Equipe CorePixel")
                    .italic()
                    .foregroundColor(.gray)
            }
            .padding()
            
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Política de Privacidade - CorePixel")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)
                
                Text("Última atualização: 12/02/2025")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                SectionHeader(title: "1. Introdução")
                Text("Sua privacidade é importante para nós. Esta Política de Privacidade explica como coletamos, usamos e protegemos suas informações ao utilizar o CorePixel.")
                
                SectionHeader(title: "2. Informações Coletadas")
                BulletPointList(items: [
                    "Desenhos criados no aplicativo;",
                    "Títulos dos desenhos definidos por você;",
                    "Datas de criação dos desenhos."
                ])
                
                SectionHeader(title: "3. Uso das Informações")
                Text("As informações coletadas são utilizadas para:")
                BulletPointList(items: [
                    "Salvar e gerenciar seus desenhos dentro do aplicativo;",
                    "Melhorar a experiência do usuário;",
                    "Garantir a funcionalidade do CorePixel."
                ])
                
                SectionHeader(title: "4. Compartilhamento de Dados")
                Text("O CorePixel não compartilha seus dados pessoais com terceiros, exceto quando exigido por lei ou para garantir a segurança do aplicativo.")
                
                SectionHeader(title: "5. Segurança")
                Text("Adotamos medidas para proteger suas informações, mas não podemos garantir segurança absoluta. Recomendamos o uso de senhas fortes e proteção do seu dispositivo.")
                
                SectionHeader(title: "6. Alterações na Política de Privacidade")
                Text("Podemos atualizar esta Política de Privacidade periodicamente. Caso haja mudanças significativas, informaremos os usuários para que possam revisar as atualizações.")
                
                SectionHeader(title: "7. Contato")
                Text("Se tiver dúvidas sobre nossa Política de Privacidade, entre em contato pelo e-mail: guilherme.ffabbri@senacsp.edu.br")
                
                Text("Equipe CorePixel")
                    .italic()
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .navigationTitle("Termos de Uso")
    }
}



struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .bold()
            .padding(.top, 10)
    }
}

struct BulletPointList: View {
    let items: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(items, id: \..self) { item in
                HStack(alignment: .top) {
                    Text("•")
                    Text(item)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
