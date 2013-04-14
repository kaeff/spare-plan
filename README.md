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

## Running in production mode

During development, all build-time steps are either not performed on the fly (code generation) or not at all (concatenation, minification, compression, digesting).
To run in production:

    $ rails server -e production

To prepare the production environment (once):

    $ RAILS_ENV=production rake db:setup

To just trigger a build:

    $ rake assets:precompile

Build is written to `public/assets`. Don't forget to delete this directory again to re-enable on-the-fly compilation.

## Stories

* Projekte anlegen und verwalten
* Tasks einem Projekt hinzufügen
* Tasks in Abhängigkeit (Vorgänger/Nachfolger) setzen
* Projektverlauf steuern
  * Kritischen Pfad anzeigen
  * Endzeitpunkt errechnen (Early/Late)
  * Pufferzeiten anzeigen
* (Resourcen anlegen und Verwalten)
* (Resource einem Task zuordnen)

## Technical Stories

Architectural properties the app seeks to demonstrate

### Todo

* Master / Detail
  * angular-ui/ui-router?
* Module resolution?
  * "DSL" im Template context die gleichzeitig den pfad in sprockets registriert
* Offline / Caching?
* Authentication (check existing angular plugins)?
* Forms? / Validation
* Components?
  * -> ui-bootstrap
* Server-side rendering?

## Done

* Code sharing
  * Generation: Routes, Resources
  * Scaffolding: Controller, with errors
* Packging
  * External dependency resolution
  * Inclusion / Pipelining
* Dirty Tracking / Binding
* Nested resources

## Framework extraction candidates

* bower-rails
  * bower directive
* Angular integration
  * Code generation
