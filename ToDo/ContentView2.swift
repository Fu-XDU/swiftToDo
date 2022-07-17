//
// Created by 付铭 on 2022/7/17.
//

import SwiftUI

struct TaskList: Identifiable {
    let id = UUID()

}

struct ContentView2: View {

    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()

    @State private var isExpanded = true
    let cornerRadius: CGFloat = 7

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(taskViewModel.undoneItems.indices, id: \.self) { i in
                        Section {
                            NavigationLink(destination: EditTaskView(item: taskViewModel.undoneItems[i])) {
                                HStack(spacing: 20) {
                                    Image(systemName: taskViewModel.undoneItems[i].done ? "checkmark.circle.fill" : "circle")
                                            .scaleEffect(1.5)
                                            .foregroundColor(taskViewModel.undoneItems[i].done ? Color("icon") : Color("gray"))
                                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                                            .onTapGesture {
                                                taskViewModel.undoneItems[i].changeDone()
                                                taskViewModel.itemDone(index: i)
                                            }
                                    Text("\(taskViewModel.undoneItems[i].title)")
                                            .foregroundColor(Color("listUndoneFont"))
                                    // 加入Spacer 使右侧图标居右放置
                                    Spacer()
                                    Image(systemName: taskViewModel.undoneItems[i].favorite ? "star.fill" : "star")
                                            .scaleEffect(1.2)
                                            .frame(maxWidth: 20, maxHeight: .infinity, alignment: .trailing)
                                            .foregroundColor(taskViewModel.undoneItems[i].favorite ? Color("icon") : Color("gray"))
                                            .padding(.trailing, 55)
                                            .onTapGesture {
                                                taskViewModel.undoneItems[i].changeFavorite()
                                            }
                                }
                                        .frame(alignment: .leading)
                                        .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: 0))
                            }
                        }
                                .background(Color("listBackground"))
                                .padding(EdgeInsets(top: -10, leading: -20, bottom: -10, trailing: -10))
                                .frame(width: 400, height: 40, alignment: .leading)
                    }
                    // 已完成内容
                    if (taskViewModel.doneItems.count > 0) {
                        Section(header: Button {
                            isExpanded = !isExpanded
                        } label: {
                            HStack {
                                Image(systemName: "chevron.forward")
                                        .scaleEffect(0.8)
                                        .rotationEffect(Angle.init(degrees: isExpanded ? 90 : 0))
                                        .padding(.trailing, -2)
                                Text("已完成")
                            }
                        }
                                .font(.system(size: 15, weight: .bold))
                                .frame(width: 80, height: 30)
                                .foregroundColor(Color("navTitle"))
                                .background(Color("theme-layer"))
                                .cornerRadius(5)
                                .padding(EdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 0))
                        ) {
                        }
                        if (isExpanded) {
                            ForEach(taskViewModel.doneItems.indices, id: \.self) { i in
                                Section {
                                    NavigationLink(destination: EditTaskView(item: taskViewModel.doneItems[i])) {
                                        HStack(spacing: 20) {
                                            Image(systemName: taskViewModel.doneItems[i].done ? "checkmark.circle.fill" : "circle")
                                                    .scaleEffect(1.5)
                                                    .foregroundColor(taskViewModel.doneItems[i].done ? Color("icon") : Color("gray"))
                                                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                                                    .onTapGesture {
                                                        taskViewModel.doneItems[i].changeDone()
                                                        taskViewModel.itemUndone(index: i)
                                                    }
                                            Text("\(taskViewModel.doneItems[i].title)")
                                                    .foregroundColor(Color("listUndoneFont"))
                                            // 加入Spacer 使右侧图标居右放置
                                            Spacer()
                                            Image(systemName: taskViewModel.doneItems[i].favorite ? "star.fill" : "star")
                                                    .scaleEffect(1.2)
                                                    .frame(maxWidth: 20, maxHeight: .infinity, alignment: .trailing)
                                                    .foregroundColor(taskViewModel.doneItems[i].favorite ? Color("icon") : Color("gray"))
                                                    .padding(.trailing, 55)
                                                    .onTapGesture {
                                                        taskViewModel.doneItems[i].changeFavorite()
                                                    }
                                        }
                                                .frame(alignment: .leading)
                                                .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: 0))
                                    }
                                }
                                        .background(Color("listBackground"))
                                        .padding(EdgeInsets(top: -10, leading: -20, bottom: -10, trailing: -10))
                                        .frame(width: 400, height: 40, alignment: .leading)
                            }
                        }
                    }
                }
                        .listStyle(InsetGroupedListStyle())

                        .navigationTitle(Text("计划"))
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                HStack {
                                    Button(action: {}) {
                                        Image(systemName: "person.badge.plus").font(.system(size: 20)).foregroundColor(Color("navTitle")).padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                    }
                                    Button(action: {}) {
                                        Image(systemName: "ellipsis").font(.system(size: 20)).foregroundColor(Color("navTitle")).padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                    }
                                }
                            }
                        }
                NavigationLink(destination: EditTaskView(item: ItemModel(title: "", done: false, favorite: false))) {
                    HStack(spacing: 20) {
                        Image(systemName: "plus").font(.system(size: 25)).foregroundColor(Color("navTitle"))
                        Text("添加任务")
                                .foregroundColor(Color("navTitle")).padding(.leading, -5)
                    }
                            .frame(width: 380, height: 50, alignment: .leading)
                            .padding(.leading, 15)
                }
                        .background(Color("theme-layer"))
                        .cornerRadius(cornerRadius)
                        .padding(.top, 10)
                        .frame(width: 1000, height: 60)
                        .background(Color("theme").ignoresSafeArea(.all))
            }
        }
    }
}
