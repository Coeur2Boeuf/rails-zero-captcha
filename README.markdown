# Zero Captcha

**The simplest way to add a zero friction captcha in your Rails forms.**

A zero captcha works off the idea that most simple bots do not run a full
JavaScript interpreter when crawling web forms, so they are unable to fill a 
required field whereas the required field is actually hidden and autopopulated
by JavaScript in a real browser with a real human. This means having a layer of
spam protection while maintaining zero friction.

This should not be used solely by itself, but can be useful as an extra layer
of defense alongside honeypot captchas and/or more traditional captchas.

## Requirements

Requires Rails 5+

## Installation

In your Gemfile, simply add

    gem 'zero-captcha'

## Usage

### form_for

Simply specify that the form has a honeypot in the HTML options hash:

    <% form_for Comment.new, html: { zero_captcha: true } do |form| -%>
      ...
    <% end -%>

### form_tag with block

Simply specify that the form has a honeypot in the options hash:

    <% form_tag comments_path, zero_captcha: true do -%>
      ...
    <% end -%>

### form_tag without block

Simply specify that the form has a honeypot in the options hash:

    <%= form_tag comments_path, zero_captcha: true -%>
      ...
    </form>

## Additional Usage

By default, zero-captcha works by checking against a verify value __if__ provided. If not provided, zero captcha will not activate.

However, if you wish to force the presence of a zero-captcha value, you may use this in your controller:

`prepend_before_filter :require_zero_captcha, only: [:create]`


## Copyright

See LICENSE for details.
