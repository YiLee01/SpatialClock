import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: AppModel
    var body: some View {
        CountdownView(targetDate: Date().addingTimeInterval(60))
            .contentTransition(.numericText())
            .animation(.spring)
        
//        ClockView()
//            .overlay(alignment: .bottom) { 🛠️SettingButton() }
//            .persistentSystemOverlays(.hidden)
    }
}

struct CountdownView: View {
    let targetDate: Date

    // 用于格式化剩余时间的计时器格式器
    let timerFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()

    var body: some View {
        // 使用TimelineView来每秒更新视图
        TimelineView(.periodic(from: .now, by: 1.0)) { context in
            // 计算当前日期与目标日期之间的时间差
            let remainingTime = targetDate.timeIntervalSince(context.date)
            if remainingTime > 0 {
                // 使用计时器格式器格式化剩余时间
                if let timeString = timerFormatter.string(from: remainingTime) {
                    Text(timeString)
                        .font(.largeTitle)
                        .monospacedDigit() // 确保字体的每个数字的宽度相同
                }
            } else {
                // 倒计时结束后显示的文本
                Text("00:00:00:00")
                    .font(.largeTitle)
                    .monospacedDigit()
            }
        }
    }
}
