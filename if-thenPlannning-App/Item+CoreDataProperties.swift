//
//  Item+CoreDataProperties.swift
//  if-thenPlannning-App
//
//  Created by nakamura motoki on 2022/04/04.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var content1: String?
    @NSManaged public var content2: String?
    @NSManaged public var date: Date?
    
    //値がnilの場合のデフォルト値定義
    
    public var wappedContent1: String{ content1 != nil ? content1! : ""}
    public var wappedContent2: String{ content2 != nil ? content2! : ""}
    public var wrappedDate: Date{ date ?? Date()}
}

extension Item : Identifiable {
    // ここに追加
       // stringUpdatedAtを呼び出すとString型のupdatedAtが返却される
       public var stringUpdatedAt: String { dateFomatter(date: date ?? Date()) }
       
       func dateFomatter(date: Date) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy/MM/dd"
           dateFormatter.locale = Locale(identifier: "en_US_POSIX")
           dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")

           return dateFormatter.string(from: date)
       }
}
