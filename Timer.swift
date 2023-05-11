//
//  ContentView.swift
//  Flashzilla
//
//  Created by Robert-Dumitru Oprea on 10/05/2023.
//
import CoreHaptics
import SwiftUI

struct ContentView: View {
    let timer = Timer.publish(every: 1,tolerance: 0.5, on: .main, in: .common).autoconnect()//Creates a timer that updates every 1 second
    //tolerance allows the timer to "tick" between 1 and 1.5 seconds, this is used to allow iOS to optimise timers
    //when there are more timers, the system will try con group the timers and make them tick together to save battery, this is why tollerance is used.
    @State private var counter = 0
    var body: some View {
        VStack{
            Text("Hello")
                .onReceive(timer) {time in
                    if counter == 5 {
                        timer.upstream.connect().cancel()//goes upstream, connects and cancels the timer when counter hits 5
                    }else {
                        counter += 1
                    }
                    print("Time is now: \(time)")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
