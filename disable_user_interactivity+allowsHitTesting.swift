//
//  ContentView.swift
//  Flashzilla
//
//  Created by Robert-Dumitru Oprea on 10/05/2023.
//
import CoreHaptics
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }
            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                .contentShape(Rectangle())//makes the whole frame of the view react to being tapped, not just the circle shape
                .onTapGesture {
                    print("Circle Tapped!")
                }
                .allowsHitTesting(false)//makes the view ignore tap gestures
        }
    }
    
//    VStack{
//        Text("Hello")
//        Spacer().frame(height: 100)
//        Text("World")
//    }
//    .contentShape(Rectangle())// makes it so that the space between "Hello" and "World" will react when being tapped
//    .onTapGesture{
//        print("VStack tapped!")
//    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
