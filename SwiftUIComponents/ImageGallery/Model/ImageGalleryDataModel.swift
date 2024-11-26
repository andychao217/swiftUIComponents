//
//  DataModel.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/26.
//

import Foundation

class ImageGalleryDataModel: ObservableObject {
	@Published var items: [Item] = []
	
	init() {
		if let documentDirectory = FileManager.default.documentDirectory {
			let urls = FileManager.default.getContentsDirectory(documentDirectory).filter { $0.isImage }
			
			for url in urls {
				let item = Item(url: url)
				items.append(item)
			}
		}
		
		if let urls = Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: nil) {
			for url in urls {
				let item = Item(url: url)
				items.append(item)
			}
		}
	}
	
	func addItem(_ item: Item) {
		items.insert(item, at: 0)
	}
	
	func removeItem(_ item: Item) {
		if let index = items.firstIndex(of: item) {
			items.remove(at: index)
			FileManager.default.removeItemFromDocumentDirectory(url: item.url)
		}
	}
}

extension URL {
	var isImage: Bool {
		let imageExtensions = ["jpg", "jpeg", "png", "heic"]
		return imageExtensions.contains(self.pathExtension)
	}
}


extension FileManager {
	var documentDirectory: URL? {
		return self.urls(for: .documentDirectory, in: .userDomainMask).first
	}
	
	func copyItemToDocumentDirectory(from sourceURL: URL) -> URL? {
		guard let documentDirectory = documentDirectory else { return nil }
		let fileName = sourceURL.lastPathComponent
		let destinationURL = documentDirectory.appendingPathComponent(fileName)
		
		if self.fileExists(atPath: destinationURL.path) {
			return destinationURL
		} else {
			do {
				try self.copyItem(at: sourceURL, to: destinationURL)
				return destinationURL
			} catch let error {
				print("Unable to copy file: \(error.localizedDescription)")
			}
		}
		return nil
	}
	
	func removeItemFromDocumentDirectory(url: URL) {
		guard let documentDirectory = documentDirectory else { return }
		let fileName = url.lastPathComponent
		let fileUrl = documentDirectory.appendingPathComponent(fileName)
		
		if self.fileExists(atPath: fileUrl.path) {
			do {
				try self.removeItem(at: url)
			} catch let error {
				print("Unable to remove file: \(error.localizedDescription)")
			}
		}
	}
	
	func getContentsDirectory(_ url: URL) -> [URL] {
		var isDirectory: ObjCBool = false
		guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory), isDirectory.boolValue else { return [] }
		do {
			return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
		} catch let error {
			print("Unable to get directory contents: \(error.localizedDescription)")
		}
		return []
	}
}
