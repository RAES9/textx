//
//  SearchBarView.swift
//  testx
//
//  Created by RAES on 7/12/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct SearchBarView: View {
    
    var cornerRadius: CGFloat = 12
    var backgroundColor: Color = Color("DarkestBlue")
    var height: CGFloat = 48
    var placeHolder: String = "search"
    @Binding var showCancelButton: Bool
    @Binding var searchText: String
    @FocusState var focusField: Bool?
    @AppStorage("calculatorTypeList") var typeList: String = String()
    var action: () -> Void = {}
    
    var body: some View {
        HStack {
            HStack {
                Image("search")
                    .padding(.leading, 20)
                TextField(NSLocalizedString(placeHolder, comment: String()), text: $searchText, onEditingChanged: { isEditing in
                    showCancelButton = true
                }, onCommit: {
                    action()
                })
                    .padding(.leading, 12)
                    .padding(.trailing, 20)
                    .font(.custom("VisbyCF-Bold", size: 14))
                    .focused($focusField, equals: true)
                    .disableAutocorrection(true)
                    .onAppear {
                        focusField = true
                    }
                Button(action: {
                    UIApplication.shared.endEditing(true)
                    showCancelButton = false
                    typeList = String()
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(showCancelButton ? 1 : 0)
                        .padding(.trailing, 20)
                }
            }
            .frame(height: height, alignment: .leading)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
        }
        .navigationBarHidden(showCancelButton)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            SearchBarView(showCancelButton: .constant(Bool()), searchText: .constant(String()))
        }
    }
}
