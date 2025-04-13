<img width="1223" alt="Screen Shot 2025-04-10 at 6 02 43 PM" src="https://github.com/user-attachments/assets/4616cba8-3077-49cd-a0b4-1c450f13e1f2" />

##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby 3.4.4
- Rails 8.0.2
- Node v20.17.0 (I recommend using [NVM](https://github.com/nvm-sh/nvm) for managing and switching nodes)
- Yarn 1.22.22

##### 1. Check out the repository

```bash
git clone git@github.com:noxmwalsh/coding_challenge.git
```

##### 2. Create database.yml file

Copy the sample database.yml file and edit the database configuration as required.

```bash
cp config/database.example.yml config/database.yml
```

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
bundle exec rake db:seed (if you want scaffold data)
```

##### 4. Build assets

```bash
yarn build
```

##### 5. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

Or, if you're planning on doing development on the project, just run the following

```bash
bin/dev
```

And now you can visit the site with the URL http://localhost:3000.

**Features List**:

* Users can sign-up, sign-in, and sign out.  Signed in users can do write actions on the app (for example, creating or deleting a post)
* Each post has four attributes: Body, Description, Title, and Hero Image (Using ActiveStorage and miniMagick).  The signed in author is the assigned user of a created post.
* Pagination is available (max post per page is 10)
* There's a bunch of rspec specs added
* Each page has a unique slug to it that's derived from the title
* Rich text support for the body attribute (Although the styling for Trix is borked - I'm looking into it)
* It's ready to run at the start with seed data.  Dog themed, of course.
* Uses Bootstrap for styling
* Uses Postgres for data persistence, although nothing is stopping anything from swapping the adapter and DB

**WIP**:
* Heroku deployment
