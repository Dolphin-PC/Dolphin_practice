//
//  userDefault.swift
//  Dolphin_practice
//
//  Created by 박찬영 on 2020/02/12.
//  Copyright © 2020 박찬영. All rights reserved.
//

import SwiftUI

struct userDefaultData: View {
    @State var msg = ""
    @State var retreieved = ""
            
    var body: some View {

        VStack{
            Text(retreieved).fontWeight(.heavy)
            TextField("Enter msg To Save", text: $msg).textFieldStyle(RoundedBorderTextFieldStyle()).padding()

            Button(action : {
                UserDefaults.standard.set(self.msg, forKey: "Msg")
                self.retreieved = self.msg
                self.msg = ""
            }){
                Text("Save").padding(12)
            }.background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(9)
        }
        .onAppear{
            guard let retreivedmsg = UserDefaults.standard.value(forKey: "Msg") else{ return}
            self.retreieved = retreivedmsg as! String
        }
    }
}

struct userDefault_Previews: PreviewProvider {
    static var previews: some View {
        userDefaultData()
    }
}
