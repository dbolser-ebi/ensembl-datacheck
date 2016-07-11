#!/usr/bin/env perl
use warnings;
use strict;
use Bio::EnsEMBL::DataTest::BaseTest;
use Test::More;
use Data::Dumper;
use Bio::EnsEMBL::DataTest::Utils::TestUtils qw/run_test/;

BEGIN {
	use_ok( 'Bio::EnsEMBL::DataTest::BaseTest' );
}


my $test = Bio::EnsEMBL::DataTest::BaseTest->new(
  name => "mytest",
  test => sub {
    ok( 0 == 1, "Not OK!" );
  } );
  
ok($test,"Simple test OK");

my $will_test = $test->will_test();
ok($will_test, "will test ran");
is($will_test->{run}, 1, "Will run test");

my $res = run_test(sub {
  $test->run();
});
ok($res,"Test output OK");
diag(Dumper($res));
is(ref($res), 'HASH', "Is a hashref");

is($res->{pass}, 0, 'Failed');
is(scalar(@{$res->{details}}), 1, '1 detail');
is($res->{details}->[0]->{ok}, 0, 'Detail 1 not OK');

done_testing;