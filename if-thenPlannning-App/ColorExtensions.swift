//
//  ColorExtensions.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/07.
//
import SwiftUI

// Assets.xcassetsに登録したカラーをextensionでまとめる
// extensionを使うことで、定義したカラーが一元管理できるようになる
extension Color {
    static let backgroundColor = Color("Background")
    static let fontColor = Color("fontColor")
}

// NvigationViewがUIKItを使っているためUIカラー型も作る必要がある
extension UIColor {
    class var backgroundColor: UIColor {
        return UIColor(named: "Background")!
    }
}
