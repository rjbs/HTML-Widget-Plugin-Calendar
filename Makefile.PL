use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'HTML::Widget::Plugin::Calendar',
    AUTHOR              => 'Ricardo Signes <rjbs@cpan.org>',
    VERSION_FROM        => 'lib/HTML/Widget/Plugin/Calendar.pm',
    ABSTRACT_FROM       => 'lib/HTML/Widget/Plugin/Calendar.pm',
    (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'    => 0,
        'Class::Data::Inheritable' => 0,
        'Data::JavaScript::Anon'   => 0,
        'HTML::Element'            => 0, # required by HTML::Widget::Factory 
        'HTML::TreeBuilder'        => 0, # required by HTML::Widget::Factory
        'HTML::Widget::Factory'    => '0.04',
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'HTML-Widget-Plugin-Calendar-* cover_db' },
);
