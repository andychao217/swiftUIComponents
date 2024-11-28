//
//  FlipClockAnimation.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/27.
//

import SwiftUI

struct FlipClockAnimation: View {
    @Environment(\.colorScheme) var colorScheme
    let max: Int
    let min: Int
    @State private var numbers = [9, 9, 9, 9]
    @State private var start = false
    @State private var end = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            ZStack {
				ForEach(0..<4) { index in
					flipView(for: index)
				}
            }
            .overlay(content: {
                Rectangle()
                    .frame(height: 3)
                    .offset(y: 1.5)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .overlay {
                        Rectangle()
                            .frame(width: 6, height: 15)
                            .offset(x: 80, y: 1.5)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        Rectangle()
                            .frame(width: 6, height: 15)
                            .offset(x: -80, y: 1.5)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
            })
            .onReceive(timer) { _ in
                updateNumbers()
            }
        }
        .ignoresSafeArea()
        .onAppear {
            initParams()
        }
    }

    private func flipView(for index: Int) -> some View {
        let offsetY: CGFloat = index == 1 ? -60 : 60
		let maskHeight: CGFloat = index == 1 ? 180 : 120

        // 仅在 index 为 1 和 3 时应用旋转效果
        let rotationAngle: Double = (index == 1 && start) || (index == 3 && !end) ? 90 : 0

        let content = ZStack {
            RoundedRecView()
            NumberView(num: numbers[index])
        }

        // 使用 Group 来包裹返回的视图
        return Group {
            if index == 0 {
                content
            } else {
				if index == 2 {
					content.mask {
						RoundedRecView(height: maskHeight)
							.offset(y: offsetY)
					}
				} else {
					content.mask {
						RoundedRecView(height: maskHeight)
							.offset(y: offsetY)
					}.rotation3DEffect(.degrees(rotationAngle), axis: (x: index == 1 ? -1 : 1, y: 0, z: 0), anchor: .center, anchorZ: 0, perspective: 0.5)
				}
            }
        }
    }

    private func updateNumbers() {
        if numbers[0] > min {
            numbers[0] -= 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                numbers[2] -= 1
            }
            withAnimation(.spring().speed(3)) {
                start.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                start = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                numbers[1] -= 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                numbers[3] -= 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring().speed(3)) {
                    end = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                end = false
            }
        } else {
            initParams()
        }
    }

    private func initParams() {
        numbers = Array(repeating: max, count: 4)
        start = false
        end = false
    }
}

#Preview {
    FlipClockAnimation(max: 20, min: 0)
}
