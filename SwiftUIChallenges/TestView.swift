//
//  TestView.swift
//  SwiftUIChallenges
//
//  Created by Guillermo Santos Barrios on 5/5/23.
//

import SwiftUI

struct TestView: View {
    let items = ["Item 1", "Item 2", "Item 3"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        
                    Divider()
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
