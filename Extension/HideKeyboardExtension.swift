//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Yogesh Raut on 30/12/24.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard()  {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
