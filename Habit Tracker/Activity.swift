//
//  Activity.swift
//  Habit Tracker
//
//  Created by Octavius Bowman on 1/21/22.
//

import Foundation
import SwiftUI

struct Activity: Identifiable, Codable {
    let id = UUID()
    let name: String
    let description: String
    var times: Int
    
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.id == rhs.id
    }
}

class Activities: ObservableObject {
    @Published var items = [Activity](){
        didSet {
            print("Run did set")
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    func saveActivites() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: "Items")
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Activity].self, from: items) {
                self.items = decoded
            }
            }
        }
    
    init(items:[Activity]) {
        self.items = items
    }
    
}
