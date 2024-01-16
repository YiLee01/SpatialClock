import SwiftUI

enum 💾Option {
    enum FontWeight: String, CaseIterable, Identifiable {
        case ultraLight, thin, light, regular, medium, semibold, bold, heavy, black
        var id: Self { self }
        var value: Font.Weight {
            switch self {
                case .ultraLight: .ultraLight
                case .thin: .thin
                case .light: .light
                case .regular: .regular
                case .medium: .medium
                case .semibold: .semibold
                case .bold: .bold
                case .heavy: .heavy
                case .black: .black
            }
        }
        var label: LocalizedStringKey {
            switch self {
                case .ultraLight: "ultraLight"
                case .thin: "thin"
                case .light: "light"
                case .regular: "regular"
                case .medium: "medium"
                case .semibold: "semibold"
                case .bold: "bold"
                case .heavy: "heavy"
                case .black: "black"
            }
        }
    }
    enum FontDesign: String, CaseIterable, Identifiable {
        case `default`, serif, rounded, monospaced
        var id: Self { self }
        var value: Font.Design {
            switch self {
                case .default: .default
                case .serif: .serif
                case .rounded: .rounded
                case .monospaced: .monospaced
            }
        }
        var label: LocalizedStringKey {
            switch self {
                case .default: "default"
                case .serif: "serif"
                case .rounded: "rounded"
                case .monospaced: "monospaced"
            }
        }
    }
    struct Animation: ViewModifier {
        @EnvironmentObject var model: 📱AppModel
        var value: Date
        func body(content: Content) -> some View {
            switch self.model.animation {
                case .default:
                    content
                        .animation(.default, value: self.value)
                case .cool:
                    content
                        .contentTransition(.numericText())
                        .animation(.default, value: self.value)
                case .disable:
                    content
            }
        }
        enum Case: String, CaseIterable, Identifiable {
            case `default`, cool, disable
            var id: Self { self }
            var label: LocalizedStringKey {
                switch self {
                    case .default: "default"
                    case .cool: "cool"
                    case .disable: "disable"
                }
            }
        }
    }
    static func load() -> Color {
        if let ⓓata = UserDefaults.standard.data(forKey: 💾Key.textColor),
           let ⓜodel = try? JSONDecoder().decode(Self.ColorModel.self, from: ⓓata) {
            ⓜodel.value
        } else {
            .white
        }
    }
    static func save(_ color: Color) {
        do {
            UserDefaults.standard.setValue(try JSONEncoder().encode(Self.ColorModel(color)),
                                           forKey: 💾Key.textColor)
        } catch {
            assertionFailure()
        }
    }
}

fileprivate extension 💾Option {
    private struct ColorModel: Codable {
        var r, g, b: Double
        var value: Color { .init(red: self.r, green: self.g, blue: self.b) }
        init(_ ⓢwiftUIColor: Color) {
            if let ⓒolor = ⓢwiftUIColor.cgColor?.components {
                (self.r, self.g, self.b) = (.init(ⓒolor[0]), .init(ⓒolor[1]), .init(ⓒolor[2]))
            } else {
                (self.r, self.g, self.b) = (0, 0, 0)
            }
        }
    }
}
