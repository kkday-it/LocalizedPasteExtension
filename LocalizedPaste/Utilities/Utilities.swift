//
//  Utilities.swift
//  LocalizedPaste
//
//  Created by 劉柏賢 on 2019/11/20.
//  Copyright © 2019 劉柏賢. All rights reserved.
//

import Foundation

struct Utilities {

    private init() {
        
    }
    
    public static func getLocalized(input: String?, source: SourceCommand?) -> String? {

        guard let input = input,
             let source = source else {
            return nil
        }

        switch source {
        case .localizable:
            
            // "boarding_label_start_trip" = "開始體驗";
            let array: [String] = input.components(separatedBy: "=").map { (item: String) -> String in
                return item.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).replacingOccurrences(of: ";", with: "")
            }
            
            print(array)
            
            guard !array.isEmpty, array.count >= 2 else {
                return nil
            }
            
            // "boarding_label_start_trip".localize("開始體驗")
            let result: String = "\(array[0]).localize(\(array[1]))"
            return result
            
        case .excel:
            
            // home_label_detail_explore_the_world    出發，冒險才真正開始。
            
            let excelColumnSpace: String = "\t"
            
            let array: [String] = input.components(separatedBy: excelColumnSpace).map { (item: String) -> String in
                return item.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            }
            
            print(array)
            
            guard !array.isEmpty, array.count >= 2 else {
                return nil
            }
            
            //"boarding_label_start_trip".localize("開始體驗")
            let result: String = "\"\(array[0])\".localize(\"\(array[1])\")"
            return result
        }
    }

}
