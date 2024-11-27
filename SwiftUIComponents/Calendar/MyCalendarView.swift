//
//  CalendarView.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/22.
//

import Foundation
import SwiftUI

struct MyCalendarView: View {
    @Environment(\.colorScheme) var colorScheme

    @Binding var currentDate: Date

    @State private var selectedDate: Date?

    @State var isShowAlert: Bool = false
    @State var showImagePickerView: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var selectImage: UIImage?

    private let calendar = Foundation.Calendar.current

    private var day: Int {
        calendar.component(.day, from: currentDate)
    }

    private var month: Int {
        calendar.component(.month, from: currentDate)
    }

    private var monthName: String {
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM"
        return monthFormatter.string(from: currentDate)
    }

    private var abbreviatedMonthName: String {
        return String(monthName.prefix(3))
    }

    private var year: Int {
        calendar.component(.year, from: currentDate)
    }

    private var hour: Int {
        calendar.component(.hour, from: currentDate)
    }

    private var minute: Int {
        calendar.component(.minute, from: currentDate)
    }

    private var weekDayName: String {
        let weekDayFormatter = DateFormatter()
        weekDayFormatter.dateFormat = "EEEE"
        return weekDayFormatter.string(from: currentDate)
    }

    private var daysInMonth: [Date] {
        // 获取本月的时间区间
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentDate) else {
            return []
        }
        var dates = [Date]()
        // 从这个月的开始日期开始枚举
        calendar.enumerateDates(startingAfter: monthInterval.start, matching: DateComponents(hour: 0, minute: 0, second: 0), matchingPolicy: .nextTime) { date, _, stop in
            if let date = date, date <= monthInterval.end {
                // 直接添加日期，不进行任何时区转换
                dates.append(date)
            } else {
                stop = true
            }
        }
        return dates
    }

    var body: some View {
        NavigationStack {
            ZStack {
                if let selectImage = selectImage {
                    Image(uiImage: selectImage)
                        .resizable()
                        .ignoresSafeArea()
                } else {
                    Image("background").resizable().ignoresSafeArea()
                }

                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        let dayStr = day < 10 ? "0\(day)" : "\(day)"
                        Text("\(dayStr)")
                            .font(.custom("Bebas Neue", size: 150))
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .opacity(0.8)
                            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), radius: 1, x: 1, y: 1)
                            .frame(height: 100)
//                          .blendMode(.overlay)
//                          .overlay {
//                              Text("\(dayStr)")
//                              	.font(.custom("Bebas Neue", size: 150))
//                                  .blendMode(.overlay)
//                          }

                        Text(suffixForDay(day))
                            .font(.custom("Bebas Neue", size: 35))
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .opacity(0.8)
                            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), radius: 1, x: 1, y: 1)
                            .offset(y: 35)

                        Spacer()

                        Button {
                            isShowAlert.toggle()
                        } label: {
                            Image(systemName: "gear")
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .opacity(0.8)
                                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), radius: 1, x: 1, y: 1)
                                .font(.title)
                        }
                        .offset(y: -50)
                    }

                    Text(String(format: "%02d:%02d", hour, minute))
                        .font(.custom("Bebas Neue", size: 35))
                        .foregroundStyle(colorScheme == .dark ? .black : .white)
                        .padding(.top)
                        .opacity(0.8)
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), radius: 1, x: 1, y: 1)

                    HStack {
                        Text(abbreviatedMonthName)
                            .font(.custom("Bebas Neue", size: 100))
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .frame(height: 50)
                            .kerning(10)
                            .opacity(0.8)
                            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), radius: 1, x: 1, y: 1)

                        Spacer()

                        VStack(alignment: .trailing) {
                            Text("\(year)")
                                .font(.custom("Bebas Neue", size: 35))
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .opacity(0.8)
                                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), radius: 1, x: 1, y: 1)

                            Text(weekDayName)
                                .font(.custom("Bebas Neue", size: 35))
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .opacity(0.8)
                                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5), radius: 1, x: 1, y: 1)
                        }
                    }.padding(.top)

                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.clear)
                            .background(
                                VisualEffectBlur(style: colorScheme == .dark ? .dark : .light) // 添加磨砂效果
                                    .cornerRadius(25) // 磨砂效果的圆角
                                    .ignoresSafeArea()
                            )
                            .clipShape(.rect(cornerRadius: 25, style: .continuous))

                        VStack {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 15) {
                                ForEach(localizedWeekdays(), id: \.self) { day in
                                    Text(day)
                                        .foregroundStyle(day == NSLocalizedString("SUN", comment: "Sunday") ? .pink : colorScheme == .dark ? .white : .black)
                                }
                            }

                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 20) {
                                ForEach(0 ..< 6) { row in
                                    ForEach(0 ..< 7) { column in
                                        if let date = dateFor(row: row, column: column) {
                                            let isSunday = calendar.component(.weekday, from: date) == 2
                                            let dateInt = calendar.component(.day, from: date - 1)
                                            VStack {
                                                Text(dateInt < 10 ? "0\(dateInt)" : "\(dateInt)")
                                                    .foregroundStyle(isSunday ? .pink : colorScheme == .dark ? .white : .black)
                                                    .frame(maxWidth: .infinity)

                                                let indicatorStyle = getIndicatorStyle(for: date)

                                                Rectangle()
                                                    .fill(indicatorStyle)
                                                    .frame(width: 30, height: 2)
                                            }
                                            .padding(.top)
                                            .onTapGesture {
                                                withAnimation {
                                                    selectedDate = date
                                                }
                                            }
                                        } else {
                                            Text("")
                                                .frame(maxWidth: .infinity)
                                        }
                                    }
                                }
                            }
                        }.padding(.horizontal)

                    }.padding(.top)
                }
                .padding([.horizontal, .top])
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .onAppear {
            selectedDate = calendar.date(byAdding: .day, value: 1, to: Date())
        }
        .sheet(isPresented: $showImagePickerView) {
            ImagePickerControllerView(sourceType: self.sourceType) { uiImage in
                selectImage = uiImage
            }
        }
        .confirmationDialog("choose_photo", isPresented: $isShowAlert) {
            Button {
                if ImagePickerControllerView.cameraAviable() {
                    self.sourceType = .camera
                    showImagePickerView.toggle()
                }
            } label: {
                Text("camera")
            }

            Button {
                self.sourceType = .photoLibrary
                showImagePickerView.toggle()
            } label: {
                Text("image_gallery")
            }

            Button {
                selectImage = nil
                isShowAlert = false
            } label: {
                Text("default")
            }

            Button(role: ButtonRole.cancel) {
                isShowAlert = false
            } label: {
                Text("cancel")
            }
        }
    }

    private func getIndicatorStyle(for date: Date) -> Color {
        if let selectedDate = selectedDate {
            return calendar.isDate(selectedDate, inSameDayAs: date) ? .pink : .clear
        }
        return .clear
    }

    private func dateFor(row: Int, column: Int) -> Date? {
        let firstDayIndex = calendar.component(.weekday, from: daysInMonth.first!) - calendar.firstWeekday - 1
        let index = row * 7 + column - firstDayIndex
        return index >= 0 && index < daysInMonth.count ? daysInMonth[index] : nil
    }

    // 获取本地化的星期数组
    private func localizedWeekdays() -> [String] {
        return [
            NSLocalizedString("SUN", comment: "Sunday"),
            NSLocalizedString("MON", comment: "Monday"),
            NSLocalizedString("TUE", comment: "Tuesday"),
            NSLocalizedString("WED", comment: "Wednsday"),
            NSLocalizedString("THU", comment: "Thursday"),
            NSLocalizedString("FRI", comment: "Friday"),
            NSLocalizedString("SAT", comment: "Saturday"),
        ]
    }

//    private func daysInCurrentMonth() -> [Date] {
//        guard let range = calendar.range(of: .day, in: .month, for: selectedDate),
//              let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate)) else {
//            return []
//        }
//        return range.compactMap { day -> Date? in
//            calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
//        }
//    }

    // 根据日期获取后缀
    private func suffixForDay(_ day: Int) -> String {
        switch day {
        case 11, 12, 13:
            return "th" // 特例
        default:
            switch day % 10 {
            case 1:
                return "st"
            case 2:
                return "nd"
            case 3:
                return "rd"
            default:
                return "th"
            }
        }
    }
}

// 自定义磨砂效果视图
struct VisualEffectBlur: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurEffectView
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

#Preview {
    MyCalendar()
}
