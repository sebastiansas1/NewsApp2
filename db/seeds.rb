# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

include ApiHelper

Reader.create!([{ id: 1, email: 'lorena@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Lorena' },
                { id: 2, email: 'mike@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Mike' },
                { id: 3, email: 'joe.d@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Joseph' },
                { id: 4, email: 'joe.b@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Joe' },
                { id: 5, email: 'sebastian@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Sebastian' },
                { id: 6, email: 'giorgio@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Giorgio' },
                { id: 7, email: 'lars@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Lars' },
                { id: 8, email: 'carina@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Carina' },
                { id: 9, email: 'sergiu@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Sergiu' },
                { id: 10, email: 'antwnis@gmail.com', password: 'newsapp', password_confirmation: 'newsapp', created_at: Time.now, updated_at: Time.now, name: 'Antwnis' }])

Friend.create!([{ id: 1, reader_id: 1, friend_id: 5, strength: 100 },   # Lorena-Sebastian
                { id: 2, reader_id: 1, friend_id: 8, strength: 90 },    # Lorena-Carina
                { id: 3, reader_id: 1, friend_id: 9, strength: 75 },    # Lorena-Sergiu
                { id: 4, reader_id: 1, friend_id: 4, strength: 50 },    # Lorena-Joe.B
                { id: 5, reader_id: 1, friend_id: 7, strength: 50 },    # Lorena-Lars
                { id: 6, reader_id: 1, friend_id: 2, strength: 25 },    # Lorena-Mike

                { id: 7, reader_id: 2, friend_id: 5, strength: 70 },    # Mike-Sebastian
                { id: 8, reader_id: 2, friend_id: 1, strength: 50 },    # Mike-Lorena
                { id: 9, reader_id: 2, friend_id: 10, strength: 30 },   # Mike-Antwnis

                { id: 10, reader_id: 3, friend_id: 5, strength: 70 },   # Joe.D-Sebastian
                { id: 11, reader_id: 3, friend_id: 6, strength: 50 },   # Joe.D-Giorgio
                { id: 12, reader_id: 3, friend_id: 2, strength: 30 },   # Joe.D-Mike
                { id: 13, reader_id: 3, friend_id: 7, strength: 20 },   # Joe.D-Lars

                { id: 14, reader_id: 4, friend_id: 5, strength: 90 },   # Joe.B-Sebastian
                { id: 15, reader_id: 4, friend_id: 1, strength: 60 },   # Joe.B-Lorena
                { id: 16, reader_id: 4, friend_id: 7, strength: 40 },   # Joe.B-Lars
                { id: 17, reader_id: 4, friend_id: 8, strength: 30 },   # Joe.B-Carina
                { id: 18, reader_id: 4, friend_id: 9, strength: 30 },   # Joe.B-Sergiu

                { id: 19, reader_id: 5, friend_id: 1, strength: 100 },  # Sebastian-Lorena
                { id: 20, reader_id: 5, friend_id: 4, strength: 90 },   # Sebastian-Joe.B
                { id: 21, reader_id: 5, friend_id: 8, strength: 80 },   # Sebastian-Carina
                { id: 22, reader_id: 5, friend_id: 9, strength: 75 },   # Sebastian-Sergiu
                { id: 23, reader_id: 5, friend_id: 7, strength: 70 },   # Sebastian-Lars
                { id: 24, reader_id: 5, friend_id: 6, strength: 80 },   # Sebastian-Giorgio
                { id: 25, reader_id: 5, friend_id: 10, strength: 65 },  # Sebastian-Antwnis
                { id: 26, reader_id: 5, friend_id: 3, strength: 50 },   # Sebastian-Joe.D

                { id: 27, reader_id: 6, friend_id: 5, strength: 80 },   # Giorgio-Sebastian
                { id: 28, reader_id: 6, friend_id: 10, strength: 70 },  # Giorgio-Antwnis
                { id: 29, reader_id: 6, friend_id: 3, strength: 60 },   # Giorgio-Joe.D

                { id: 30, reader_id: 7, friend_id: 5, strength: 90 },   # Lars-Sebastian
                { id: 31, reader_id: 7, friend_id: 4, strength: 85 },   # Lars-Joe.B
                { id: 32, reader_id: 7, friend_id: 1, strength: 80 },   # Lars-Lorena
                { id: 33, reader_id: 7, friend_id: 8, strength: 60 },   # Lars-Carina
                { id: 34, reader_id: 7, friend_id: 9, strength: 50 },   # Lars-Sergiu

                { id: 35, reader_id: 8, friend_id: 9, strength: 100 },  # Carina-Sergiu
                { id: 36, reader_id: 8, friend_id: 1, strength: 90 },   # Carina-Lorena
                { id: 37, reader_id: 8, friend_id: 5, strength: 80 },   # Carina-Sebastian
                { id: 38, reader_id: 8, friend_id: 4, strength: 60 },   # Carina-Joe.B
                { id: 39, reader_id: 8, friend_id: 7, strength: 50 },   # Carina-Lars
                { id: 40, reader_id: 8, friend_id: 2, strength: 40 },   # Carina-Mike

                { id: 41, reader_id: 9, friend_id: 8, strength: 100 },  # Sergiu-Carina
                { id: 42, reader_id: 9, friend_id: 1, strength: 90 },   # Sergiu-Lorena
                { id: 43, reader_id: 9, friend_id: 5, strength: 80 },   # Sergiu-Sebastian
                { id: 44, reader_id: 9, friend_id: 4, strength: 60 },   # Sergiu-Joe.B
                { id: 45, reader_id: 9, friend_id: 7, strength: 50 },   # Sergiu-Lars

                { id: 46, reader_id: 10, friend_id: 5, strength: 100 }, # Antwnis-Sebastian
                { id: 47, reader_id: 10, friend_id: 6, strength: 80 },  # Antwnis-Giorgio
                { id: 48, reader_id: 10, friend_id: 3, strength: 50 },  # Antwnis-Joe.D
                { id: 49, reader_id: 10, friend_id: 1, strength: 40 },  # Antwnis-Lorena
                { id: 50, reader_id: 10, friend_id: 2, strength: 20 }]) # Antwnis-Mike

Admin.create!(id: 1, email: 'sebastiansasbusiness@gmail.com', password: 'SDxDm123', password_confirmation: 'SDxDm123', created_at: Time.now, updated_at: Time.now, name: 'Sebastian')

p "Created #{Reader.count} readers!"
p "Created #{Friend.count} friendships!"
p "Created #{Admin.count} admin!"
