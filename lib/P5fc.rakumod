use v6.*;

unit module P5fc:ver<0.0.8>:auth<zef:lizmat>;

proto sub fc(|) is export {*}
multi sub fc(         --> Str:D) { (CALLERS::<$_>).fc }
multi sub fc(Str() $s --> Str:D) { $s.fc              }

=begin pod

=head1 NAME

Raku port of Perl's fc() built-in

=head1 SYNOPSIS

  use P5fc;

  say fc("FOOBAR") eq fc("FooBar"); # true

  with "ZIPPO" {
      say fc();  # zippo, may need to use parens to avoid compilation error
  }

=head1 DESCRIPTION

This module tries to mimic the behaviour of Perl's C<fc> built-in as
closely as possible in the Raku Programming Language..

=head1 ORIGINAL PERL 5 DOCUMENTATION

    fc EXPR
    fc      Returns the casefolded version of EXPR. This is the internal
            function implementing the "\F" escape in double-quoted strings.

            Casefolding is the process of mapping strings to a form where case
            differences are erased; comparing two strings in their casefolded
            form is effectively a way of asking if two strings are equal,
            regardless of case.

            Roughly, if you ever found yourself writing this

                lc($this) eq lc($that)    # Wrong!
                    # or
                uc($this) eq uc($that)    # Also wrong!
                    # or
                $this =~ /^\Q$that\E\z/i  # Right!

            Now you can write

                fc($this) eq fc($that)

            And get the correct results.

            Perl only implements the full form of casefolding, but you can
            access the simple folds using "casefold()" in Unicode::UCD and
            "prop_invmap()" in Unicode::UCD. For further information on
            casefolding, refer to the Unicode Standard, specifically sections
            3.13 "Default Case Operations", 4.2 "Case-Normative", and 5.18
            "Case Mappings", available at
            <http://www.unicode.org/versions/latest/>, as well as the Case
            Charts available at <http://www.unicode.org/charts/case/>.

            If EXPR is omitted, uses $_.

            This function behaves the same way under various pragma, such as
            within "use feature 'unicode_strings", as "lc" does, with the
            single exception of "fc" of LATIN CAPITAL LETTER SHARP S (U+1E9E)
            within the scope of "use locale". The foldcase of this character
            would normally be "ss", but as explained in the "lc" section, case
            changes that cross the 255/256 boundary are problematic under
            locales, and are hence prohibited. Therefore, this function under
            locale returns instead the string "\x{17F}\x{17F}", which is the
            LATIN SMALL LETTER LONG S. Since that character itself folds to
            "s", the string of two of them together should be equivalent to a
            single U+1E9E when foldcased.

            While the Unicode Standard defines two additional forms of
            casefolding, one for Turkic languages and one that never maps one
            character into multiple characters, these are not provided by the
            Perl core; However, the CPAN module "Unicode::Casing" may be used
            to provide an implementation.

            This keyword is available only when the "fc" feature is enabled,
            or when prefixed with "CORE::"; See feature. Alternately, include
            a "use v5.16" or later to the current scope.

=head1 PORTING CAVEATS

In future language versions of Raku, it will become impossible to access the
C<$_> variable of the caller's scope, because it will not have been marked as
a dynamic variable.  So please consider changing:

    fc;

to either:

    fc($_);

or, using the subroutine as a method syntax, with the prefix C<.> shortcut
to use that scope's C<$_> as the invocant:

    .&fc;

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/P5fc . Comments and
Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2018, 2019, 2020, 2021 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
