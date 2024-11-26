//
//  Item.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/26.
//
import Foundation
import SwiftUI

struct ImageGalleryItem: Identifiable, Hashable {
	let id = UUID()
	let url: URL
}

extension ImageGalleryItem : Equatable {
	static func ==(lhs: ImageGalleryItem, rhs: ImageGalleryItem) -> Bool {
		return lhs.id == rhs.id && lhs.url == rhs.url
	}
}
