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
        formatter.allowedUnits = [.hour, .minute, .second] // 不包括毫秒
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()

    var body: some View {
        // 使用TimelineView来每秒更新视图
        TimelineView(.periodic(from: .now, by: 0.0167)) { context in  // 约每秒60帧（每帧约16.67毫秒）
            // 计算当前日期与目标日期之间的时间差
            let remainingTime = targetDate.timeIntervalSince(context.date)
            if remainingTime > 0 {
                // 分开处理秒和毫秒
                let timeString = timerFormatter.string(from: remainingTime) ?? "00:00:00"
                let milliseconds = Int((remainingTime.truncatingRemainder(dividingBy: 1)) * 1000)
                let formattedMilliseconds = String(format: ":%03d", milliseconds) // 零填充到3位数字
                
                // 结合秒和毫秒显示
                Text(timeString + formattedMilliseconds)
                    .font(.largeTitle)
                    .monospacedDigit() // 确保字体的每个数字的宽度相同
            } else {
                // 当倒计时完成时
                Text("00:00:00:000")
                    .font(.largeTitle)
                    .monospacedDigit()
            }
        }
    }
}
