package Bencher::Scenario::ComparingArrays;

# DATE
# VERSION

use strict;
use warnings;

sub _loop {
    my $a1 = shift;
    my $a2 = shift;
    return 0 unless @$a1 == @$a2;
    for (0..$#{$a1}) { return 0 if $a1->[$_] != $a2->[$_] }
    1;
}

sub _loopstr {
    my $a1 = shift;
    my $a2 = shift;
    return 0 unless @$a1 == @$a2;
    for (0..$#{$a1}) { return 0 if $a1->[$_] ne $a2->[$_] }
    1;
}

our $scenario = {
    summary => 'Modules that compare arrays',
    modules => {
        'Data::Cmp' => 0.002,
    },
    participants => [
        {
            module => 'Data::Cmp',
            fcall_template => 'Data::Cmp::cmp_data(<array1>, <array2>)',
            tags => ["int","str"],
        },
        {
            module => 'Array::Compare',
            code_template => 'Array::Compare->new()->compare(<array1>, <array2>)',
            tags => ["int","str"],
        },
        {
            module => 'Arrays::Same',
            fcall_template => 'Arrays::Same::arrays_same_i(<array1>, <array2>)',
            tags => ["int"],
        },
        {
            module => 'Arrays::Same',
            fcall_template => 'Arrays::Same::arrays_same_s(<array1>, <array2>)',
            tags => ["str"],
        },
        {
            name => 'num eq op loop',
            code_template => __PACKAGE__.'::_loop(<array1>, <array2>)',
            tags => ["int"],
        },
        {
            name => 'str eq op loop',
            code_template => __PACKAGE__.'::_loopstr(<array1>, <array2>)',
            tags => ["str"],
        },
    ],

    datasets => [
        {name=>'empty'        , args=>{array1=>[], array2=>[]}},
        {name=>'10-int-same'  , args=>{array1=>[1..10], array2=>[1..10]}, include_participant_tags=>["int"]},
        {name=>'10-str-same'  , args=>{array1=>[("a")x 10], array2=>[("a")x 10]}, include_participant_tags=>["str"]},
        {name=>'100-int-same' , args=>{array1=>[1..100], array2=>[1..100]}, include_participant_tags=>["int"]},
        {name=>'100-str-same' , args=>{array1=>[("a")x 100], array2=>[("a")x 100]}, include_participant_tags=>["str"]},
        {name=>'1000-int-same', args=>{array1=>[1..1000], array2=>[1..1000]}, include_participant_tags=>["int"]},
        {name=>'1000-str-same', args=>{array1=>[("a")x 1000], array2=>[("a")x 1000]}, include_participant_tags=>["str"]},
    ],
};

1;
# ABSTRACT:
