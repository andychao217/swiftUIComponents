//
//  FlipClockAnimation.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/27.
//

import SwiftUI

struct FlipClockAnimation: View {
	@Environment(\.colorScheme) var colorScheme
    @State var start = false
    @State var end = false
    @State var num = 9
    @State var num2 = 9
    @State var num3 = 9
    @State var num4 = 9
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            ZStack {
                RoundedRecView()
                number(num: num)

                ZStack {
                    RoundedRecView()
                    number(num: num2)
                }
                .mask {
                    RoundedRecView()
                        .offset(y: -60)
                }
                .rotation3DEffect(.degrees(start ? 90 : 0), axis: (x: -1, y: 0, z: 0), anchor: .center, anchorZ: 0, perspective: 0.5)

                ZStack {
                    RoundedRecView()
                    number(num: num3)
                }
                .mask {
                    RoundedRecView(height: 120)
                        .offset(y: 60)
                }

                ZStack {
                    RoundedRecView()
                    number(num: num4)
                }
                .mask {
                    RoundedRecView(height: 120)
                        .offset(y: 60)
                }
                .rotation3DEffect(.degrees(end ? 0 : 90), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 0, perspective: 0.5)
            }
            .overlay(content: {
                Rectangle()
                    .frame(height: 3)
                    .offset(y: 1.5)
					.foregroundColor(colorScheme == .dark ? .black : .white)
            })
            .onReceive(timer) { _ in
                if num > 0 {
                    num -= 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                        num3 -= 1
                    }
                    withAnimation(.spring().speed(3)) {
                        start.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        start = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        num2 -= 1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        num4 -= 1
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
                    num = 9
                    num2 = 9
                    num3 = 9
                    num4 = 9
                    start = false
                    end = false
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    FlipClockAnimation()
}

struct RoundedRecView: View {
	@Environment(\.colorScheme) var colorScheme
    var width: CGFloat = 160
    var height: CGFloat = 180
    var body: some View {
        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .frame(width: width, height: height)
			.foregroundColor(colorScheme == .dark ? .white : .black)
    }
}

struct number: View {
	@Environment(\.colorScheme) var colorScheme
    var num = 0
    var body: some View {
        Text("\(num)").font(.system(size: 180))
            .foregroundColor(colorScheme == .dark ? .black : .white)
    }
}
