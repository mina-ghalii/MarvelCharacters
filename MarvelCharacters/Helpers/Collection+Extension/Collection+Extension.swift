//
//  Collection+Extension.swift
//  EtisalatTask
//
//  Created by Mina Atef on 20/01/2023.
//

import Foundation
extension RandomAccessCollection where Self.Element: Identifiable {
    
    public func isThresholdItem<Item: Identifiable>(
        offset: Int,
        item: Item
    ) -> Bool {
        guard !isEmpty else {
            return false
        }
        
        guard let itemIndex = lastIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }
        
        let distance = self.distance(from: itemIndex, to: endIndex)
        let offset = offset < count ? offset : count - 1
        return offset == (distance - 1)
    }
}
