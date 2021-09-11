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
        context.coordinator.update(textField: uiView, with: Int(time))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        let parent: TimeField
        var didEdit = false
        
        func update(textField: UITextField, with time: Int) {
            if (!didEdit) {
                textField.text = "\(time / 60) minutes \(time % 60) seconds"
            }
            else {
                didEdit = false
            }
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString: String) -> Bool {
            let string = (textField.text! as NSString).replacingCharacters(in: range, with: replacementString)
            let scanner = Scanner(string: string)
            scanner.charactersToBeSkipped = .whitespaces
            
            didEdit = true
            
            var minutes = scanner.scanInt() ?? 0
            
            guard scanner.scanString("minutes") != nil else {
                didEdit = false
                return false
            }
            
            var seconds = scanner.scanInt() ?? 0
            if seconds > 59 {
                didEdit = false
                minutes += 1
                seconds -= 60
            }
            
            guard scanner.scanString("seconds") != nil else {
                didEdit = false
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
