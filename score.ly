\version "2.18.2"
\include "articulate.ly"
#(set-global-staff-size 14)

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
    <bes d g>4( <g bes d>) b'\rest
    <bes, d g>4( <g bes d>) b'\rest
    <bes, ees g>4( g) q( g) q( g)
    <bes d g>( <g bes d>) b'\rest
    <bes, d g>( <g bes d>) b'\rest
    <bes, ees g>4-- bes8( a bes a)
  } \\ {
    \tiny
    % \stemNeutral
    g'2.~ g2.~ g2.~ g2.~ g2.~ g2.~ g8 d'8\rest
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

upper-twentyone = \relative c'' {
  r4 r
  e4( dis8 e bes4~ bes) cis-. dis-.
  e4( g) fis-. <e e'>4( dis'8 e bes4~ bes) c-. cis-.
  dis4-. e-. fis-.
}
upper-twentytwo = \relative c''' {
  <g g'>8-> r e,8( dis e cis
  fis4) fis8\( e fis dis e dis e cis dis e fis e fis dis e fis
  g4\) g8( fis g e a4)
  a8\( g a fis g fis g e fis g a g a fis g a b\) r
  b8( ais b g c) r c( b c a cis) r
  cis8( bis cis ais d) r d( cis d b ees) r r4 r4
  R2.
}
upper-twentythree = \relative c' {
  <aes des aes'>8-> r des4-- ees--
  f2-- bes4-- aes2.~-- aes2 f4--
  ges2-- f4-- ees2-- des4--
  <c a f>4-> \breathe f4-- g-- a2-- d4--
  c2.~-- c2 a4-- bes2-- a4-- g2-- f4--
}
upper-twentyfour = \relative c' {
  <d fis a>4-> \breathe d4-- e--
  fis2-- a4-- d2.(-> a2.)
  <b, d>8-> r d4-- e-- fis-- b-- cis--
  d2.->( b2.) fis'2.->( b,2.)
}
upper-twentyfive = \relative c'' {
  \repeat unfold 2 {
    <b e g>4-> q8( fis q fis)
  }
  q4-> r r R2.
  \repeat unfold 2 {
    <bes ees g>4-> q8( fis q fis)
  }
  q4-> r r R2.
}
upper-twentysix = \relative c'' {
  \repeat unfold 2 {
    <b e g>4-> fis g
    <bes ees g>4-> fis g
  }
  <g b f' g>4-> r r R2.*5
}
upper-twentyseven = \relative c' {
  <c e c'>4-> b'8( c)
  << { g4~ g a b } \\ { s4 <f d>4 r r } >>
  <c e c'>4 b'8( c)
  << { \stemNeutral d4~ \stemUp d c d } \\ { s4 <d, f> r r } >>
  << {
    ees'4 ees8( d c d e2) c4 ees ees8( d c d e2) c4
    ees8( d c d ees f \stemNeutral <fis a,>4)
  } \\ {
    aes,2.->( g4) e8( f g4) aes2.->( g4) e8( f g4) aes2.
  } >>
  \makeOctaves 1 { g4 gis a ais b }
}
upper-twentyeight = \relative c'' {
  \makeOctaves 1 { c2.~-> c4 b a }
  <g g'>8( e' c e g gis
  <a a,>4) e <c c'>
  << { d2.-> } \\ { r4 <a d,> q } >>
  f'4-> f8( e d a) f'4 f8( e d a)
  g'8( f e d c b c4)-> g e c g r
}
upper-twentynine = \relative c' {
  <g c g'>4-. r r
  <g d' g>4-. r r
  <g ees' g>4-. r r
  <g f' g>4-. r r
  <aes ees' aes>4-. r r
  \repeat unfold 3 { <e' a c>-. }
  \repeat unfold 3 { <f a c>-. }
  \repeat unfold 3 { <fis a c>-. }
  g4-- g8( f ees f ges2 bes4)
  g4-- g8( f ees f ges4)
  aes4-. bes-. c-. d-. ees-. e-. f-. fis-.
}
upper-thirty = \relative c'' {
  <bes ees g>4 s2
  \repeat unfold 6 { <ees, g bes>4-. }
  \repeat unfold 3 { <ees g c>4 }
  \repeat unfold 3 { <ees f c'>4 }
  <ees aes c>4-- r r
  <ees aes c>4-- r r
  <d g bes>4-- r r
  ees'4-> bes-> g-> ees-> f-> fis->
  << { g4-> r f-> ees-> r d-> } \\ { <g, g'>2.~ q2. } >>
}
upper-thirtyone = \relative c' {
  \key c \minor
  <c ees g>4
  <ees g>8( <d fis> <ees g> <d fis> <ees g>4)->
  <ees g>8( <d fis> <ees g> <d fis> <ees g>4)
  <d fis>4 <ees g> <d fis> <ees g> <d fis>
  <ees g>4 r r r c( d ees c aes' g c2)
  r4 r ees,4( f2 ees4~ ees d c ees2.)
}
upper-thirtytwo = \relative c' {
  <c ees g>4->
  <ees g>8( <d fis> <ees g> <d fis> <ees g>4)
  <d fis>4 <ees g> <d fis>( <ees g>) r
  r4 c( d ees c aes' g2 c4 aes2.~ aes4)
  g4( f g2 d'4 <ees, g c>4->)
  \repeat unfold 2 { <d ees g>8( c) }
  q4->
  \repeat unfold 2 { <d ees g>8( c) }
}
upper-thirtythree = \relative c' {
  <ees aes>4->
  \repeat unfold 3 { aes8( ees aes c ees) r }
  aes,8( ees aes c des) r
  aes8( e aes c des) r
  aes8( e aes bes c) r
  \repeat unfold 3 { f,8( c f aes c) r }
}
upper-thirtyfour = \relative c' {
  f8( c f aes bes) r
  \repeat unfold 2 { f8( d f bes d) r }
  f,8( d f bes des) r
  f,8( des f bes c) r
  aes8( f aes c f) r
  c8( aes c f aes) r c4( f,)
  <c, ees c'>4-> ees8( c ees c)
  <c ees bes'>4-> ees8( c ees c)
  <c ees aes>4-> ees8( c ees c)
  <c ees ges>4-> ees8( c ees c)
}
upper-thirtyfive = \relative c' {
  <a c f>4->^"Piu mosso"
  <a c>8( <gis b> <a c> <gis b> <a c>4)
  <a c>8( <gis b> <a c> <gis b> <a c>4)
  <gis b>4 <a c> <gis b> <a c> <gis b>
  << {
    f'2.~ f~ f~ f
    f2.~ f~ f~ f
  } \\ {
    <f, aes c>4-. r r
    <f aes des>4-. r r
    <f aes d>4-. r r
    <f aes des>4-. r r
    <f aes c>4-. r r
    <f aes des>4-. r r
    <f aes d>4-. r r
    <f a c>4-. r r
  } >>
}
upper-thirtysix = \relative c' {
  <d aes'>4-. r <d aes' bes>-.
  <d aes' b>4-. r <d aes' bes>-.
  <d aes' b>4-. r <d aes' cis>-.
  <d aes' d>4-. r <d aes' b>-.
  <f b>4-. r <f b cis>-.
  <f b d>4-. r <f b cis>-.
  <f b d>4-. r <f b e>-.
  <f b f'>4-. r <f b d>-.
  <aes d f>4-. r <aes d g>-.
  <aes d aes'>4-. r <aes d f>-.
}
upper-thirtyseven = \relative c'' {
  <aes d aes'>4-. r <aes d f>-.
  <aes d aes'>4-. r <aes d f>-.
  <a d a'>4-. <a d f>-. <bes d bes'>-.
  \repeat unfold 4 { <b e b'>4 r r }
}
upper-thirtyeight = \relative c'' {
  \key c \major
  <c e g c>4-> b8( c b c)
  <c e g c>4-> b8( c b c)
  q4-> r r R2.
  <c e a c>4-> b8( c b c)
  <c e a c>4-> b8( c b c)
  q4-> r r R2.
}
upper-thirtynine = \relative c'' {
  <c ees aes c>4-> b c
  <c ees aes c>4-> b c
  <c fis a c>4-> b c
  <c fis a c>4-> b c
  <c f aes c>4-> b c
  <c f aes c>4-> b c
  <c e g c>4-> r r R2.
}
upper-forty = \relative c'' {
  <c e g c>4-> r r R2.
  c,4-> e-> g-> c-> e-> g->
  <c, c'>4-> r r
  <c e c'>4-> r r
  c,4-> r r R2.
}

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

lower-three = \relative c, {
  <c g' e'>4-.-> r r
  <c g' f'>4-.-> r r
  <c g' e'>4-.-> r r
  <c g' f'>4-.-> r r
  <c g' ees'>4-.-> r r
  R2.
  <c a' f'>4-.-> r r
  R2.
  <bes'' ees>4( ees,-.) ees-.
  <ces' ees>4-. q-.q-.
  <bes ees>4( ees,-.) ees-.
  <ces' ees>4-. q-.q-.
  \clef treble
  <ees f a>4-.
  \repeat unfold 5 { <ees f a c>4-. }
}

lower-four = \relative c'' {
  << { <g bes>4-. \cr q-. q-. } \\ { \cl ees2. } >>
  \clef bass
  bes2.-- g-- ees-- aes,--
  r4 <f' c'>4-. bes,-.
  r4 <f' c'>4-. bes,-.
  r4 <g' bes>4-. bes,-.
  ces2.\( f, ges\)
}

lower-five = \relative c {
  bes4-. r ees-.
  a,4-. r ees'-.
  aes,4-. r ees'-.
  a,4-. r ees'-.
  bes4-. r ees-.
  a,4-. r ees'-.
  aes,4-. r ees'-.
  a,4-. r ees'-.
}

lower-six = \relative c, {
  ees4-. ges'-. r
  d,4-. ges'-. r
  ees,4-. ges'-. r
  d,4-. ges'-. r
  \repeat unfold 3 {
    ges,4-. a'-. r
    f,4-. a'-. r
  }
  e,4-. c''-. ees,,-.
}

lower-seven = \relative c, {
  <d b' fis'>4-> r r
  q4 r r q4 r r
  <des aes' f'>4 r r
  R2.
  q4 r r r r q
  <c g' e'>4 r r
  R2.*2
}

lower-eight = \relative c {
  \key g \minor
  <d g,>4->
  d8( ees d ees q4)->
  d8( ees d ees q4)
  ees4 q ees q ees
  <d g,>4->
  d8( ees d ees q4)->
  d8( ees d ees q4)
  ees4 q ees q ees
}

lower-nine = \relative c {
  <d g,>4-- r r
  <d bes'>4( g,) r
  \repeat unfold 3 { <d' bes'>4( g,) }
  <ees' bes'>4( g,) r
  <ees' bes'>4( g,) r
  <f' bes>4( g,) <ees' bes'>( g,) <cis bes'>( g)
  <d' g,>4->
  d8( ees d ees q4)
}

lower-ten = \relative c {
  ees4 q ees( q) r
  <d bes'>4( g,) r
  \repeat unfold 3 { <d' bes'>4( g,) }
  <ees' a>4( g,) r
  <ees' a>4( g,) r
  <d' g,>4->
  d8( e d e) q4->
  d8( ees d ees) q4->
  d8( e d e) q4->
  d8( ees d ees)
}

lower-eleven = \relative c {
  \repeat unfold 2 { <g ees'>4( c,) r }
  \repeat unfold 3 { q4( c) }
  \repeat unfold 2 { <g' e'>4( c,) r }
  \repeat unfold 3 { <bes' g'>4( ees,) }
}

lower-twelve = \relative c {
  <bes g'>4-- r r
  << {
    \tiny
    g'2.~ g2.~ g2.~ g2.\( a2.\)\( b8\) r
  } \\ {
    \normalsize
    <bes, g'>4( ees,) d'\rest
    \repeat unfold 3 { <bes g'>4( e,) }
    <c' g'>4( ees,) d'\rest
    <d a'>4( f,) d'\rest
    <g, d'>4--
  } >>
  r4 r4
  <g d'>4-- r r
  q-- r q-- r q-- r
  <c, g' e'>2.~ q2.
}

lower-thirteen = \relative c {
  <g d'>4-- r r q-- r r
  q-- r q-- r q-- r
  <c, g' e'>2.--~ q2.
  <ees bes' fis'>2.--~ q2.
  \repeat unfold 2 { <g d' b'>4-- r d'-. }
  q4-- r r d4-. r r
}

lower-fourteen = \relative c, {
  \key c \major
  \repeat unfold 9 { <fis d'>4-. r b,-. }
  <fis' dis'>4-. r b,-.
  <fis' d'>4-. r b,-.
  <fis' dis'>4-. r b,-.
}

lower-fifteen = \relative c {
  \repeat unfold 6 { <g e'>4-. r b,-. }
  <fis' dis'>4-- r <g' c e>4 <fis b dis> r r
  <b dis fis>4-- r \clef treble <g' c e> <fis b dis> r r
}

lower-sixteen = \relative c' {
  <e a>-.-> r \clef bass
  a,,,4-.-> <e' c'>-.-> r a,-.
  <e' c'>-. r a,-.
  <e' d'>-. r a,-.
  <e' c'>-. r a,-.
  <e' d'>-. r a,-.
  <e' c'>-. r a,-.
  <e' cis'>-. r a,-.
  <e' c'>-. r a,-.
  <e' cis'>-. r a,-.
}

lower-seventeen = \relative c, {
  <e d'>-. r a,-. a-. r a-.
  <e' cis'>-. r a,-. a-. r a-.
  <e' d'>-. r a,-.
  <e' d'>-. r a,-.
  <e' cis'>4-- r <f' bes d> <e a cis> r r
  <a cis e>4-- r \clef treble
  <f' bes d>4 <e a cis> r r
}

lower-eighteen = \relative c' {
  <c f a>4-> <f a> q q q q
  << {
    \repeat unfold 24 { q4 }
  } \\ {
    f2.-- c-- a-- f-- a-- c-- d-- a--
  } >>
}

lower-ninteen = \relative c' {
    \clef bass
    << {
      \repeat unfold 6 { <d f>4 }
      \repeat unfold 12 { <d a'>4 }
      <ees g>4 q q q
    } \\ {
      f,2.-- d-- f-- fis-- f-- fis-- g~-- g4
    } >>
    r4 r
  }

lower-twenty = \relative c {
  \repeat unfold 7 {
    <ees ges,>4 <ees bes'> <ees ges,>
  }
}

lower-twentyone = \relative c {
  <e bes' fis,>4 <e bes'> <e fis,>
  \repeat unfold 6 {
    <e fis,>4 <e bes'> <e fis,>
  }
}

lower-twentytwo = \relative c {
  <g e' b'>8-> r g4_\markup { "pizz." } g
  <e' c'>4-. g,-. g-.
  <e' b'>4-. g,-. g-.
  <e' c'>4-. g,-. g-.
  <e' cis'>4-. g,-. g-.
  <dis' c'>4-. g,-. g-.
  <e' cis'>4-. g,-. g-.
  <dis' c'>4-. g,-. g-.
  <d' b'>4-. g,-. r
  <ees' c'>4-. g,-. r
  <e' cis'>4-. g,-. r
  <f' d'>4-. g,-. r
  <fis' ees'>8 r r4 r4
  R2.
}
lower-twentythree = \relative c, {
  f8->( des' aes' des, aes' des,)
  \repeat unfold 5 {
    f,8( des' aes' des, aes' des,)
  }
  <ees ees,>4-> a8( f a f)
  \repeat unfold 5 { ees8( f a f a f) }
}
lower-twentyfour = \relative c {
  <bes bes,>4-> a'8( fis a fis)
  \repeat unfold 3 { bes,8( fis' a fis a fis) }
  \repeat unfold 4 { a,8( fis' b fis b fis) }
  \repeat unfold 2 { aes,8( fis' dis' fis, dis' fis,) }
}
lower-twentyfive = \relative c {
  <g e' b'>4-> r r q-> r r q-> r r R2.
  <g ees' bes'>4-> r r q-> r r q-> r r R2.
}
lower-twentysix = \relative c {
  <g e' b'>4-> r r <g ees' bes'>-> r r
  <g e' b'>4-> r r <g ees' bes'>-> r r
  <g f' b>4-> r r R2.*5
}
lower-twentyseven = \relative c {
  <g c,>4-> <g e'> q
  <g c,>4-> <g f'> q
  <g c,>4-> <g e'> q
  <g c,>4-> <g f'> q
  <aes ees'>4 c, c
  <g' e'> c, c
  <aes' ees'>4 c, c
  <g' e'> c, c
  <aes' ees'>4 c, c
  <c a' fis'>4 <c'' d fis> q q q q
}
lower-twentyeight = \relative c' {
  << {
    \repeat unfold 9 { <e g>4 }
    \repeat unfold 3 { <a, e'>4 }
  } \\ {
    c2.-> g-> e-> c->
  } >>
  f,2.->
  <f' a d>4-> d g,
  <f' a d>4-> d g,
  <g' b e>4 g g,
  <e' g c>4-> g e c g e
}
lower-twentynine = \relative c, {
  <c g' ees'>4-. r r
  <c g' f'>4-. r r
  <c g' ees'>4-. r r
  <c g' d'>4-. r r
  <c g' ees'>4-. r r
  c''8( b a b c4)
  <c,, a' f'>4-. r r c''8( b a b c d
  <bes ees>4 ees,) ees
  <ces' ees>4( ees,) ees
  <bes' ees>4( ees,) ees
  <ces' ees>4( ees,) ees
  \clef treble
  \repeat unfold 6 { <ees' f a>4-. }
}
lower-thirty = \relative c'' {
  << {
    g4 \cr <g bes>4-. q-.
  } \\ {
    \cl ees2.-.
  } >>
  \clef bass
  bes2.-. g-. ees-. aes,-.
  r4 <f' c'>4-. bes,-.
  r4 <f' c'>4-. bes,-.
  r4 <g' bes>4-. bes,-.
  ees4-> bes-> g-> ees-> f-> fis->
  g4-> r f-> ees-> r d->
}
lower-thirtyone = \relative c {
  \key c \minor
  <g c,>4->
  g8( aes g aes <g c,>4)->
  g8( aes g aes <g c,>4)
  aes4 q aes q aes q
  \repeat unfold 4 { g'8( aes g aes c,4) }
  \repeat unfold 3 { fis8( aes fis aes c,4) }
  fis8( aes fis aes)
}
lower-thirtytwo = \relative c {
  <g c,>4->
  g8( aes g aes <g c,>4)
  aes4 q aes( q) r4
  c4 \repeat unfold 2 { g'8( aes g aes c,4) }
  \repeat unfold 2 { g'8( aes g aes b,4) }
  g'8( aes g aes bes,4)
  g'8( aes g aes)
  \repeat unfold 2 { <a,, a'>4-> a8( a') a,( a') }
}
lower-thirtythree = \relative c {
  <aes aes,>4->
  \repeat unfold 3 { aes4-.( ees' c'-.) }
  aes,4-.( ees'-. <e des'>-.)
  aes,4-.( e'-. des'-.)
  aes,4-.( e'-. <f c'>-.)
  \repeat unfold 3 { aes,4-.( f' c'-.) }
}
lower-thirtyfour = \relative c {
  aes4-.( f'-. d'-.)
  aes,4-.( f'-. bes-.)
  aes,4-.( f'-. bes-.)
  aes,4-.( f'-. des'-.)
  aes,4-.( f'-. c'-.)
  aes,-.( f'-.)
  g,4-> c'4( f,) f,-> c''( f,)
  \repeat unfold 4 {
    <ges bes, ees,>4-> ges8( bes ges bes)
  }
}
lower-thirtyfive = \relative c {
  <c f,>4->
  \repeat unfold 2 { f8( e f e <f f,>4) }
  e4 q e q e
  \repeat unfold 8 { r4 f,-. f,-. }
}
lower-thirtysix = \relative c, {
  f4-. aes'-. r e,-. aes'-. r
  f,4-. aes'-. r e,-. aes'-. r
  aes,4-. b'-. r g,-. b'-. r
  aes,4-. b'-. r g,-. b'-. r
  b,4-. d'-. r bes,-. d'-. r
}
lower-thirtyseven = \relative c {
  b4-. d'-. r bes,-. d'-. r
  a,4-. f''-. aes,,
  \repeat unfold 4 { <g e' b'>4 r r }
}
lower-thirtyeight = \relative c, {
  \key c \major
  \repeat unfold 3 { <c g' e'>4-> r r } R2.
  \repeat unfold 3 { <c a' e'>4-> r r } R2.
}
lower-thirtynine = \relative c, {
  <ees bes' fis'>4-> r r q r r
  <d a' fis'>4-> r r q r r
  <des aes' f'>4-> r r q r r
  <c g' e'>4-> r r R2.
}
lower-forty = \relative c, {
  <c g' e'>4-> r r R2.
  c''4-> g-> e-> c-> g-> e->
  <c c'>4-> r r <c'' e g>-> r r <c,, c'>4-> r r R2.
}

dynamics-one = {
  s2.\mf s2.*10
}
dynamics-two = {
  s2.*8 s2.\f s2.
}
dynamics-three = {
  s2.\mf s2.*13
}
dynamics-four = {
  s2.*8 s2._"dim." s4 s2\> s2 s4\!
}
dynamics-five = {
  s2.\pp s2.*7
}
dynamics-six = {
  s2._"poco marcato" s2. s2._"poco a poco cresc." s2.*7 s2\< s4\!
}
dynamics-seven = {
  s2.\sf s2.\sf s2. s2.\sf s2. s2.\sf s2 s4\sf s2.\sf s2.*2
}
dynamics-eight = {
  s2.\f s2. s4 s2\> s2 s4\! s2.\mp s2. s4 s2\> s2 s4\!
}
dynamics-nine = {
  s2.\p s2.*7 s2.\f_"subito" s4 s2\> s4 s2\!
}
dynamics-ten = {
  s2.\p s2.*4 s2.\f_"subito" s2\> s4\! s2.*2
}
dynamics-eleven = {
  s2.\mf s2.*7
}
dynamics-twelve = {
  s2. s2._"poco dim." s2.*4 s2.\p s2.*2 s2\< s4\! s2.\mf s4 s\> s\!
}
dynamics-thirteen = {
  s2.\p s s2.\< s4 s\! s s2.\mf s2.*2 s2.\> s2. s2 s4\! s2.\pp s2.
}
dynamics-fourteen = {
  s2.\pp s2.*11
}
dynamics-fifteen = {
  s2.*3 s4 s2\< s2. s2 s4\! s2.\p s2.\< s2. s2 s4\!
}
dynamics-sixteen = {
  s2.\f s2 s4\pp s2.*8
}
dynamics-seventeen = {
  s2.*4 s2.\< s2 s4\! s2. s4 s2\< s2. s2 s4\!
}
dynamics-eighteen = {
  s4\f s2\mf s2.*7 s2._"cantabile" s2.
}
dynamics-ninteen = {
  s2.*7 s2\< s4\!
}
dynamics-twenty = {
  s4\sf s2\p_"subito" s2.*4 s4 s2\< s2 s4\!
}
dynamics-twentyone = {
  s2.\mf s2._"poco a poco cresc." s2.*4 s2\< s4\!
}
dynamics-twentytwo = {
  s4\f s2\pp
}
dynamics-twentythree = {
  s4\f s2_"marcato" s2.*11
}
dynamics-twentyfour = {
  s2.*10
}
dynamics-twentyfive = {
  s2.\f s2.*7
}
dynamics-twentysix = {
  s2.*4 s2.\sf s2.*5
}
dynamics-twentyseven = {
  s2.\ff_"con fuoco" s2.*10
}
dynamics-twentyeight = {
  s2.*8 s4 s2\> s2 s4\!
}
dynamics-twentynine = {
  s2.\pp_"pizz." s2.*12 s2._"poco a poco cresc."
}
dynamics-thirty = {
  s2.*6 s2.\< s2 s4\! s2.\f s2.*3
}
dynamics-thirtyone = {
  s2.\f s2.*3
  s2.\mf
  s2.*7
}
dynamics-thirtytwo = {
  s2.\f s2.*2 s2.\mf s2.*3
  s2 s4\< s2 s4\!
  s2.\f s2.
}
dynamics-thirtythree = {
  s2.*8
}
dynamics-thirtyfour = {
  s2.*13
}
dynamics-thirtyfive = {
  s2. s2._"dim." s4 s2\> s2 s4\!
  s2.\pp_"sotto voce" s2.*7
}
dynamics-thirtysix = {
  s2.*3 s2._"poco a poco cresc." s2.*6
}
dynamics-thirtyseven = {
  s2.*2 s2\< s4\! \repeat unfold 4 { s2.\sf }
}
dynamics-thirtyeight = {
  s2.\ff s2.\sf s2.\sf s2.
  \repeat unfold 3 { s2.\sf }
}
dynamics-thirtynine = {
  s2.\p_"e cresc." s2.*5 s2.\ff
}
dynamics-forty = {
  s2.\sf s2.*4 s2.\sf s2.\sf s2.
}

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
violin-one = \relative c'' {
  c4\f b8( c) g4~ g a-.( b-.) c4 b8( c) d4~ d c-.( d-.) ees4 ees8( d c d) e2( c4)
  ees4 ees8( d c d) e2( c4) ees8( d c d ees f) fis4( g) gis( a) ais-.( b-.)
}
violin-two = \relative c''' {
  c2.~-> c4 b-.( a-.) g8( e c e g gis) a4(\( e) c'-.\) d,2.->
  f4-> f8( e d a)
  f'4-> f8( e d a)
  g'8(\< f e d c b)\! c4-> r r R2.
}
violin-three = \relative c'' {
  c,4\f b8( c) g4~ g a-.( b-.) c4 b8( c) d4~ d c-.( d-.)
  ees4 ees8( d c d) e2( c4)
  f4 f8( e d e) fis2( d4)
  g2 g8( g') ges4 ges8( f ees f) g4. g,8( ees' g)
  ges8( f ees f ges aes) a4( bes) b( c) cis-.( d-.)
}
violin-four = \relative c''' {
  ees2.~-> ees4 d-.( c-.) bes8( g ees g bes b)
  c4(\( g) ees'-.\) f,2.->
  aes4-> aes8( g f c)
  aes'4-> aes8( g f c)
  bes'8( aes g f ees d) ees2.~\(_"dim." ees4 des ces\)
  bes2 ees,4
}
violin-five = \relative c'' {
  ges4-.\p ges8( f ees bes)
  ges'4-. ges8( f ees ces)
  ges'4-. ges8( f ees c)
  ges'2-- ees4
  ges4-. ges8( f ees bes)
  ges'4-. ges8( f ees ces)
  ges'4-. ges8( f ees c)
  g'2-> ees4
}
violin-six = \relative c'' {
  ges8-. r ges( f ges aes)
  a8 r a( ges a ges)
  fis8(_"poco a poco cresc." f fis gis a b)
  c8( b c b a gis)
  a8-. r a( gis a b)
  c8-. r c( b c b)
  a8( gis a b c d)
  ees8( d ees f fis gis)
  a8( b c b d c)
  a8( b c b d c)
  a8\< b c d ees f\!
}
violin-seven = \relative c''' {
  fis8->\f r d,, fis b d
  fis8 r d fis b d
  fis8 r d,, fis b d
  g8-> ees bes g, bes ees
  g8 bes ees g bes ees
  g8-> ees bes d,, ees f
  g8 bes ees g bes ees
  g8-> r e( dis e fis)
  g4->\< e-> fis->
  g4-> gis-> a->\!
}
violin-eight = \relative c'''' {
  \key g \minor
  bes2.~->\ff bes8 r r4 r4
  R2.*6
}
violin-nine = \relative c'' {
  r4 g\mp_"cantando"^"sul D"( a bes2 ees4)
  d2.~( d2 bes4--)
  c2( bes4 a2 g4)
  bes2.( g4) r r
  R2.*2
}
violin-ten = \relative c'' {
  r4 g( a bes2 ees4)
  d2.~( d2 bes4)
  c2( ees4 d2.)
  g4 r r R2.*3
}
violin-eleven = \relative c''' {
  g2.~\f( g4 d f) ees2( d4)
  g2( d4) c2( bes4) a2( g4)
  bes2.( g2.~
  \mark \default
  g4)
}
violin-twelve = \relative c'' {
  g4( a bes2_"poco dim" ees4)
  d2.~( d2 bes4--) c2( ees4 d2.)\>
  g2.~\!\p g2.~ g4 d-.( g-. b-.\< d-. g-.\!)
  d'2.\mf\startTrillSpan
  c2.\>
}
violin-thirteen = \relative c''' {
  g2.~\!\p\stopTrillSpan g2.~ g4 d,8\< d g g b b d d g g\!
  bes2.~\mf\startTrillSpan bes~ bes
  aes2.\>
  g2.~\stopTrillSpan
  g2.
  <g c>2.~\!\pp\>
  q4\! r r
}
violin-fourteen = \relative c'' {
  \key c \major
  R2.*4
  b4\p^"pizz." ais b fis gis ais
  b4 ais b cis b cis
  d4 cis b dis r fis
  d4 cis b dis r b
}
violin-fifteen = \relative c'' {
  c4 b a g fis g
  a4 g fis e dis\< e
  fis e d c b ais\!
  b4 r r <b fis' dis'>4\< r r
  <dis b' fis'>4 r r <fis dis' b'> r r
}
violin-sixteen = \relative c'' {
  <a e' c'>4->\!\f r r R2.
  c,8-.\pp^"arco" b-. c-. d-. e-. f-.
  e8-. f-. e-. d-. c-. b-.
  c8-. b-. c-. d-. e-. f-.
  e8-. d-. e-. f-. fis-. gis-.
  a8-. e-. fis-. gis-. a-. b-.
  cis8-. e,-. fis-. gis-. a-. b-.
  c8-. e,-. fis-. gis-. a-. b-.
  cis8-. d-. e-. fis-. gis-. a-.
}
violin-seventeen = \relative c''' {
  bes8-. c-. a-. bes-. g-. a-.
  f8-. g-. e-. f-. d-. e-.
  cis8-. d-. c-. des-. bes-. c-.
  a8-. bes-. g-. a-. f-. g-.
  e8-.\< f-. g-. a-. bes-. c-.
  cis8-. d-. e-. f-. fis-. gis-.
  a4-- r r
  <a,, e' cis'>4\<^"pizz." r r
  <cis a' e'> r r
  <e cis' a'> r r
}
violin-eighteen = \relative c' {
  <f c' a'>4->\!\f r r R2.
  r4 f'4\f(^"arco" g)
  a2( d4) c2.~( c2 a4)
  bes2( a4) g2( f4)
  a2( f4 d2.~
  \mark \default
  d4)
}
violin-ninteen = \relative c'' {
  d4( e)
  f4( d) a' d2( c4)
  d2.~ d4 c( bes)
  a4( bes c) bes4( g) bes ees,4 r r
}
violin-twenty = \relative c' {
  r4 ees4\upbow\mp( f) ges2( <f bes>4)
  <ges ees'>2. r4 ees4( f)
  ges4( <f bes> <ges ees'>) <ees' ges>2(\< <bes f'>4)
  <ges ees'>2.
}
violin-twentyone = \relative c' {
  r4\! e\mf( fis)
  g2(_"poco a poco cresc." <e cis'>4)
  <g e'>2. r4 e4( fis)
  g4( <e cis'> <g e'>)
  <e' g>2\<( <bes fis'>4\!)
  <g e'>2.\f
}
violin-twentytwo = \relative c'' {
  g4\pp g8( fis g e)
  a4 a8( g a fis)
  g8( fis) g( e) fis( g)
  a8( g) a( fis) g( a)
  b4 b8( a b g)
  c4 c8( b c a)
  b8( a) b( g) a( b)
  c8( b) c( a) b( c)
  d8 r d( cis d b)
  ees8 r ees( d ees c)
  e8 r e( dis e cis)
  f8 r f8( e f d)
  fis8 r gis,,\< a c ees fis a c ees fis g\!
}
violin-twentythree = \relative c''' {
  aes2.~\f\startTrillSpan aes2.~ aes4\stopTrillSpan
  f4( fis) g( bes aes)
  aes,4 bes8( c des ees) f4( ges aes)
  a2.~\startTrillSpan a2.~ a4\stopTrillSpan
  a4( bes) b( d c)
  c,4 d8( e f g) a4( bes c)
}
violin-twentyfour = \relative c''' {
  d2.~\startTrillSpan d2.~ d4\stopTrillSpan
  d,4( e) fis( a) e'
  d2.~\startTrillSpan d2.~ d4\stopTrillSpan
  fis,4 b cis d e
  fis2.~\startTrillSpan fis2.
}
violin-twentyfive = \relative c'''' {
  g8->\stopTrillSpan r8 b,,,8 b <g e'> q
  <b g'> q <e b'> q <g e'> q
  g'8-> e b g e b g( b) e g b e
  g8-> r bes,, bes <g ees'> q <bes g'> q <ees bes'> q <g ees'> q
  g'8-> ees bes g ees bes g bes ees g bes ees
}
violin-twentysix = \relative c'' {
  \repeat unfold 2 {
    <b g'>8-> <e, b'> q <g, e'> <e' b'> <b' g'>
    <bes g'>8-> <ees, bes'>8 q <g, ees'> <ees' bes'> <bes' g'>
  }
  <g, d' b' g'>8-> r g8_"energico" a b c
  d cis d e f fis g fis g a b c
  d cis\< d e f fis g g
  fis-> fis g-> g a-> a ais-> ais b-> b\!
}
violin-twentyseven = \relative c'' {
  <e c'>8->\sff r r4 r4 R2.*10
}
violin-twentyeight = \relative c'' {
  R2.*10
}
violin-twentynine = \relative c'' {
  c4\p b8( c) g4~ g a-.( b-.)
  c4 b8( c) d4~ d c-.( d-.)
  ees4 ees8( d c d) e2( c4)
  f4 f8( e d e) fis2( d4) g2.
  ges4 ges8( f ees f) g2.
  ges8( f ees f ges aes)
  a4( bes) b( c)_"poco a poco cresc." cis-.( d-.)
}
violin-thirty = \relative c''' {
  ees2.~ ees4 d-.( c-.)
  bes8( g ees g bes b) c4(\( g) ees'-.\) f,2.--
  aes4-> aes8( g f c)
  aes'4->\< aes8( g f c)
  bes'8( aes g f ees d)\!
  ees4-> r r R2.*3
}
violin-thirtyone = \relative c'' {
  \key c \minor
  R2.*4
  r4 c4\f( d ees2 aes4) g2.~( g2 ees4--)
  f2( ees4 d2 c4) ees2.( c4) r r
}
violin-thirtytwo = \relative c'' {
  R2.*2 r4 c4( d ees c aes')
  g2.~( g2 ees4--) f2( aes4 g2.) c2.
  R2.*2
}
violin-thirtythree = \relative c''' {
  r4 c4(_"piu f" des) ees2( f4)
  ees2.~( ees2 c4) des2( c4) bes2( des4) c2( aes4) f2.~ f4
}
violin-thirtyfour = \relative c'' {
  f4( g) aes( f c') bes2( aes4) bes2.
  f'2.~( f2 des4--) c2( f,4--) f'2.~ f4 ees( des)
  c2.-> bes-> aes-> ges->
}
violin-thirtyfive = \relative c'' {
  \tempo "Piu mosso"
  f4-> r r R2.*3
  aes,4\pp_"sotto voce" aes8( g f c)
  aes'4 aes8( g f des)
  aes'4 aes8( g f d)
  aes'2-- f4
  aes4 aes8( g f c)
  aes'4 aes8( g f des)
  aes'4 aes8( g f d)
  a'2-- f4
}
violin-thirtysix = \relative c'' {
  aes8_"poco marcato" r aes( g aes bes)
  b8 r b( bes b bes) aes( g aes bes b cis)
  d8(_"poco a poco cresc." cis d cis b ais)
  b8 r b( ais b cis) d r d( cis d cis)
  b8( ais b cis d e) f( e f e d cis)
  d8( cis d e f g) aes( g aes g f e)
}
violin-thirtyseven = \relative c'' {
  d8( e f e g f) d8( e f e g f)
  d8\< e f g aes bes\!
  b8\f r ais, b e g
  b8-> r ais,( b) e g
  <b, b'>8-> <e, b'> q\< <g, e'> <e' b'> <b' b'>
  <b b'>8-> <e, b'> q <g, e'> <e' b'> <b' b'>\!
}
violin-thirtyeight = \relative c'' {
  \key c \major
  <c c'>8->\ff r e, e <c g'> q
  <e c'> q <g e'> q <c g'> q
  c'8-> g e c g e dis( e) g c e g
  c8-> r e,, e <c a'> q
  <e c'>8 q <a e'> q <c a'> q
  c'8-> a e c a e dis e a c e a
}
violin-thirtynine = \relative c''' {
  c8->_"meno f e cresc." aes ees c d ees
  d8 c b c ees aes
  c8-> a fis c d ees d c b c fis a
  c8-> aes f c d ees d c b c f aes
  c8->\ff g e c g e dis e g c e g
}
violin-forty = \relative c''' {
  c8-> c g g e e c c g g e e c4-> r r R2.*2
  <g' e' c'>4->\sf r r c,4->\sf r r R2.
}

violin = \relative c' {
  \clef treble
  \time 3/4
  \key c \major
  \set Score.markFormatter = #format-mark-box-numbers
  \violin-prelude
  \mark \default
  \violin-one
  \mark \default
  \violin-two
  \mark \default
  \violin-three
  \mark \default
  \violin-four
  \mark \default
  \violin-five
  \mark \default
  \violin-six
  \mark \default
  \violin-seven
  \mark \default
  \violin-eight
  \mark \default
  \violin-nine
  \mark \default
  \violin-ten
  \mark \default
  \violin-eleven
  % \mark \default % inside violin-eleven due to slur
  \violin-twelve
  \mark \default
  \violin-thirteen
  \mark \default
  \violin-fourteen
  \mark \default
  \violin-fifteen
  \mark \default
  \violin-sixteen
  \mark \default
  \violin-seventeen
  \mark \default
  \violin-eighteen
  % \mark \default % inside violin-eighteen due to slur
  \violin-ninteen
  \mark \default
  \violin-twenty
  \mark \default
  \violin-twentyone
  \mark \default
  \violin-twentytwo
  \mark \default
  \violin-twentythree
  \mark \default
  \violin-twentyfour
  \mark \default
  \violin-twentyfive
  \mark \default
  \violin-twentysix
  \mark \default
  \violin-twentyseven
  \mark \default
  \violin-twentyeight
  \mark \default
  \violin-twentynine
  \mark \default
  \violin-thirty
  \mark \default
  \violin-thirtyone
  \mark \default
  \violin-thirtytwo
  \mark \default
  \violin-thirtythree
  \mark \default
  \violin-thirtyfour
  \mark \default
  \violin-thirtyfive
  \mark \default
  \violin-thirtysix
  \mark \default
  \violin-thirtyseven
  \mark \default
  \violin-thirtyeight
  \mark \default
  \violin-thirtynine
  \mark \default
  \violin-forty
  \bar "|."
}

\score {
  <<
    \new Staff = "violin-staff" \with {
      fontSize = #-3
      \override StaffSymbol.staff-space = #(magstep -3)
      \override StaffSymbol.thickness = #(magstep -3)
    }
    <<
      \set Staff.midiInstrument = #"violin"
      \set Staff.instrumentName = #"Violin"
      \set Staff.midiMinimumVolume = #0.5
      \set Staff.midiMaximumVolume = #0.8
      \violin
    >>
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.3
        \set Staff.midiMaximumVolume = #0.7
        \upper
      }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.3
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

