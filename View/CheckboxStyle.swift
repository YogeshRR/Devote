//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Yogesh Raut on 11/01/25.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? Color.pink : Color.primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture{
                    configuration.isOn.toggle()
                    if (configuration.isOn) {
                        playSound(sound: "sound-rise", type: "mp3")
                    }else {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
            configuration.label
        }
    }
}

struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("Placeholder label", isOn: .constant(true))
            .toggleStyle(CheckboxStyle())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
