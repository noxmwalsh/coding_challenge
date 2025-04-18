<img width="1224" alt="Screen Shot 2025-04-13 at 5 29 34 PM" src="https://github.com/user-attachments/assets/25c815f4-17f3-4534-92b8-4f2447a38d2d" />

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
* Each post has five attributes: Body, Description, Title, author (which is a User) and Hero Image (Using ActiveStorage and miniMagick).  The signed in author is the assigned user of a created post. Everything should validated.
* Pagination is available (max post per page is 10) and is done in an accordian style
* There's a bunch of rspec specs added to cover everything from the controllers, models, sign-in, and routes
* Each page has a unique slug to it that's derived from the title to make it human readable
* The hero images is uploadable locally in development.  On production/heroku, it uploads directly to AWS S3!
* It's ready to run at the start with seed data.  Dog themed, of course 🐕
* Uses Bootstrap for styling and DOM structure
* Uses Postgres for data persistence, although nothing is stopping anything from swapping the adapter and DB
* It's deployed to Heroku right now!  In fact, it automatically deploys and follows a pipeline ruleset (so, it's a lightweight CI/CD setup).  Pull requests on this repo will run checks and will not allow merging until everything passes.
* Did I mention this is a dog themed blog?
