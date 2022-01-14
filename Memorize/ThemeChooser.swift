//
//  ThemeChooser.swift
//  Memorize-CS193p
//
//  Created by Serafima Nerush on 1/13/22.
//

import SwiftUI

struct ThemeChooser: View {
    
    @ObservedObject var store: ThemeStore
    
    @State private var editMode: EditMode = .inactive
    
    @State private var themeToEdit: Theme?
    
    @State private var selectedThemeId: Int?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(with: theme))) {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                                .font(.title)
                                .foregroundColor(Color(rgbaColor: theme.color))
                            Text("All of \(theme.asString())")
                        }
                    }.contextMenu {
                        AnimatedActionButton(title: "Edit", systemImage: "pencil") {
                            themeToEdit = store.themes[theme]
                        }
                    }
                }
                .onDelete { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, newOffset in
                    store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
                
            }
            .navigationTitle(Text("Memorize Themes"))
            .popover(item: $themeToEdit, content: { theme in
                ThemeEditor(theme: $store.themes[theme])
            })
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        store.insertTheme(named: "New", emojis: [], pairs: 0, color: RGBAColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
                        themeToEdit = store.theme(at: 0)
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser(store: ThemeStore(named: "Preview"))
    }
}
