//
//  ContentView.swift
//  OCRVisionPOC
//
//  Created by Péricles Narbal on 06/04/24.
//

import SwiftUI

struct ContentView: View {
    @State var mainTitle = ""
    let imageURL = "https://cdn.gymaholic.co/motivation/images/7226-this-decision-will-get-you-one-step-closer-or-one.jpg"
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(mainTitle)
        }
        .padding()
        .onAppear(){
            OCRVisionManager.extractTextFromImageBy(url: imageURL) { title in
                mainTitle = title
            }
        }
    }
}

#Preview {
    ContentView()
}
