import SwiftUI
import SwiftData
 
@Model
class Post {
  @Attribute(.unique)
  var id: UUID
  var title: String
  var content: String
  @Relationship(deleteRule: .cascade, inverse: \Comment.post)
  var comments: [Comment] = [Comment]()
  var createdAt: Date
  
  @Transient
  var isShowComment: Bool = false
  
  init(id: UUID = UUID(), title: String, content: String) {
    self.id = id
    self.title = title
    self.content = content
    self.createdAt = Date.now
  }
}

@Model
class Comment {
  @Attribute(.unique)
  var id: UUID
  @Relationship
  var post: Post?
  var content: String
  var createdAt: Date
  
  init(id: UUID = UUID(), content: String) {
    self.id = id
    self.content = content
    self.createdAt = Date.now
  }
}

struct a: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var posts: [Post]
  
  var body: some View {
    VStack {
      Text("기본")
      ForEach(posts) { post in
        VStack {
          HStack {
            Text("\(post.title) / \(post.content) / \(post.createdAt) /")
            Button("글 삭제") {
              do {
                modelContext.delete(post)
                try modelContext.save()
              } catch {
                print("error")
              }
            }
            Button("댓글 추가") {
              post.comments.append(Comment(content: "Comment-\(post.comments.count)"))
            }
          }
          if post.comments.count > 0 {
            Divider()
            ForEach(post.comments) {comment in
                HStack {
                    Text("\(comment.content) / \(comment.createdAt)")
                    Button("댓글 삭제") {
                        do {
                            modelContext.delete(comment)
                            try modelContext.save()
                        } catch {
                            print("error")
                        }
                    }
                }
            }
          }
        }
      }
      Divider()
      Button("글 추가") {
        do {
          modelContext.insert(Post(title: "Post-\(posts.count)", content: "Content-\(posts.count)"))
          try modelContext.save()
        } catch {
          print("error")
        }
      }
    }
  }
}



#Preview {
    a()
}
