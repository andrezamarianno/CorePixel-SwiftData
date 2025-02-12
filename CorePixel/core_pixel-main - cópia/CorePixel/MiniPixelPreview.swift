// Ana Jamas, Andreza Marianno, Guilherme Fabbri, Heitor Ivaza
// MiniPixelPreview //

import SwiftUI

struct MiniPixelPreview: View {
    let pixels: [[Color]]
    
    var body: some View {
        GeometryReader { geometry in
            let pixelWidth = geometry.size.width / CGFloat(pixels.first?.count ?? 1)
            let pixelHeight = geometry.size.height / CGFloat(pixels.count)
            
            VStack(spacing: 0) {
                
                ForEach(0..<pixels.count, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<pixels[row].count, id: \.self) { col in
                            Rectangle()
                                .fill(pixels[row][col])
                                .frame(width: pixelWidth, height: pixelHeight)
                               
                        }
                    }
                }
            }
        }
    }
}
