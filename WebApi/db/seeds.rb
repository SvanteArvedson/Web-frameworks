# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

c1 = Creator.create(email: "creator.one@example.com", password: "hemligt", password_confirmation: "hemligt")
c2 = Creator.create(email: "creator.two@example.com", password: "hemligt", password_confirmation: "hemligt")

p1 = Position.create(latitude: 1111.111111, longitude: 1111.111111)
p2 = Position.create(latitude: 2222.222222, longitude: 2222.222222)

t1 = Tag.create(name: "spännande")
t2 = Tag.create(name: "läskigt")

s1 = Story.create(name: "Monsterståry", description: "Buu Huu Buu Huu", creator: c1, position: p1, tags: [t1, t2])
s2 = Story.create(name: "Vampyrståry", description: "Blodkorv och svartsoppa", creator: c2, position: p2, tags: [t1, t2])