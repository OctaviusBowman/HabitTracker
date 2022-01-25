//
//  AddActivity.swift
//  Habit Tracker
//
//  Created by Octavius Bowman on 1/21/22.
//

import SwiftUI

struct AddActivity: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    @ObservedObject var activities: Activities
    
    @State private var name = ""
    @State private var description = ""
    @State private var amount = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter the habit")) {
                    TextField("Name", text: $name)
                }
                
                Section(header: Text("Enter habit description")) {
                    TextField("Description", text: $description)
                }
                Section(header: Text("Times completed")) {
                    Stepper(value: $amount, in: 0...Int.max, step: 1) {
                        Text("\(amount) times")
                    }
                }
            }
            .navigationBarTitle("Add new Activity")
            .navigationBarItems(trailing: Button(action: {
                let item = Activity(name: self.name, description: self.description, times: self.amount)
                self.activities.items.append(item)
                
                self.activities.saveActivites()
                
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
            }))
        }
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity(activities: Activities())
    }
}
