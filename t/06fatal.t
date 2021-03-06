# -*- encoding: utf-8; indent-tabs-mode: nil -*-
#
#     t/06fatal.t - checking the error messages (using Test::Fatal)
#     Test script for DateTime::TimeZone::LMT
#     Copyright (C) 2016 Rick Measham and Jean Forget
#
#     This program is distributed under the same terms as Perl 5.16.3:
#     GNU Public License version 1 or later and Perl Artistic License
#
#     You can find the text of the licenses in the F<LICENSE> file or at
#     L<http://www.perlfoundation.org/artistic_license_1_0>
#     and L<http://www.gnu.org/licenses/gpl-1.0.html>.
#
#     Here is the summary of GPL:
#
#     This program is free software; you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation; either version 1, or (at your option)
#     any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with this program; if not, write to the Free Software Foundation,
#     Inc., <http://www.fsf.org/>.
#

use strict;
use warnings;
use Test::More;
use DateTime::TimeZone::LMT;

BEGIN {
  eval "use Test::Fatal qw(dies_ok)";
  plan skip_all => "Test::Fatal needed"
    if $@;
}

plan(tests => 7);
dies_ok { my $tz = DateTime::TimeZone::LMT->new(                     ); } "Longitude is mandatory";
dies_ok { my $tz = DateTime::TimeZone::LMT->new( longitude => 'zero' ); } "Longitude must be numeric";
dies_ok { my $tz = DateTime::TimeZone::LMT->new( longitude =>  181   ); } "Longitude must be <=  180";
dies_ok { my $tz = DateTime::TimeZone::LMT->new( longitude => -181   ); } "Longitude must be >= -180";

my $tz = DateTime::TimeZone::LMT->new( longitude => 50 );
dies_ok { $tz->longitude('zero'); } "Longitude must be numeric";
dies_ok { $tz->longitude(  -181); } "Longitude must be >= -180";
dies_ok { $tz->longitude(  +181); } "Longitude must be <=  180";
