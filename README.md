# Phone Shop

A modernized version of the 2020 Raksul Rails work sample.

The original application was built on Rails 5.1 with Ruby-era dependencies from 2020. It has been updated for a current 2026 development environment while keeping the original inventory-management scope.

## Stack

- Ruby 4.0.6
- Rails 8.1.3.1
- SQLite 3 via `sqlite3`
- Puma 8
- Sprockets 4 for the existing Rails asset pipeline
- RSpec Rails 8
- Factory Bot Rails 6
- Shoulda Matchers 8

Rails 8.1 is the appropriate supported Rails 8 series for this 2026 refresh.

## Getting started

Install Ruby 4.0.6 with your preferred Ruby version manager, then:

```bash
bundle install
bin/rails db:prepare
bin/rails server
```

Open http://localhost:3000/admin in a browser.

## Tests

```bash
bundle exec rspec
```

The test suite covers:

- Phone model validations and associations
- Variant model validations and associations
- Price associations
- Phone CRUD endpoints
- Variant CRUD endpoints
- Dependent deletion of variants when a phone is deleted

## What was modernized

- Rails 5.1 -> Rails 8.1
- Ruby target -> Ruby 4.0.6
- Replaced 2020-era gems with current supported versions
- Removed Spring, Turbolinks, CoffeeScript, Uglifier, Sass Rails, and other obsolete dependencies
- Updated Rails configuration to the Rails 8.1 defaults
- Updated migration and schema format
- Replaced deprecated `form_for` usage with `form_with`
- Replaced Rails UJS delete links with regular `button_to` forms
- Removed insecure/obsolete parameter patterns such as allowing `phone_id` to be changed through a variant update
- Reworked controller specs as request specs
- Migrated Factory Girl syntax to Factory Bot
- Fixed the stale `competitor_price` test that referenced a field no longer present in the application
- Refreshed the admin UI using the existing Rails server-rendered architecture

The application remains intentionally small and server-rendered; the original business requirements did not justify adding a frontend framework or an API-only architecture.
