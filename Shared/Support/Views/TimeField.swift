//
//  TimeField.swift
//  IntervalTimer
//
//  Created by Ostap on 30.08.2021.
//

import SwiftUI

struct TimeField: UIViewRepresentable {
    @Binding var time: TimeInterval
    
    func makeUIView(context: Context) -> UITextField {
        let field = UITextField()
        field.delegate = context.coordinator
        return field
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        context.coordinator.update(textField: uiView, with: time)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        let parent: TimeField
        var didEdit = false
        
        func update(textField: UITextField, with time: TimeInterval) {
            if (!didEdit) {
                textField.text = "\(time.minutesString) \(time.secondsString)"
            }
            else {
                didEdit = false
            }
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString: String) -> Bool {
            let string = (textField.text! as NSString).replacingCharacters(in: range, with: replacementString)
            let scanner = Scanner(string: string)
            scanner.charactersToBeSkipped = .whitespaces
            
            var minutes = scanner.scanInt() ?? 0
            
            let minutesLabel = parent.time.minutesLabel
            guard scanner.scanString(minutesLabel) != nil else {
                return false
            }
            
            var seconds = scanner.scanInt() ?? 0
            if seconds > 59 {
                didEdit = false
                minutes += 1
                seconds -= 60
            }
            
            let secondsLabel = parent.time.secondsLabel
            guard scanner.scanString(secondsLabel) != nil else {
                return false
            }
            
            parent.time = Double(minutes * 60 + seconds)
            return true
        }
        
        init(parent: TimeField) {
            self.parent = parent
        }
    }
}

struct TimeField_Previews: PreviewProvider {
    @State static var time = 65.0
    
    static var previews: some View {
        TimeField(time: $time)
            .padding()
    }
}
