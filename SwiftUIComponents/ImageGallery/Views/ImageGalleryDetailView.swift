//
//  DetailView.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/26.
//

import SwiftUI

struct ImageGalleryDetailView: View {
    let item: ImageGalleryItem

    @State private var isFullScreen: Bool = false
    // 旋转角度属性
    @State private var angle: Angle = .zero
    // 控制缩放的属性
    @GestureState private var magnifyBy: CGFloat = 1.0
    // 同步组合手势
    var rotationAndScale: some Gesture {
        // 旋转手势
        let rotation = RotationGesture()
            .onChanged { angle in
                self.angle = angle
            }
            .onEnded { angle in
                self.angle += angle // 确保累加旋转角度
            }
        // 放大手势
        let scale = MagnificationGesture()
            .updating($magnifyBy) { currentState, gestureState, _ in
                gestureState = currentState
            }
        // 组合
        return rotation.simultaneously(with: scale)
    }

    var body: some View {
        ZStack {
            if isFullScreen {
                ScrollView([.horizontal, .vertical]) {
                    AsyncImage(url: item.url) { image in
                        image
                            .resizable()
							.scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                }
                .edgesIgnoringSafeArea(.all) // 使 ScrollView 边缘延伸到屏幕
            } else {
                AsyncImage(url: item.url) { image in
                    image
                        .resizable()
						.scaledToFit()
                        .scaleEffect(magnifyBy)
                        .rotationEffect(angle)
                        .gesture(rotationAndScale)
                        .animation(.easeInOut, value: angle) // 添加动画以平滑旋转效果
                } placeholder: {
                    ProgressView()
                }
            }
        }
        .onTapGesture(count: 2) {
            withAnimation {
                isFullScreen.toggle()
            }
        }
    }
}
