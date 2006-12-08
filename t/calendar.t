#!perl
use strict;
use warnings;

use Test::More 'no_plan';
BEGIN { use_ok('HTML::Widget::Factory'); }
BEGIN { use_ok('HTML::Widget::Plugin::Calendar'); }

my $factory = HTML::Widget::Factory->new;

can_ok($factory, 'calendar');

HTML::Widget::Plugin::Calendar->calendar_baseurl('/');

my $html = $factory->calendar({
  id     => 'birthday',
  format => '%Y-%d-%m',
});

