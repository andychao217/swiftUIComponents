//
//  DetailView.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/26.
//

import SwiftUI

struct ImageGalleryDetailView: View {
	let item: ImageGalleryItem
    var body: some View {
		AsyncImage(url: item.url) { image in
			image
				.resizable()
				.scaledToFit()
		} placeholder: {
			ProgressView()
		}
    }
}
