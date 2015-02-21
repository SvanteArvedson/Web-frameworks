# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

c1 = Creator.create(email: "creator.one@example.com", password: "hemligt", password_confirmation: "hemligt")
c2 = Creator.create(email: "creator.two@example.com", password: "hemligt", password_confirmation: "hemligt")

t1 = Tag.create(name: "spännande")
t2 = Tag.create(name: "läskigt")

s1 = Story.create(name: "Monsterståry", description: "Buu Huu Buu Huu", creator: c1, latitude: 56.1647866, longitude: 13.7754562, tags: [t1, t2])
s2 = Story.create(name: "Vampyrståry", description: "Blodkorv och svartsoppa", creator: c2, latitude: 56.1722135, longitude: 13.7956328, tags: [t1, t2])
s3 = Story.create(name: "Zombieståry", description: "Jesus lever, lungor och tår", latitude: 56.8803811, longitude: 14.8182868, creator: c2, tags: [t2])