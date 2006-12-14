package HTML::Widget::Plugin::Calendar;
use base qw(HTML::Widget::Plugin Class::Data::Inheritable);

use warnings;
use strict;

use HTML::Element;
use HTML::TreeBuilder;
use Data::JavaScript::Anon;

=head1 NAME

HTML::Widget::Plugin::Calendar - simple construction of jscalendar inputs

=head1 VERSION

version 0.010

 $Id$

=cut

our $VERSION = '0.010';

=head1 SYNOPSIS

  $factory->calendar({
    name   => 'date_of_birth',
    format => '%Y-%m-%d',
    value  => $user->date_of_birth,
  });

=head1 DESCRIPTION

This module plugs in to HTML::Widget::Factory and provides a calendar widget
using the excellent jscalendar.

=head1 METHODS

=head2 C< provided_widgets >

This plugin provides the following widgets: calendar

=cut

sub provided_widgets { qw(calendar) }

=head2 calendar

=cut

sub calendar {
  my ($self, $factory, $arg) = @_;
  $arg->{attr}{name} ||= $arg->{attr}{id}; 
  
  Carp::croak "you must supply a widget id for calendar"
    unless $arg->{attr}{id};

  $arg->{jscalendar} ||= {};
  $arg->{jscalendar}{showsTime} = 1 if $arg->{time};

  $arg->{format}
    ||= '%Y-%m-%d' . ($arg->{jscalendar}{showsTime} ? ' %H:%M' : '');
  
  my $widget = HTML::Element->new('input');
  $widget->attr($_ => $arg->{attr}{$_}) for keys %{ $arg->{attr} };
  $widget->attr(value => $arg->{value}) if exists $arg->{value};

  my $button;

  unless ($arg->{no_button}) {
    $button = HTML::Element->new(
      'button',
      id => $arg->{attr}{id} . "_button"
    );
    $button->push_content($arg->{button_label} || '...');
  }

  my $script = HTML::Element->new('script', type => 'text/javascript');
  my $js
    = sprintf "Calendar.setup(%s);",
      Data::JavaScript::Anon->anon_dump({
        inputField => $widget->attr('id'),
        ifFormat   => $arg->{format},
        ($arg->{no_button} ? () : (button => $button->attr('id'))),
        %{ $arg->{jscalendar} },
      })
    ;

  # we need to make this an HTML::Element literal to avoid escaping the JS
  $js = HTML::Element->new('~literal', text => $js);
        
  $script->push_content($js);

  return join q{},
    $self->calendar_js($factory, $arg),
    map { $_->as_XML } ($widget, ($arg->{no_button} ? () : $button), $script),
  ;
}

=head2 C< calendar_js >

=cut

sub calendar_js {
  my ($self, $factory, $arg) = @_;
  
  return '' if $factory->{$self}->{output_js}++;
  
  my $base = $self->calendar_baseurl;
  Carp::croak "calendar_baseurl is not defined" if not defined $base;

  $base =~ s{/\z}{}; # to avoid baseurl//yourface or baseurlyourface

  my $scripts = <<END_HTML;
  <script type="text/javascript" src="$base/calendar.js"></script>
  <script type="text/javascript" src="$base/lang/calendar-en.js"></script>
  <script type="text/javascript" src="$base/calendar-setup.js"></script>
END_HTML

}

=head2 C< calendar_baseurl >

This method sets or returns the plugin's base URL for the jscalendar files.
This must be set or calendar plugin creation will throw an exception.

=cut

__PACKAGE__->mk_classdata( qw(calendar_baseurl) );

=head1 AUTHOR

Ricardo SIGNES, C<< <rjbs@cpan.org> >>

Development of this code in 2005 and 2006 was sponsored by Listbox.

=head1 BUGS

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically be
notified of progress on your bug as I make changes.

=head1 COPYRIGHT

Copyright 2005-2006 Ricardo SIGNES, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
