//
//  searchBar_view.swift
//  Dolphin_practice
//
//  Created by 박찬영 on 2020/02/12.
//  Copyright © 2020 박찬영. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State var dates = ["hello","HI","welcome","world","asdfs","fdskfljsd","박찬영","김성원","박성원"]
    @State var txt = ""
    var body: some View {
        VStack{
            search_view(txt: $txt)
            
            
            List(dates.filter{ txt == "" ? true : $0.localizedCaseInsensitiveContains(txt)},id: \.self){i in
                Text(i).fontWeight(.heavy)
            }
        }
    }
}

struct SearchView_view_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct search_view : UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<search_view>) -> UISearchBar {
        let searchbar = UISearchBar()
        searchbar.barStyle = .default
        searchbar.autocapitalizationType = .none
        searchbar.delegate = context.coordinator
        return searchbar
    }
    
    @Binding var txt : String
    
    func makeCoordinator() -> search_view.Coordinator{
        return search_view.Coordinator(parent1: self)
    }
    
    func updateUIView(_ uiView : UISearchBar,context: UIViewRepresentableContext<search_view>){
        
    }
    class Coordinator : NSObject,UISearchBarDelegate{
        var parent : search_view!
        
        init(parent1 : search_view){
            parent = parent1
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText : String){
            parent.txt = searchText
        }
    }
}
