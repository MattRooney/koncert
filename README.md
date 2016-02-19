# README

Koncert is my implementation of the Turing School Module 3 Self-Directed Project.
This project's requirements include the use of an external OAuth provider, consumption of at
least one API, and a solution to a real problem. You can find the completed project
outline [here](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/self_directed_project.md).

Koncert is a playlist generator that uses the [Spotify API](https://developer.spotify.com/web-api/) and the [BandsInTown API](https://www.bandsintown.com/api/1.0/requests#events-search) to create playlists from bands or musicians with upcoming shows in your location. While there are plenty of great websites that list upcoming concerts by area, it's hard to have any idea what the many lesser-known bands and musicians might sound like.

* Ruby version - 2.2.2

#####To run this app locally, simply:

Clone this repo:

`git clone git@github.com:MattRooney/koncert.git`

Install dependencies

`bundle`

Start the Server:

`rails s`

To run tests:

`$ rake` or `$ bundle exec rake`

Visit in Browser:

`http://localhost:3000`

#####To run this app in production visit:

`http://koncert.herokuapp.com/`

![homescreen](/app/assets/images/koncert.png)
