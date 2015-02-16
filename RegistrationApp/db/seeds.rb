# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

at1 = ApplicationType.create(name: "Commercial")
at2 = ApplicationType.create(name: "Nonprofit")
at3 = ApplicationType.create(name: "Educational")

admin = Developer.create(name: "Admin", email: "info@example.com", password: "adminhemligt", password_confirmation: "adminhemligt", admin: 1)
d1 = Developer.create(name: "DeveloperOne", email: "developer.one@example.com", password: "hemligt", password_confirmation: "hemligt", admin: 0)
d2 = Developer.create(name: "DeveloperTwo", email: "developer.two@example.com", password: "hemligt", password_confirmation: "hemligt", admin: 0)

a1 = Application.create(name: "AppOne", developer: d1, application_type: at1)
a2 = Application.create(name: "AppTwo", developer: d1, application_type: at3)
a3 = Application.create(name: "AppThree", developer: d2, application_type: at2)
a4 = Application.create(name: "AppFour", developer: d2, application_type: at3)