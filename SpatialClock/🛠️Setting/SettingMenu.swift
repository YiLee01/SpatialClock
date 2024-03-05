import SwiftUI

struct SettingMenu: View {
    @EnvironmentObject var model: AppModel
    var body: some View {
        TabView {
            🛠️ClockTab()
            🛠️VisualTab()
            🛠️RestTab()
            🛠️TipsTab()
            🛠️AboutTab()
            🛠️RequestTab()
        }
        .frame(width: 520, height: 600)
    }
}
