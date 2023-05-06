# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
unless User.where(email: "admin@email.com").any?
    User.create!(
        first_name: "Admin",
        last_name: "Account",
        email: "admin@email.com",
        mobile_number: "09091234567",
        password: "admin123",
        gender: "nonbinary",
        gender_interest: "nonbinary_people",
        birthdate: Date.strptime("06/01/1998", "%m/%d/%Y"),
        country: "Philippines",
        region: "Metro Manila",
        city: "Pasig",
        role: "admin"
    )
end