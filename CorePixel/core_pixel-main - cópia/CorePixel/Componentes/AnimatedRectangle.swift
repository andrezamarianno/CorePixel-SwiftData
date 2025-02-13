import SwiftUI

struct AnimatedRectangle: View {
    @State private var changeColor = false
    @State private var isVisible = true
    var changeTime: Double
    var initialColor: Color
    var finalColor: Color
    var squareZIndex: Double

    var body: some View {
        if isVisible {
            Rectangle()
                .fill(changeColor ? finalColor : initialColor)
                .frame(width: 60, height: 60)
                .zIndex(squareZIndex)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + changeTime) {
                        withAnimation {
                            changeColor = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.4) {
                        withAnimation {
                            isVisible = false
                        }
                    }
                }
                .padding()
        }
    }
}

#Preview {
    AnimatedRectangle(changeTime: 1, initialColor: Color.gray, finalColor: Color.pink, squareZIndex: 1)
}
