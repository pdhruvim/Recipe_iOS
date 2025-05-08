//
//  SettingsView.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 5/8/25.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("turn_on_dark_mode") var turnOnDarkMode: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Toggle("Dark Mode", isOn: $turnOnDarkMode)
                }
            }
            .navigationTitle("Settings")
            .preferredColorScheme(turnOnDarkMode ? .dark : .light)
        }
    }
}

#Preview {
    SettingsView()
}
