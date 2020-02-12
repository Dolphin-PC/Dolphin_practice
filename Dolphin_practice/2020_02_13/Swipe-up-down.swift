//
//  Swipe-up-down.swift
//  Dolphin_practice
//
//  Created by 박찬영 on 2020/02/12.
//  Copyright © 2020 박찬영. All rights reserved.
//

import SwiftUI

struct Swipe_up_down: View {
    @State var size : CGFloat = UIScreen.main.bounds.height - 130
    
    var body: some View {

        ZStack{
            Color.orange
            swipe().padding(20).cornerRadius(20).offset(y:size)
            .gesture(DragGesture()
                .onChanged({(value) in
                    if value.translation.height > 0 {
                        self.size = value.translation.height
                    }
                    else{
                        let temp = UIScreen.main.bounds.height - 130
                        self.size = temp + value.translation.height
                    }
                })
                .onEnded({ ( value) in
                    if value.translation.height > 0{
                        if value.translation.height > 200{
                            self.size = UIScreen.main.bounds.height - 130
                        }
                        else{
                            self.size = 15
                        }
                    }
                    else{
                        if value.translation.height < -200{
                            self.size = 15
                        }
                        else{
                            self.size = UIScreen.main.bounds.height - 130
                        }
                    }
                })).animation(.spring())
        }
    }
}

struct Swipe_up_down_Previews: PreviewProvider {
    static var previews: some View {
        Swipe_up_down()
    }
}

struct swipe : View {
    var body : some View{
        VStack{
            Text("Swipe up to See More").fontWeight(.heavy).padding([.top,.bottom],15)
            
            HStack{
                Spacer()
                Text("Hello Top").fontWeight(.heavy).padding()
            }
            
            Spacer()
            Text("Hello Bottom").fontWeight(.heavy).padding()
        }.background(Color.green)
    }
}
