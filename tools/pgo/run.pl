#!/usr/bin/env perl
# temporary: train & compare binaries, for measuring PGO on the CI
use strict; use warnings;
use Cwd qw(getcwd abs_path);
use File::Basename;
use Time::HiRes qw(time);

my $cmd = shift @ARGV;
my $here = dirname(abs_path($0));

sub run_limited {
    my ($limit, $bin, $file) = @_;
    my $pid = fork();
    if ($pid == 0) {
        open(STDIN,  "<", "/dev/null");
        open(STDOUT, ">", "/dev/null");
        open(STDERR, ">", "/dev/null");
        alarm $limit;
        exec($bin, $file) or exit 127;
    }
    waitpid($pid, 0);
    return $? >> 8;
}

if ($cmd eq "train") {
    my $bin = abs_path(shift @ARGV);
    my $root = getcwd();
    my ($ok, $bad) = (0, 0);
    for my $dir ("$here/train", "$root/tests/unittests") {
        chdir $dir or die "no $dir";
        for my $f (sort glob("*.art")) {
            if (run_limited(60, $bin, $f) == 0) { $ok++ } else { $bad++; print "  non-zero: $f\n"; }
        }
    }
    chdir $root;
    print "training runs: ok=$ok non-zero=$bad\n";
}
elsif ($cmd eq "bench") {
    my $reps = shift @ARGV;
    my @bins = map { abs_path($_) } @ARGV;
    my @names = map { (my $n = basename($_)) =~ s/\.exe$//; $n } @ARGV;
    chdir "$here/eval" or die;
    my @files = sort glob("*.art");
    my (%best, %rc);
    for my $r (1..$reps) {
        for my $f (@files) {
            for my $i (0..$#bins) {
                my $b = ($i + $r) % @bins;
                my $t = time;
                my $c = run_limited(120, $bins[$b], $f);
                my $d = time - $t;
                $best{$f}[$b] = $d if !defined $best{$f}[$b] || $d < $best{$f}[$b];
                $rc{$f}[$b] = $c;
            }
        }
    }
    my $out = "| snippet | " . join(" | ", @names) . " | change |\n|---|" . ("---|" x (@names + 1)) . "\n";
    my @tot = (0) x @bins;
    for my $f (@files) {
        (my $l = $f) =~ s/\.art$//;
        my @v = @{$best{$f}};
        $tot[$_] += $v[$_] for 0..$#v;
        my $flag = join("", map { $_ ? " rc=$_" : "" } @{$rc{$f}});
        $out .= sprintf("| %s%s | %s | %+.1f%% |\n", $l, $flag, join(" | ", map { sprintf("%.3f", $_) } @v), 100 * ($v[-1] - $v[0]) / $v[0]);
    }
    $out .= sprintf("| **TOTAL** | %s | **%+.1f%%** |\n", join(" | ", map { sprintf("%.2f", $_) } @tot), 100 * ($tot[-1] - $tot[0]) / $tot[0]);
    print $out;
    if (my $s = $ENV{GITHUB_STEP_SUMMARY}) {
        open(my $h, ">>", $s) or die;
        print $h $out;
        close $h;
    }
}
