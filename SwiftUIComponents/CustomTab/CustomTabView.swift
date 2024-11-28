//
//  CustomTabView.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/28.
//

import SwiftUI

struct CustomTabView: View {
	@Binding var selectedTab: String
    var body: some View {
		HStack {
			MyTabBarItemView(image: "menucard", selectedTab: $selectedTab)
			MyTabBarItemView(image: "calendar.circle", selectedTab: $selectedTab)
			MyTabBarItemView(image: "arrow.trianglehead.up.and.down.righttriangle.up.righttriangle.down", selectedTab: $selectedTab)
			MyTabBarItemView(image: "photo.artframe.circle", selectedTab: $selectedTab)
			MyTabBarItemView(image: "flowchart", selectedTab: $selectedTab)
			MyTabBarItemView(image: "lightbulb", selectedTab: $selectedTab)
		}
		.padding()
		.background(.ultraThickMaterial)
		.cornerRadius(25)
		.padding(.horizontal)
    }
}
