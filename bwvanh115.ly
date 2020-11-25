\version "2.20.0"

\include "articulate.ly"

\header {
  title = "Minuet in G Minor"
  composer = "Christian Petzold"
  opus = "BWV Anh. 115"
  style = "Baroque"
  source = "https://en.wikipedia.org/wiki/Minuets_in_G_major_and_G_minor"
  author = \markup \fromproperty #'header:composer
  subject = \markup \concat {
    "Piano partition for “"
    \fromproperty #'header:title
    "” ("
    \fromproperty #'header:opus
    ") by "
    \fromproperty #'header:composer
  }
  keywords = #(string-join '(
    "music"
    "partition"
    "piano"
    "harpsichord"
    "minuet"
  ) ", ")
  tagline = ##f
}

right = \relative c'' {
  \clef treble
  \time 3/4
  \key g \minor

  \repeat volta 2 {
    bes'4 a g |
    a d,\staccato d\staccato |
    g g,8 a bes c |
    d2. |
    ees4 f8 ees d c | \break
    f4 g8 f ees d |
    ees4 f8 ees d ees |
    a,2.\mordent |
    bes'4 a\mordent g |
    a d,\staccato d\staccato | \break
    g g,8 a bes c |
    d2. |
    f4\mordent f8 ees des c |
    d4 ees8 d c bes |
    d4 g c,\mordent |
    <d, f bes>2. |
  }

  \break

  \repeat volta 2 {
    d'4 bes8 c d e |
    f4 g a |
    bes g8 a b g |
    a4 g8 a f4 |
    a,8 bes c d ees f | \break
    ees4 d\mordent c |
    f bes, a |
    bes2. |
    g4\staccato d8 c d4 |
    g\staccato ees8 d ees4 | \break
    g8 d' fis, c' g bes |
    a2. |
    d,8 e fis g a bes |
    c4 bes a |
    bes8\mordent c16 d g,4 fis |
    <bes, d g>2. |
  }
}

left = \relative c' {
  \clef bass
  \time 3/4
  \key g \minor

  \repeat volta 2 {
    g2. |
    f |
    ees |
    d4 d'8 c bes a |
    <g bes>2 a4 |
    bes2 g4 |
    a fis g |
    d4 d'8 c bes a |
    g2. |
    f |
    ees |
    d4 d'8 c b a |
    <b d>2 g4 |
    c bes f |
    bes ees, <f a> |
    bes bes,2 |
  }

  \repeat volta 2 {
    bes'2. |
    a4 g f |
    g e c |
    f2 r4 |
    a g f |
    g f ees |
    d ees f |
    bes, d' c |
    <b d>2. |
    c |
    bes4 a g |
    d' a8 g fis? e |
    d2 r4 |
    ees d c |
    bes c d |
    g g,2 |
  }

  % Display two opposite \fermata signs over the last bar line
  % http://lsr.di.unimi.it/LSR/Item?id=10
  \override Score.RehearsalMark.break-visibility = #begin-of-line-invisible
  \mark \markup \musicglyph #"scripts.ufermata"

  % The RehearsalMark in Staff is overriden, while not touching the one
  % from Score.
  \override Staff.RehearsalMark.direction = #DOWN
  \override Staff.RehearsalMark.rotation = #'(180 0 0)
}

pianoStaff = \new PianoStaff \with {
  midiInstrument = "harpsichord"
} <<
    \new Staff = "right" { \right }
    \new Staff = "left" \with { \consists "Mark_engraver" } { \left }
>>

\score {
  \pianoStaff
  \layout {}
}

\score {
  \unfoldRepeats \articulate \pianoStaff
  \midi {
    \tempo 4 = 130
  }
}
