# chef-klaus

[![Build Status](https://travis-ci.org/cmur2/chef-klaus.png)](https://travis-ci.org/cmur2/chef-klaus)

## Description

Installs [klaus](https://github.com/jonashaag/klaus) (the git web viewer) via pip (and therefore python and pip) and configures it from `node['klaus']`.

## Usage

Use `recipe[klaus::default]` for installing and configuring klaus, including an init script for Debian containing the minimalistic configuration parameters for klaus. No logfile support.

## Requirements

### Platform

It should work on all systems providing Python and pip.

For supported Chef/Ruby version see [Travis](https://travis-ci.org/cmur2/chef-klaus).

## Recipes

### default

It is required to define `node['klaus']['repositories']` in order to provide klaus at least one repository to serve.

Instead of manually applying the above one can use `node['klaus']['projects_list_path']` and `node['klaus']['projects_root_path']` to take advantage of the *projects.list* support in the cookbook, which automatically populates `node['klaus']['repositories']` with the contents of a specified *projects.list* with a given project root directory prepended.

Optional configuration: `node['klaus']['host']` sets the listen address for klaus, `node['klaus']['port']` the port. `node['klaus']['sitename']` the title for humans. `node['klaus']['smarthttp']` enables smart HTTP when `true`. `node['klaus']['htdigest']` may contain a htdigest file path.

## License

chef-klaus is licensed under the Apache License, Version 2.0. See LICENSE for more information.
