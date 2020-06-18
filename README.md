# README

This is a simple rails project where it integrates an api to the Gihub webhooks

Each issue event created within this repository will be sent to this app which will persist that data into a database.

There is an api to fetch all events from an issue

* Ruby version
- ruby 2.7.1
- Rails 6

* Configuration
```bundle install```

* Database creation
```rails db:create```

* Database initialization
```rails db:migrate```

* How to run the test suite
```rspec spec```

* Enpoints
- webhooks endpoint:
```'/webhooks/payload```

- events endpoing:
```'/issues/:id/events```

ps: 'id' in this case is the issue number

* Running the project localy:

First make a clone of this repo into your own github repository.

Then, to make webhooks work properly in your project locally you will have to use ngrok service

Get it from https://ngrok.com/ and install it.

Once you have set ngrok up, then run it watching the port where your local server is running the application. 

In this case I have been using port 3000, so it would be something like this:

```ngrok http 3000```

It will log something similar to this:
```
Version                       2.3.35                                                                                                                                                                               
Region                        United States (us)                                                                                                                                                                   
Web Interface                 http://127.0.0.1:4040                                                                                                                                                                
Forwarding                    http://57c60a9c9b82.ngrok.io -> http://localhost:3000                                                                                                                                
Forwarding                    https://57c60a9c9b82.ngrok.io -> http://localhost:3000                                                                                                                               
```

Get the 'http://57c60a9c9b82.ngrok.io' from YOUR LOG and add it to your 'config/environment/development.rb' file inside of 'Rails.application.configure' block like so:

``` config.hosts << "57c60a9c9b82.ngrok.io" ```

Finally you will have to update the payload URL of your webhook on your github remote repository. Go to Settings > Webhooks > Manage webhooks and update the payload URL with
```<Your ngrok link>/webhooks/payload```

Now you are ready to go! 

Run your application: ```rails s``` and whenever you update something realted to 'Issues' in your remote repository, it will create and event in your databse :)

That is it! 

# github-webhooks
