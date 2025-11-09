//
//  Encodable+JSON.swift
//  AroundEgypt
//
//  Created by MacbookPro on 09/11/2025.
//

import Foundation

extension Encodable {
    func asJSONData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
