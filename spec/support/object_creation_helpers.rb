RANT_TEXT = "This is rant text. It is a really long string to combat" +
    "the amount of typing that it takes to be considered a rant." +
    "I am almost close to the amount of characters required" +
    "Well, if you're looking at this, I hope you have a good day."

def create_user(overrides = {})
  User.create({
                  username: "User",
                  password: "password",
                  first_name: "Samuel",
                  last_name: "Jackson",
                  bio: "This is a bio about how awesome a user I am.",
                  frequency: "Daily",
                  avatar_file_name: "IMG_0006.JPG",
                  avatar_content_type: "image/jpeg",
                  avatar_file_size: 129029,
                  avatar_updated_at: "2015-01-23 03:45:38",
                  admin: false
              }.merge(overrides))
end

def create_user!(overrides = {})
  User.create!({
                   username: "User",
                   password: "password",
                   first_name: "Samuel",
                   last_name: "Jackson",
                   bio: "This is a bio about how awesome a user I am.",
                   frequency: "Daily",
                   avatar_file_name: "IMG_0006.JPG",
                   avatar_content_type: "image/jpeg",
                   avatar_file_size: 129029,
                   avatar_updated_at: "2015-01-23 03:45:38",
                   admin: false
               }.merge(overrides))
end


def create_rant(overrides = {})
  Rant.create({
                  text: RANT_TEXT,
                  title: "Test Rant",
                  user_id: 1,
              }.merge(overrides))
  end

def create_rant!(overrides = {})
  Rant.create!({
                  text: RANT_TEXT,
                  title: "Test Rant",
                  user_id: 1,
              }.merge(overrides))
end

def create_relationship(overrides = {})
  Relationship.create({
                          follower_id: 1,
                          followed_id: 2
                      }.merge(overrides))
end

