//
//  TimePicker.swift
//  IntervalTimer
//
//  Created by Ostap on 30.03.2021.
//

import SwiftUI

/// A one-row time picker
struct TimePicker: View {
    @Binding var selection: TimeInterval
    let range: Range<Int>
    
    func metric(forSeconds seconds: Int) -> String {
        return seconds == 1 ? "second" : "seconds"
    }
    
    func metric(forMinutes minutes: Int) -> String {
        return minutes == 1 ? "minute" : "minutes"
    }
    
    func label(for time: Int) -> String {
        if time < 60 {
            return "\(time) \(metric(forSeconds: time))"
        }
        else {
            let minutes = time / 60
            let seconds = time % 60
            
            return String(
                format: "%d %@ %02d %@",
                minutes, metric(forMinutes: minutes), seconds, metric(forSeconds: seconds)
            )
        }
    }
    
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(range) { time in
                Text(label(for: time)).tag(TimeInterval(time))
            }
        }
        .pickerStyle(WheelPickerStyle())
    }
    
    init(selection: Binding<TimeInterval>, in range: Range<Int>) {
        self._selection = selection
        self.range = range
    }
}

#if DEBUG
struct TimePicker_Previews: PreviewProvider {
    @State static var selection: TimeInterval = 45
    
    static var previews: some View {
        TimePicker(selection: $selection, in: 1..<181)
    }
}
#endif
