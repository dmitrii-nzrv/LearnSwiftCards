//
//  UIExtension.swift
//  LearnSwiftCards
//
//  Created by Dmitrii Nazarov on 06.05.2025.
//

import SwiftUI

// MARK: ~ Font extensions
extension Font {
    // Chalk fonts
    static func chalkTitle() -> Font {
        .custom("Chalkboard SE", size: 22).bold()
    }
    
    static func chalkHeadline() -> Font {
        .custom("Chalkboard SE", size: 18).bold()
    }
    
    static func chalkBody() -> Font {
        .custom("Chalkboard SE", size: 16)
    }
    
    static func chalkCaption() -> Font {
        .custom("Chalkboard SE", size: 14)
    }
}

// MARK: ~ CGFloat extensions
extension CGFloat {
    static var screenWidth: Double {
        return UIScreen.main.bounds.size.width
    }
    
    static var screenHeight: Double {
        return UIScreen.main.bounds.size.height
    }
    
    static func widthPer(per: Double) -> Double {
        return screenWidth * per
    }
    
    static func heightPer(per: Double) -> Double {
        return screenHeight * per
    }
    
    static var topInsets: Double {
        return Double(getSafeAreaInsets()?.top ?? 0.0)
    }
    
    static var bottomInsets: Double {
        return Double(getSafeAreaInsets()?.bottom ?? 0.0)
    }
    
    static var horizontalInsets: Double {
        let insets = getSafeAreaInsets()
        return (insets?.left ?? 0.0) + (insets?.right ?? 0.0)
    }
    
    static var verticalInsets: Double {
        let insets = getSafeAreaInsets()
        return (insets?.top ?? 0.0) + (insets?.bottom ?? 0.0)
    }
    
    private static func getSafeAreaInsets() -> UIEdgeInsets? {
        return UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: { $0.isKeyWindow })?
            .safeAreaInsets
    }
}

// MARK: ~ Color extensions
extension Color {
     static var frontColor: Color {
        [Color.chalkboardGreen, Color.chalkboardBlue,
         Color.chalkboardRed, Color.chalkboardBlack].randomElement()!
    }
    
     static var backColor: Color {
        [Color.chalkboardGreen, Color.chalkboardBlue,
         Color.chalkboardRed, Color.chalkboardBlack].randomElement()!
    }
    
    // Chalkboard theme colors
    static var chalkboardGreen: Color {
        return Color(red: 0.1, green: 0.2, blue: 0.1)
    }
    
    static var chalkboardBlue: Color {
        return Color(red: 0.05, green: 0.05, blue: 0.2)
    }
    
    static var chalkboardRed: Color {
        return Color(red: 0.2, green: 0.1, blue: 0.1)
    }
    
    static var chalkboardBlack: Color {
        return Color(red: 0.1, green: 0.1, blue: 0.1)
    }
    
    static var woodBrown: Color {
        return Color(red: 0.6, green: 0.4, blue: 0.2)
    }
    
    static var woodDarkBrown: Color {
        return Color(red: 0.5, green: 0.3, blue: 0.1)
    }
    
    static var classroomWall: Color {
        return Color(red: 0.95, green: 0.95, blue: 0.9)
    }
    
    static var chalkWhite: Color {
        return Color.white.opacity(0.9)
    }
    
    // MARK: ~ Hex color init
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
            case 3: // RGB(12 -bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: ~ UI extensions
// Extensions for UI components
extension View {
    // Wood button style
    func woodButtonStyle() -> some View {
        self
            .font(.chalkHeadline())
            .foregroundStyle(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.woodDarkBrown)
            )
    }
    
    // Chalkboard card style
    func chalkboardStyle(color: Color? = nil) -> some View {
        let backgroundColor = color ?? [Color.chalkboardGreen,
                                        Color.chalkboardBlue,
                                        Color.chalkboardRed,
                                        Color.chalkboardBlack].randomElement()!
        
        return self
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.3), lineWidth: 2)
                    )
                    .shadow(radius: 5)
            )
    }
    
    // Notebook paper style
    func notebookPaperStyle() -> some View {
        self
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(white: 0.92))
                    .overlay(
                        // Notebook lines
                        VStack(spacing: 16) {
                            ForEach(0..<5) { _ in
                                Rectangle()
                                    .fill(Color.blue.opacity(0.1))
                                    .frame(height: 1)
                            }
                        }
                        .padding(.horizontal)
                    )
            )
    }
}

// Setup navigation bar with wood style
func setupWoodNavigationBar() {
    let woodColor = UIColor(red: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
    let appearance = UINavigationBarAppearance()
    
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = woodColor
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().compactAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
}


private var frontColor: Color {
    [Color.chalkboardGreen, Color.chalkboardBlue,
     Color.chalkboardRed, Color.chalkboardBlack].randomElement()!
}

private var backColor: Color {
    [Color.chalkboardGreen, Color.chalkboardBlue,
     Color.chalkboardRed, Color.chalkboardBlack].randomElement()!
}
