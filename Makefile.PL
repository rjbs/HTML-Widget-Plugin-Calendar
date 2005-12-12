use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'HTML::Widget::Plugin::Calendar',
    AUTHOR              => 'Ricardo Signes <rjbs@cpan.org>',
    VERSION_FROM        => 'lib/HTML/Widget/Plugin/Calendar.pm',
    ABSTRACT_FROM       => 'lib/HTML/Widget/Plugin/Calendar.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'HTML-Widget-Plugin-Calendar-* cover_db' },
);
