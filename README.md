Before you start, we would like to congratulate you on reaching that stage of our hiring process; it's already a significant achievement!

This is a technical exercise where we want to see the best of you. This exercise is limited to 3 days in total, so don't rush it and take the time you need within that limit. Keep in mind, we recommend favoring quality over quantity.

# How to submit your work
Use this GitHub repository to push your code.

First, clone this repository locally:
```script
$ git clone https://github.com/ios-qonto/REPOSITORY_NAME
```

By default, Github provides a `/main` branch. Please create a `/feature` branch to complete your exercise. Feel free to follow your own git-flow logic while developing, but please open a pull request from the `/feature` to the `/main` branch once you completed this exercise. 

We will then use this pull request to review your code.

**Note :** Adding a short video of your application on the description of the pull request will help us to review your work.

# Part 1 - Let's make an application!

Context - Qonto mobile developers strive to build applications where complex actions are made simple, fast and transparent for our users.

Build an application that fetches data from this API - [https://randomuser.me](https://randomuser.me/) - and displays a list of Users. 
Start by reading the API documentation [https://randomuser.me/documentation](https://randomuser.me/documentation). Your application should fetch multiple pages of Users from that API and display a list of Users with first and last names on one line and the email below. Following pages should be fetched when users scroll the list. 
Finally, while offline, previously loaded Users should still be accessible from the list. We recommend you implement this based on a classic database solution like Core Data or Realm.

## Code guidelines

Feel free to use any third-party libraries you'd need.
We favour quality over quantity, so here are a few things you should keep in mind:

- your project should follow a well-known design pattern (MVVM, Clean architecture, MVP, etc...)
- your code should contain some developers' good practices (SOLID, KISS, DRY, etc...)
- cover some classes with tests (no need to cover everything)
- favor technologies you master rather than new, fancy ones
- target: min iOS13

# Part 2 - Present your work

Context - Qonto engineers are active during our conception phases (Value Engineering, DiveIns) where they are required to write down their ideas, plan their work and engage in technical discussion with peers. 

Your next interview will be the Skills Test debrief where we will ask you to present your work and justify your choices. To prepare for this interview, it's important that you take the time to create a new Markdown file (.md) on your pull request and on this document to answer the following questions:

- give us your context at the time you did this skills test. Were you stressed/relaxed, under some constraints?
- present your work; explain its architecture, main components and how they interact with each other. Feel free to include diagrams as appropriate. Hand-drawn is fine.
- explain where you applied some developers' good practices: design pattern, SOLID, KISS, DRY principles, etc...
- explain your development strategy:
    - if you favored some functionalities or layers
    - your commits strategy
- explain if your code is future-proof (scalable, robust to changes, etc...)

Please answer in 🇺🇸  English.

# Well done!

Thank you for your time; if you have any questions, don't hesitate to contact us. We will quickly review your code and get back to you.

The Qonto iOS team
