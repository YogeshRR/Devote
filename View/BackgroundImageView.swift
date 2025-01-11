//
//  BackgroundImageView.swift
//  Devote
//
//  Created by Yogesh Raut on 07/01/25.
//

import SwiftUI

struct BackgroundImageView: View {
    
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFit()
            .ignoresSafeArea(.all)
    }
}

struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView()
            
    }
}
