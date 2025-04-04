For this code challenge, you're going to build a quick and simple blog with Rails.

<h1>Challenge</h1>
The site should consist of a homepage with a paginated list of posts in descending chronological order. Each post should show the title, description, and author, with a link to view the full post.

Creating a post should be a separate page with a simple form. Each post should have a title, description, and body. It should validate that all of these fields are filled out. The post should also have an author, which is automatically assigned as the signed in user. The author of a post should have the ability to edit and delete the post after creation.

You should be required to sign up for an account in order to create a post. For the purposes of this challenge, anyone can create an account and create a post. You can use a plug-and-play solution like devise if you want.

<h1>Technical Requirements</h1>
Use Rails
Use PostgreSQL
Use webpack for assets
Use git for version control
You can use any CSS framework you're comfortable with, e.g. Bootstrap, Tailwind, antd, etc. The site design does not need to be unique or fancy, but it should be clean and functional.

<h1>Deliverables</h1>
The completed project should be sent back with a link to the repository where it's hosted. If there are any special instructions for running the project outside of the usual for Rails, please include that in the README.

<h1>Extra Credit</h1>
It's totally optional, but we encourage you to follow any ideas you have to enhance the site beyond the base requirements. Here are some examples:

Seed the database with posts so there is content to play around with immediately after install
Add rich text support to the post body via Markdown or Action Text
Add hero images to posts
Add slugs to posts for pretty URLs
Implement the homepage in React and fetch pages via an API
Host the site on Heroku (free plan)
Add tests
