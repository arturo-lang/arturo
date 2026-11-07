#!/usr/bin/env perl
# temporary: compare package scripts between two arturo binaries
# usage: compare.pl PKGDIR HOMEDIR BIN_A BIN_B OUTDIR [skip-file...]
use strict; use warnings;
use File::Find;
use File::Path qw(make_path);
use File::Basename;
use Cwd qw(abs_path);

my ($pkgdir, $home, $binA, $binB, $out, @skip) = @ARGV;
$pkgdir = abs_path($pkgdir); $home = abs_path($home);
$binA = abs_path($binA); $binB = abs_path($binB);
make_path($out); $out = abs_path($out);
my %skip = map { $_ => 1 } @skip;

# PATH dirs, so that `arturo` called by name is the binary under test
my %pathdir;
for my $b ([$binA, "a"], [$binB, "b"]) {
    my $d = "$out/path-$b->[1]";
    make_path($d);
    unlink "$d/arturo";
    symlink $b->[0], "$d/arturo";
    $pathdir{$b->[0]} = $d;
}

sub run {
    my ($bin, $root, $file) = @_;
    my $pid = open(my $fh, "-|") // die;
    if ($pid == 0) {
        chdir $root;
        open(STDIN, "<", "/dev/null");
        open(STDERR, ">&", \*STDOUT);
        $ENV{HOME} = $home;
        $ENV{PATH} = "$pathdir{$bin}:$ENV{PATH}";
        $ENV{NO_COLOR} = 1;
        alarm 30;
        exec($bin, "--no-color", $file) or exit 127;
    }
    local $/; my $o = <$fh> // ""; close $fh;
    my $rc = $? & 127 ? "sig" . ($? & 127) : $? >> 8;
    $o =~ s/\e\[[0-9;]*m//g;
    $o =~ s/\d+(\.\d+)?\s*(ms|s|µs|ns)\b/<T>/g;     # timings
    $o =~ s/\b\d{4}-\d\d-\d\dT[\d:.]+\S*/<DATE>/g;   # timestamps
    return ($rc, $o);
}

my @files;
opendir(my $dh, $pkgdir) or die;
for my $pkg (sort grep { !/^\./ && -d "$pkgdir/$_" } readdir $dh) {
    find({ no_chdir => 1, wanted => sub {
        return unless /\.art$/;
        (my $rel = $File::Find::name) =~ s{^\Q$pkgdir/$pkg/\E}{};
        return if $skip{"$pkg/$rel"};
        push @files, [$pkg, $rel];
    }}, "$pkgdir/$pkg");
}

my ($same, $diff, $flaky) = (0, 0, 0);
my @report;
for my $f (@files) {
    my ($pkg, $rel) = @$f;
    my $root = "$pkgdir/$pkg";
    my ($ra, $oa) = run($binA, $root, $rel);
    my ($rb, $ob) = run($binB, $root, $rel);
    if ($ra eq $rb && $oa eq $ob) { $same++; next; }
    # re-run to tell real differences from nondeterministic output
    my ($ra2, $oa2) = run($binA, $root, $rel);
    my ($rb2, $ob2) = run($binB, $root, $rel);
    if ($ra2 ne $ra || $oa2 ne $oa || $rb2 ne $rb || $ob2 ne $ob) {
        $flaky++;
        push @report, "FLAKY  $pkg/$rel (rc $ra/$rb)";
        next;
    }
    $diff++;
    (my $tag = "$pkg/$rel") =~ s{/}{__}g;
    open(my $h, ">", "$out/$tag.a") or die; print $h "rc: $ra\n$oa"; close $h;
    open($h, ">", "$out/$tag.b") or die; print $h "rc: $rb\n$ob"; close $h;
    push @report, "DIFF   $pkg/$rel (rc $ra/$rb)";
}

print "$_\n" for @report;
printf "files: %d  same: %d  different: %d  nondeterministic: %d\n", scalar(@files), $same, $diff, $flaky;
exit($diff ? 1 : 0);
