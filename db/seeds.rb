# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Create readers
Reader.create!([{ id: 1, email: 'lorena@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Lorena' },
                { id: 2, email: 'mike@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Mike' },
                { id: 3, email: 'marcel@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Marcel' },
                { id: 4, email: 'joe.b@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Joe' },
                { id: 5, email: 'sebastian@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Sebastian' },
                { id: 6, email: 'giorgio@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Giorgio' },
                { id: 7, email: 'amalia@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Amalia' },
                { id: 8, email: 'carina@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Carina' },
                { id: 9, email: 'sergiu@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Sergiu' },
                { id: 10, email: 'antwnis@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Antwnis' }])

# Create friendships
Reader.all.each do |reader|
    Reader.all.each do |friend| 
        unless reader.id == friend.id
            Friendship.create(reader_id: reader.id, friend_id: friend.id)
        end
    end
end

# Create admin
Admin.create!(id: 1, email: 'sebastiansasbusiness@gmail.com', password: 'SDxDm123', password_confirmation: 'SDxDm123', created_at: Time.now, updated_at: Time.now, name: 'Sebastian')

p "Created #{Reader.count} readers!"
p "Created #{Admin.count} admin!"
