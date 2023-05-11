//
//  ContentView.swift
//  Flashzilla
//
//  Created by Robert-Dumitru Oprea on 10/05/2023.
//
import CoreHaptics
import SwiftUI

struct ContentView: View {
    //Haptic Engine
    @State private var engine: CHHapticEngine?
    
    var body: some View {
       Text("Hello")
            .onAppear(perform: prepareHaptics) //Create and start haptic engine, this should be on all the time
            .onTapGesture(perform: complexSuccess) //send vibrating notification
    }
    //Send the default success vibration sequence
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    //Checks if device has haptic support, creates a haptic engine and starts it
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    //Checks if the device supports haptics, creates an empty array of haptic events and then adds some events to it.
    //it creates a pattern by using the events array, creates a player with the pattern and then makes the notification start immediately (atTime: 0)
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        var events = [CHHapticEvent]()
        for i in stride(from: 0, to:1, by: 0.1){
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        for i in stride(from: 0, to:1, by: 0.1){
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
