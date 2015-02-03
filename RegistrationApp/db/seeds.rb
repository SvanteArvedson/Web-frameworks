# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

at1 = ApplicationType.create(name: "Commercial")
at2 = ApplicationType.create(name: "Nonprofit")
at3 = ApplicationType.create(name: "Educational")

admin = User.create(name: "Admin", email: "info@example.com", password: "adminlösen", password_confirmation: "adminlösen", admin: 1)
u1 = User.create(name: "UserOne", email: "user.one@example.com", password: "lösen", password_confirmation: "lösen", admin: 0)
u2 = User.create(name: "UserTwo", email: "user.two@example.com", password: "lösen", password_confirmation: "lösen", admin: 0)

a1 = Application.create(name: "AppOne", user_id: u1.id, application_type_id: at1.id)
a2 = Application.create(name: "AppTwo", user_id: u1.id, application_type_id: at3.id)
a3 = Application.create(name: "AppThree", user_id: u2.id, application_type_id: at2.id)
a4 = Application.create(name: "AppFour", user_id: u2.id, application_type_id: at3.id)