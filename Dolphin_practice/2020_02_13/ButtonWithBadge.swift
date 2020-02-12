//
//  ButtonWithBadge.swift
//  Dolphin_practice
//
//  Created by 박찬영 on 2020/02/12.
//  Copyright © 2020 박찬영. All rights reserved.
//

import SwiftUI

struct ButtonWithBadge: View {
    var body: some View {
        customButton()
    }
}

struct ButtonWithBadge_Previews: PreviewProvider {
    static var previews: some View {
        ButtonWithBadge()
    }
}

struct customButton : View{
    @State var count = 0
    var body : some View{
        ZStack{
            Button(action : {
                self.count+=1
            }){
                Image(systemName: "bell.fill").resizable().frame(width: 30, height: 30)
            }.padding()
                .foregroundColor(Color.black)
                .background(Color.gray)
            .clipShape(Circle())
            
            Text("\(count)").padding(6).background(Color.black).clipShape(Circle()).foregroundColor(.white).offset(x:17,y:-25)
        }.animation(.spring())
    }
}
