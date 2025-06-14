import SwiftUI

struct WoodenSurface: View {
    var body: some View {
        Rectangle()
            .fill(Color.woodBrown)
            .frame(height: 60)
            .overlay(
                Rectangle()
                    .fill(Color(red: 0.65, green: 0.45, blue: 0.25))
                    .frame(height: 5)
                    .offset(y: -20)
            )
            .overlay(
                // Wood grain
                ForEach(0..<5) { i in
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: CGFloat(i) * 12))
                        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: CGFloat(i) * 12 + 5))
                    }
                    .stroke(Color(red: 0.55, green: 0.35, blue: 0.15), lineWidth: 0.5)
                }
            )
    }
} 

#Preview {
    WoodenSurface()
}
