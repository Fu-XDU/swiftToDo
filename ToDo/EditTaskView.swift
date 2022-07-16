//
// Created by 付铭 on 2022/7/15.
//

import SwiftUI

struct EditTaskView: View {

    @EnvironmentObject var taskViewModel: TaskViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var isNew: Bool = false
    @State var item: ItemModel = ItemModel()
    @State var oldItem: ItemModel = ItemModel()
    @State private var name: String = ""

    init(item: ItemModel) {
        // UIScrollView.appearance().backgroundColor = nil
        _item = State(initialValue: item)
        _oldItem = State(initialValue: item)
        _isNew = State(initialValue: item.title == "")
    }


    var body: some View {
        VStack {
            Section {
                HStack(spacing: 20) {
                    Button {
                        item.changeDone()
                        //item.itemDone(index: i)
                    } label: {
                        Image(systemName: item.done ? "checkmark.circle.fill" : "circle")
                                .scaleEffect(1.6)
                                .foregroundColor(item.done ? Color("icon") : Color("gray"))
                                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: -5))
                    }

                    TextField("新任务", text: $item.title)
                            .textFieldStyle(PlainTextFieldStyle())
                            .foregroundColor(item.done ? Color("listDoneFont") : Color("listUndoneFont"))
                            .font(.system(size: 21, weight: .bold))
                            .padding(.leading, 9)


                    // 加入Spacer 使右侧图标居右放置
                    Spacer()
                    Button {
                        item.changeFavorite()
                    } label: {
                        Image(systemName: item.favorite ? "star.fill" : "star")
                                .scaleEffect(1.2)
                                .frame(maxWidth: 20, maxHeight: .infinity, alignment: .trailing)
                                .foregroundColor(item.favorite ? Color("purple") : Color("gray"))
                                .padding(.trailing, 15)
                    }
                }
                        .frame(width: 380, height: 50, alignment: .leading)
                        .padding(.leading, 15)
            }
                    //.background(Color(red: 0.13, green: 0.13, blue: 0.13))
                    .cornerRadius(5)
                    .padding(.top, 10)

            Button {
                if (isNew) {
                    taskViewModel.addItem(item: item)
                } else {
                    taskViewModel.updateItem(id: oldItem.id, newItem: item)
                }

                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("完成")
            }
        }
                .navigationBarTitle(Text("Title"), displayMode: .inline)
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(item: ItemModel(title: "", done: false, favorite: false))
    }
}

