//
//  ContentView.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/28.
//

import SwiftUI

struct ContentView: View {
	@State var selectedTab: String = "menucard"
	
    var body: some View {
		ZStack(alignment: .bottom) {
			VStack {
				Spacer()
				ZStack {
					if selectedTab == "menucard" {
						AnimatingCards()
					} else if selectedTab == "calendar.circle" {
						MyCalendar()
					} else if selectedTab == "arrow.trianglehead.up.and.down.righttriangle.up.righttriangle.down" {
						FlipClockAnimation(max: 20, min: 0)
					} else if selectedTab == "photo.artframe.circle" {
						ImageGallery()
					} else if selectedTab == "flowchart" {
						MyStepper()
					} else if selectedTab == "lightbulb" {
						NeonGlow()
					}
				}
				Spacer()
				CustomTabView(selectedTab: $selectedTab)
			}
			.padding(.vertical)
			.ignoresSafeArea()
		}
    }
}

#Preview {
    ContentView()
}
