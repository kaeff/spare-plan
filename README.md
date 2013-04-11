# spare-plan

SpaRe Plan - Single-Page App for Resource Planning

An enterprisey single-page app.

## Requirements

1. Ruby 1.9, RubyGems, Bundler
2. node.js, npm

## Post cloning

    $ bundle install
    $ npm install bower
    $ bower install

## Database

Setup

    $ rake db:setup db:migrate

Load fixtures:

    $ rake db:data:load

Launch development server:

    $ rails server

## Testing

BDD using RSpec

Execute tests during development:

    $ bundle exec guard

## Stories

* Projekte anlegen und verwalten
* Resourcen anlegen und Verwalten
* Resource einem Projekt zuordnen
* Tasks einem Projekt hinzufügen

## Technical Stories

Architectural properties the app seeks to demonstrate

### Todo

* Code sharing
  * URL helper (into controller/resources via DI)
* Master / Detail
  * Nested resources / views / scopes
* Authentication (check existing angular plugins)
* Forms? / Validation
* Offline? / Caching
* Module resolution
* Server-side rendering?

## Done

* Code sharing
  * Controller, Routes
  * Scaffolding: Resources, with errors
* Packging
  * External dependency resolution
  * Inclusion / Pipelining
* Dirty Tracking / Binding
