//
//  GridItemView.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/26.
//

import SwiftUI

struct ImageGalleryGridItemView: View {
	let size: Double
	let item: ImageGalleryItem
	
    var body: some View {
		ZStack(alignment: .topTrailing) {
			AsyncImage(url: item.url) { image in
				image
					.resizable()
					.scaledToFill()
			} placeholder: {
				ProgressView()
			}
			.frame(width: size, height: size)
		}
    }
}
