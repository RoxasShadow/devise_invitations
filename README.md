[![Circle CI](https://circleci.com/gh/RoxasShadow/devise_invitations.svg?style=svg)](https://circleci.com/gh/RoxasShadow/devise_invitations)

devise_invitations
=================
Allow multiple invitations on top of [devise_invitable](https://github.com/scambra/devise_invitable).

Why?
----
Basically devise_invitable, by design, can't handle multiple invitations, since it doesn't use any support table but creates a new hidden `User` for every invitation, storing there both the inviter (through the polymorphic column `sent_by`) and the token.

This means that one user is invitable once and only once.
This means that you'll find many hidden `User`s that probably will never sign up your website.

So what?
--------
So let's create a new table that allows an email address to be invited multiple times by different people, allowing the user to ignore them and sign up normally or, instead, choosing which invitation mail s?he wants to accept. Invitations are not deleted after the related user signs up the website, and they'll be flagged too (`pending` are all the invitations sent, `accepted` is an invitation that has been accepted by an user and `ignored` are the invitations ignored by the user since s?he accepted the one marked as `accepted`).

But *devise_invitable* is useful!
---------------------------------
I know, in fact I'm creating nothing but a layer on top of it. As *devise_invitations* is not a replacement, *devise_invitable* is still needed (well, we could rid it off anyway, PRs are welcomed!)

Setup
-----
Create a model called `User`, then run both Devise and *devise_invitable* on it, following their instructions.

Then, add `gem 'devise_invitations'` to your Gemfile and run `$ bundle install`.

You can install *devise_invitations* just by running `$ bin/rails g devise_invitations:install` and `bin/rake db:migrate`.

This is what's new in your project:

- A migration for a new table called `invitations` is created
- A `has_many` association for `User` (useful to fetch the sent invitations) is injected
- A new route for said action is injected as well

If you use *RSpec* and *FactoryGirl* you can run `$ bin/rails g devise_invitations:specs` to copy the specs for the new associations, controllers and models to your codebase. You can extend and customize them as you wish.

Now, you need an action to let your users invite other ones. Basically it's just

```ruby
DeviseInvitations::Invitation.create!(email: params[:email], sent_by: current_user)
```

You can add new columns to the `invitations` table to add new new attributes too, like `user_type`, `welcome_message` or whatever you want.
Create a new class `InvitationsController` that extends the original `DeviseInvitations::InvitationsController`, and override the private method `#invitation_params` to inject these additional attributes. Remember to edit the controller used for handling the invitations in the related route.
