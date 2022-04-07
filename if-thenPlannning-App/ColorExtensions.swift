//
//  ColorExtensions.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/07.
//
import Foundation
import SwiftUI

//［Assets.xcassets］に登録したカラーをextensionでまとめる
//extensionとは、拡張するという意味で、クラス・構造体・列挙型に対して機能を拡張出来る。拡張は追加するという意味合いがある
//Color（カラーを管理する構造体）に、「keyColor」「backgroundColor」という2つのプロパティを追加する
//extensionを使うことで、定義したカラーが一元管理できるようになる
extension Color {
    static let keyColor = Color("blue")
}

// NvigationViewがUIKItを使っているためUIカラー型も作る必要がある
extension UIColor {
    class var keyColor: UIColor {
        return UIColor(named: "blue")!
    }
}
