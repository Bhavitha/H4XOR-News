//
//  CustomTextField.swift
//  News
//
//  Created by Bhavitha on 21/03/22.
//

import SwiftUI

struct CustomTextField: UIViewRepresentable {
    let label: String
    @Binding var text: String
    
    var focusable: Binding<[Bool]>? = nil
    var isSecureTextEntry: Binding<Bool>? = nil
    var tag: Int? = nil
    var onCommit: (() -> Void)? = nil
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = label
        textField.isSecureTextEntry = isSecureTextEntry?.wrappedValue ?? false
        if let tag = tag {
            textField.tag = tag
        }
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange(_:)), for: .editingChanged)
        
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
       uiView.text = text
       uiView.isSecureTextEntry = isSecureTextEntry?.wrappedValue ?? false
        
        if let focusable = focusable?.wrappedValue {
            for (index, focused) in focusable.enumerated() {
                if uiView.tag == index && focused {
                    DispatchQueue.main.async {
                        uiView.becomeFirstResponder()
                    }
                    break
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UITextFieldDelegate {
        let control: CustomTextField
        
        init(_ control: CustomTextField) {
            self.control = control
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            guard var focusable = control.focusable?.wrappedValue else {
                textField.resignFirstResponder()
                return true
            }
            
            for i in 0...(focusable.count - 1) {
                focusable[i] = (textField.tag + 1 == i)
            }
            
            control.focusable?.wrappedValue = focusable
            
            if textField.tag == focusable.count - 1 {
                textField.resignFirstResponder()
            }
            
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            control.onCommit?()
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            control.text = textField.text ?? ""
        }
    }
}

