//
//  NfcButton.swift
//  MuscleUp
//
//  Created by Bryan Battu on 24/06/2024.
//

import SwiftUI

struct NfcButton: View {
    
    var onClick: () -> ()
    
    var body: some View {
        Button {
            onClick()
        } label: {
            HStack {
                Image(systemName: "wave.3.forward.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.trailing)
                    .tint(.black)
                Text("Scanner un tag NFC")
                    .font(.title3)
                    .foregroundStyle(Color.black)
                    .bold()
            }
            .padding()
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 1)
            )
        }

    }
}

#Preview {
    NfcButton {
        
    }
}
