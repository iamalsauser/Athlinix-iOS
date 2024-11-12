import SwiftUI

struct InviteMember: Identifiable {
    let id: Int
    let name: String
    let username: String
    let role: String
    let imageName: String
}

struct Member: Identifiable {
    let id: Int
    let name: String
    let username: String
    let role: String
    let imageName: String
}

struct InviteView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @Binding var selectedMembers: [InviteMember]
    
    let members: [InviteMember] = [
        InviteMember(id: 1, name: "Vivek ", username: "@moonsight_19", role: "Coach", imageName: "profile"),
        InviteMember(id: 2, name: "Abhinav", username: "@abhinav", role: "Coach", imageName: "profile1"),
        InviteMember(id: 3, name: "Trushit", username: "@trushit_777", role: "Coach", imageName: "profile2"),
        InviteMember(id: 4, name: "Vivek Jaglan", username: "@moonsight_19", role: "Player", imageName: "profile4"),
        InviteMember(id: 5, name: "Daksh", username: "@_notdaksh", role: "Player", imageName: "profile3"),
        InviteMember(id: 6, name: "Trushit", username: "@trushit_777", role: "Player", imageName: "profile5")
    ]
    
    var filteredMembers: [InviteMember] {
        if searchText.isEmpty {
            return members
        }
        return members.filter {
            $0.name.lowercased().contains(searchText.lowercased()) ||
            $0.username.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(text: $searchText)
                    .padding()
                
                List {
                    ForEach(filteredMembers) { member in
                        MemberRow(member: member, selectedMembers: $selectedMembers)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Invite")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search", text: $text)
                .frame(maxWidth: .infinity)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            
            Image(systemName: "mic.fill")
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray6))
        )
    }
}

struct MemberRow: View {
    let member: InviteMember
    @Binding var selectedMembers: [InviteMember]
    @State private var isSelected = false
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
            if isSelected {
                selectedMembers.append(member)
            } else {
                selectedMembers.removeAll { $0.id == member.id }
            }
        }) {
            HStack(spacing: 12) {
                Image(member.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(member.name)
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    Text(member.username)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text(member.role)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .background(isSelected ? Color(.systemGray6) : Color.clear)
    }
}

struct InviteView_Previews: PreviewProvider {
    static var previews: some View {
        InviteView(selectedMembers: .constant([]))
    }
}

struct ListSeparatorHidden: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content.listRowSeparator(.hidden)
        } else {
            content
        }
    }
}

extension View {
    func hideSeparator() -> some View {
        modifier(ListSeparatorHidden())
    }
}
