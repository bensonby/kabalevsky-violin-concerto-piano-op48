\version "2.18.2"
\include "articulate.ly"
#(set-global-staff-size 15)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  http://lsr.di.unimi.it/LSR/Item?id=445

%LSR by Jay Anderson.
%modyfied by Simon Albrecht on March 2014.
%=> http://lilypond.1069038.n5.nabble.com/LSR-445-error-td160662.html

#(define (octave-up m t)
 (let* ((octave (1- t))
      (new-note (ly:music-deep-copy m))
      (new-pitch (ly:make-pitch
        octave
        (ly:pitch-notename (ly:music-property m 'pitch))
        (ly:pitch-alteration (ly:music-property m 'pitch)))))
  (set! (ly:music-property new-note 'pitch) new-pitch)
  new-note))

#(define (octavize-chord elements t)
 (cond ((null? elements) elements)
     ((eq? (ly:music-property (car elements) 'name) 'NoteEvent)
       (cons (car elements)
             (cons (octave-up (car elements) t)
                   (octavize-chord (cdr elements) t))))
     (else (cons (car elements) (octavize-chord (cdr elements ) t)))))

#(define (octavize music t)
 (if (eq? (ly:music-property music 'name) 'EventChord)
       (ly:music-set-property! music 'elements (octavize-chord
(ly:music-property music 'elements) t)))
 music)

makeOctaves = #(define-music-function (parser location arg mus) (integer? ly:music?)
 (music-map (lambda (x) (octavize x arg)) (event-chord-wrap! mus)))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cr = \change Staff = "right"
cl = \change Staff = "left"
rhMark = \markup { 
  \path #0.1 #'((moveto -1 0)(rlineto 0 -1.5)(rlineto 0.5 0))
}

\header {
  title = "Kabalevsky - Violin Concerto Op48"
  subtitle = "For violin and piano accompaniment"
  arranger = "As edited by Josef Gingold"
  composer = "Dmitri Kabalevsky"
}

upper-prelude = \relative c'' {
  <g b e g>4-> g8\( fis g fis g2.\)->
  <g bes ees g>4-> g8\( fis g fis g2.\)->
  <g b e g>4-> g8( fis g4)
  <g bes ees g>4-> g8( fis g4)
  <g b e g>4 e b
  g4 r r
}

lower-prelude = \relative c {
  <g e' b'>4-> r r
  R2.
  <g ees' bes'>4-> r r
  R2.
  <g e' b'>4-> r r
  <g ees' bes'>4-> r r
  <g e' b'>4-> r r
  r4 e' g,
}

dynamics-prelude = {
  s2.\f s2.*6 s4\> s4 s4\!
}

upper-one = \relative c' {
  <c e c'>4-. r r
  <d f c'>4-. r r
  <c e c'>4-. r r
  <d f c'>4-. r r
  <ees aes c>4-. r r
  e8\( d c d e f <ees aes c>4-.\) r r
  e8\( d c d e f fis f ees f fis gis a4-.\) aes-. b-. c-. d-. dis-.
}

upper-two = \relative c'' {
  e4-- s4 s4
  <c, e g>4-. q-. q-. q-. q-. q-.
  <c e a>4-. q-. q-.
  <c d a'>4-. q-. q-.
  <c f a>4-- r r
  q4-. r r
  <b e g>4-. r r
  c'4-> g-> e-> c-> g-> r
}

upper-three = \relative c' {
  <c e c'>4-.-> r r
  <d f c'>4-. r r
  <c e c'>4-. r r
  <d f c'>4-. r r
  <ees aes c>4-. r r
  e8\( d c d e a <f a c>4-.\) r r
  fis8\( e d e fis a g4--\)
  g8\( f ees f ges2 bes4\)
  g4-- g8\( f ees f ges2 bes4\)
  c4-. cis-. d-. ees-. f-. fis-.
}

upper-four = \relative c''' {
  g4-- s4 s4
  <ees, g bes>4-. q-. q-. q-. q-. q-.
  <ees g c>4-. q-. q-.
  <ees f c'>4-. q-. q-.
  <ees aes c>4-- r r
  <ees aes c>4-- r r
  <d g bes>4-- r r
  <aes ces ees>4-. q-. q-. r q-. q-.
  r4 <ges bes ees>-. q-.
}

upper-five = \relative c' {
  <bes ees ges>4-. q-. r
  <ces ees ges>4-. q-. r
  <c ees ges>4-. q-. r
  <ces ees ges>4-. q-. r
  <bes ees ges>4-. q-. r
  <ces ees ges>4-. q-. r
  <c ees ges>4-. q-. r
  <c ees g>4-. q-. r
}

upper-six = \relative c' {
  <c ges'>4-. r <c ges' aes>-.
  <c ges' a>4-. r <c ges' aes>-.
  <c ges' a>4-. r <c ges' b>-.
  <c ges' c>4-. r <c ges' a>-.
  <ees a>4-. r <ees a b>-.
  <ees a c>4-. r <ees a b>-.
  <ees a c>4-. r <ees a d>-.
  <ees a ees'>4-. r <ees a c>-.
  <ees a ees'>4-. r <ees a c>-.
  <ees a ees'>4-. r <ees a c>-.
  <e a e'>4-. <e a c>-. <f a f'>-.
}

upper-seven = \relative c' {
  <fis b d fis>4-> r r
  <fis b d fis>4 r r
  <fis b d fis>4 r r
  <g bes ees g>4 r r
  R2.
  <g bes ees g>4 r r
  r4 r4 <g bes ees g>4
  <g c e g>4 r r
  R2. R2.
}

upper-eight = \relative c' {
  \key g \minor
  <g bes d g>4->
  <bes d>8\( <a cis> <bes d> <a cis> <bes d>4\)->
  <bes d>8\( <a cis> <bes d> <a cis> <bes d>4\)
  <a cis>4 <bes d> <a cis> <bes d> <a cis>
  <g bes d>4->
  <bes d>8\( <a cis> <bes d> <a cis> <bes d>4\)->
  <bes d>8\( <a cis> <bes d> <a cis> <bes d>4\)
  <a cis>4 <bes d> <a cis> <bes d> <a cis>
}

upper-nine = \relative c' {
  <g bes d>4-- r r
  <g d' g>4 r r q r q r q r
  <g c g'>4 r r q r r
  <g d' g>4 r <g ees' g> r <g f' g> r
  <g bes d>4->
  <bes d>8( <a cis> <bes d> <a cis> <bes d>4)
  <a cis>4 <bes d>
}

upper-ten = \relative c' {
  <a cis>4( <bes d>) r
  <g d' g>4 r r q r q r q r
  <g c g'>4 r r q r r
  <b d>4-> q8( <ais cis> <b d> <ais cis>)
  <bes d>4-> q8( <a cis> <bes d> <a cis>)
  <b d>4-> q8( <ais cis> <b d> <ais cis>)
  <bes d>4-> q8( <a cis> <bes d> <a cis>)
}

upper-eleven = \relative c' {
  << {
    <bes d g>4( <g bes d>) r
    <bes d g>4( <g bes d>) r
    <bes ees g>4( g) q( g) q( g)
    <bes d g>( <g bes d>) r
    <bes d g>( <g bes d>) r
    <bes ees g>4-- bes8( a bes a)
  } \\ {
    \tiny
    % \stemNeutral
    g'2.~ g2.~ g2.~ g2.~ g2.~ g2.~ g8 r8
  } >>
  \normalsize
  <bes, ees g>4-- bes8( a bes a)
}

upper-twelve = \relative c' {
  <bes ees g>4-- r r
  <bes d g>4( <g bes d>) r
  \repeat unfold 3 { <bes d g>4( g) }
  <bes c g'>4( g) r
  <c d g>4( a) r
  <b d g>4-- <b d>8( <bes e> <b d> <bes e>)
  <bes d>4-- q8( <a ees'> <bes d> <a ees'>)
  <b d>4-- r q-- r q-- r
  <bes d g>4--( fis'8 g d4~ d) e-. fis-.
}

upper-thirteen = \relative c' {
  <b d g>4-- <b d>8( <bes e> <b d> <bes e>)
  <bes d>4-- q8( <a ees'> <bes d> <a ees'>)
  <b d>4-- r q-- r q-- r
  <bes d g>4--( fis'8 g d4~ d) e-. << {
    s4 ees'4-- d8 ees bes4~ bes c4-. cis-.
  } \\ {
    \stemNeutral
    fis,4~
    \stemDown
    fis2.~ fis
  } >>
  <g b d>4-- r r
  <g' b d>4-- r r
  <g, b d>2.--~ q4 r r
}

upper-fourteen = \relative c' {
  \key c \major
  \repeat unfold 6 { <b d>4-. r r }
  d4-. r r
  <b d>4-. r r
  \repeat unfold 2 { <b d>4-. r r <b dis>-. r r }
}

upper-fifteen = \relative c' {
  \repeat unfold 6 { <c e>4-. r r }
  <b dis b'>4--( ais'8 b fis4~ fis) gis-. ais
  <b b'>4--( ais'8 b fis4) gis-. ais-. b-.
}

upper-sixteen = \relative c'' {
  <c a' c>4-> r r <e,, c' e>-> r r
  <c' e a>4-. gis'-. a-.
  <e d gis,>4-. fis-. gis-.
  <a e c>4-. gis-. a-.
  <b e, d>4-. a-. b-.
  <c e,>4-. b-. a-.
  <cis e,>4-. r e-.
  <c e,>4-. b-. a-.
  <cis e,>4-. r a-.
}

upper-seventeen = \relative c' {
  <d bes'>4-. a'-. g-. a-. bes-. c-.
  <cis e,>4-. c-. bes-. c-. cis-. dis-.
  <e g,>4-. dis-. e-. fis-. g-. gis-.
  <a, cis a'>4--( gis8 a e4~ e) fis4-. gis-.
  <a a'>4--( gis'8 a e4) fis-. g-. gis-.
}

upper-eighteen = \relative c'' {
  <c f a>4-> b8( c b c d4)
  c8( b c b c4)
  b8( c b c d4)
  c8( b c b c4)
  d8( e f g a4)
  a8( g f e f4.)
  g8\( f e d c d c d e\)
  f2.\(~ f4 e d a2.~ a4\)
}
upper-ninteen = \relative c'' {
  d4\( e f d a' d2 c4 d2.~ d2\)
  d4\( ees4. f8 ees d ees bes g ees bes g
  <ees bes>4\)
}

upper-twenty = \relative c'' {
  r4 r
  ees4( d8 ees bes4~ bes) c-. d-.
  ees4( ges) f-.
  <ees ees'>4( d'8 ees bes4~ bes) c-. d-.
  ees-. d8( ees f fis g4--)
}

upper-twentyone = \relative c {
  r4 r
}
upper-twentytwo = \relative c { }
upper-twentythree = \relative c { }
upper-twentyfour = \relative c { }
upper-twentyfive = \relative c { }
upper-twentysix = \relative c { }
upper-twentyseven = \relative c { }
upper-twentyeight = \relative c { }
upper-twentynine = \relative c { }
upper-thirty = \relative c { }
upper-thirtyone = \relative c { }
upper-thirtytwo = \relative c { }
upper-thirtythree = \relative c { }
upper-thirtyfour = \relative c { }
upper-thirtyfive = \relative c { }
upper-thirtysix = \relative c { }
upper-thirtyseven = \relative c { }
upper-thirtyeight = \relative c { }
upper-thirtynine = \relative c { }
upper-forty = \relative c { }

lower-one = \relative c, {
  <c g' e'>4-. r r
  <c g' f'>4-. r r
  <c g' e'>4-. r r
  <c g' f'>4-. r r
  <c g' ees'>4-. r r
  R2.
  <c g' ees'>4-. r r
  R2. R2.
  \clef treble
  <c'' d fis>4-. \repeat unfold 5 { <c d fis a>4-. }
}

lower-two = \relative c' {
  << { <e g>4 \cr q-. q-. } \\ { \cl c2. } >>
  \clef bass
  g2.-- e2.-- c2.-- f,2.--
  r4 <d' a'>-. g,-.
  r4 <d' a'>-. g,-.
  r4 <e' g>-. g,-.
  c'4-> g-> e-> c-> g-> e
}
lower-three = \relative c { }
lower-four = \relative c { }
lower-five = \relative c { }
lower-six = \relative c { }
lower-seven = \relative c { }
lower-eight = \relative c { }
lower-nine = \relative c { }
lower-ten = \relative c { }
lower-eleven = \relative c { }
lower-twelve = \relative c { }
lower-thirteen = \relative c { }
lower-fourteen = \relative c { }
lower-fifteen = \relative c { }
lower-sixteen = \relative c { }
lower-seventeen = \relative c { }
lower-eighteen = \relative c { }
lower-ninteen = \relative c { }
lower-twenty = \relative c { }
lower-twentyone = \relative c { }
lower-twentytwo = \relative c { }
lower-twentythree = \relative c { }
lower-twentyfour = \relative c { }
lower-twentyfive = \relative c { }
lower-twentysix = \relative c { }
lower-twentyseven = \relative c { }
lower-twentyeight = \relative c { }
lower-twentynine = \relative c { }
lower-thirty = \relative c { }
lower-thirtyone = \relative c { }
lower-thirtytwo = \relative c { }
lower-thirtythree = \relative c { }
lower-thirtyfour = \relative c { }
lower-thirtyfive = \relative c { }
lower-thirtysix = \relative c { }
lower-thirtyseven = \relative c { }
lower-thirtyeight = \relative c { }
lower-thirtynine = \relative c { }
lower-forty = \relative c { }

dynamics-one = {
  s2.\mf s2.*10
}

dynamics-two = {
  s2.*8 s2.\f s2.
}
dynamics-three = { }
dynamics-four = { }
dynamics-five = { }
dynamics-six = { }
dynamics-seven = { }
dynamics-eight = { }
dynamics-nine = { }
dynamics-ten = { }
dynamics-eleven = { }
dynamics-twelve = { }
dynamics-thirteen = { }
dynamics-fourteen = { }
dynamics-fifteen = { }
dynamics-sixteen = { }
dynamics-seventeen = { }
dynamics-eighteen = { }
dynamics-ninteen = { }
dynamics-twenty = { }
dynamics-twentyone = { }
dynamics-twentytwo = { }
dynamics-twentythree = { }
dynamics-twentyfour = { }
dynamics-twentyfive = { }
dynamics-twentysix = { }
dynamics-twentyseven = { }
dynamics-twentyeight = { }
dynamics-twentynine = { }
dynamics-thirty = { }
dynamics-thirtyone = { }
dynamics-thirtytwo = { }
dynamics-thirtythree = { }
dynamics-thirtyfour = { }
dynamics-thirtyfive = { }
dynamics-thirtysix = { }
dynamics-thirtyseven = { }
dynamics-thirtyeight = { }
dynamics-thirtynine = { }
dynamics-forty = { }

upper = \relative c' {
  \clef treble
  \tempo "Allegro molto e con brio" 2. = 112
  \time 3/4
  \key c \major
  \upper-prelude
  \upper-one
  \upper-two
  \upper-three
  \upper-four
  \upper-five
  \upper-six
  \upper-seven
  \upper-eight
  \upper-nine
  \upper-ten
  \upper-eleven
  \upper-twelve
  \upper-thirteen
  \upper-fourteen
  \upper-fifteen
  \upper-sixteen
  \upper-seventeen
  \upper-eighteen
  \upper-ninteen
  \upper-twenty
  \upper-twentyone
  \upper-twentytwo
  \upper-twentythree
  \upper-twentyfour
  \upper-twentyfive
  \upper-twentysix
  \upper-twentyseven
  \upper-twentyeight
  \upper-twentynine
  \upper-thirty
  \upper-thirtyone
  \upper-thirtytwo
  \upper-thirtythree
  \upper-thirtyfour
  \upper-thirtyfive
  \upper-thirtysix
  \upper-thirtyseven
  \upper-thirtyeight
  \upper-thirtynine
  \upper-forty
  \bar "|."
}

lower = \relative c {
  \clef bass
  \time 3/4
  \key c \major
  \lower-prelude
  \lower-one
  \lower-two
  \lower-three
  \lower-four
  \lower-five
  \lower-six
  \lower-seven
  \lower-eight
  \lower-nine
  \lower-ten
  \lower-eleven
  \lower-twelve
  \lower-thirteen
  \lower-fourteen
  \lower-fifteen
  \lower-sixteen
  \lower-seventeen
  \lower-eighteen
  \lower-ninteen
  \lower-twenty
  \lower-twentyone
  \lower-twentytwo
  \lower-twentythree
  \lower-twentyfour
  \lower-twentyfive
  \lower-twentysix
  \lower-twentyseven
  \lower-twentyeight
  \lower-twentynine
  \lower-thirty
  \lower-thirtyone
  \lower-thirtytwo
  \lower-thirtythree
  \lower-thirtyfour
  \lower-thirtyfive
  \lower-thirtysix
  \lower-thirtyseven
  \lower-thirtyeight
  \lower-thirtynine
  \lower-forty
  \bar "|."
}

dynamics = {
  \dynamics-prelude
  \dynamics-one
  \dynamics-two
  \dynamics-three
  \dynamics-four
  \dynamics-five
  \dynamics-six
  \dynamics-seven
  \dynamics-eight
  \dynamics-nine
  \dynamics-ten
  \dynamics-eleven
  \dynamics-twelve
  \dynamics-thirteen
  \dynamics-fourteen
  \dynamics-fifteen
  \dynamics-sixteen
  \dynamics-seventeen
  \dynamics-eighteen
  \dynamics-ninteen
  \dynamics-twenty
  \dynamics-twentyone
  \dynamics-twentytwo
  \dynamics-twentythree
  \dynamics-twentyfour
  \dynamics-twentyfive
  \dynamics-twentysix
  \dynamics-twentyseven
  \dynamics-twentyeight
  \dynamics-twentynine
  \dynamics-thirty
  \dynamics-thirtyone
  \dynamics-thirtytwo
  \dynamics-thirtythree
  \dynamics-thirtyfour
  \dynamics-thirtyfive
  \dynamics-thirtysix
  \dynamics-thirtyseven
  \dynamics-thirtyeight
  \dynamics-thirtynine
  \dynamics-forty
}

violin-prelude = \relative c'' {
  R2. R2. R2. R2. R2. R2. R2. R2.
}

violin = \relative c' {
  \clef treble
  \time 3/4
  \key c \major
  \violin-prelude
  \bar "|."
}

\score {
  <<
    \new Staff = "violin-staff" {
      \set Staff.midiInstrument = #"violin"
      \set Staff.instrumentName = #"Violin"
      \set Staff.midiMinimumVolume = #0.4
      \set Staff.midiMaximumVolume = #0.3
      \violin
    }
    \new PianoStaff <<
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        \upper
      }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        \lower
      }
    >>
  >>
  \layout {
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      \Staff \RemoveEmptyStaves
    }
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      % \Dynamics \RemoveEmptyStaves
    }
    \context {
      \Score
      % Remove all-rest staves also in the first system
      \override VerticalAxisGroup.remove-first = ##t
      % If only one non-empty staff in a system exists, still print the starting bar
      \override SystemStartBar.collapse-height = #1
    }
    \context {
      \ChordNames
      \override ChordName #'font-size = #-3
    }
  }
  \midi {
    \context {
      \ChordNameVoice \remove Note_performer
    }
  }
}

