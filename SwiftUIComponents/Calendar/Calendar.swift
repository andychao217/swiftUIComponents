//
//  Calendar.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/22.
//

import SwiftUI

struct Calendar: View {
    @State var currentDate: Date = Date()
    // 定义一个定时器
    @State var timer: Timer? = nil

    var body: some View {
		CalendarView(currentDate: $currentDate)
            .onAppear {
                // 启动定时器
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    // 更新 currentDate
                    currentDate = Date()
                }
            }
            .onDisappear {
                // 停止定时器
                timer?.invalidate()
                timer = nil
            }
    }
}

#Preview {
    Calendar()
}
