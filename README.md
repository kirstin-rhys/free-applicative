# free-applicative

In two senses, there really isn't anything new here. The
implementation of the Free Monad has been known for a long time. More
recently, a half dozen implementations of the Free Applicative Functor
have been published.

The construction of the data algebra for the Free Monad was chosen so
it closely aligns to `join`, and the construction of the data algebras
for the Free Applicative Functors were chosen so that they closely
align to contextual application (`<*>` aka ⊛ aka `ap`).

But are these constructions for Free Applicative Functors necessary?
Do they make an implementation of the Free Monad more efficient? Are
they easier to understand?

Obviously, if we have a trivial implementation of the free monad, we
could just define (<*>) as ap === liftM2 id, but we should be able to
define <*> without reference to bind.

For some reason, I have not found any implementations or discussion of
implementing <*> for the classic free monad. I suspect that that is
because it's not easy to derive without computer assistance.

But, fortunately, with computer assistance, it's pretty
straightforward to derive, and it's as efficient as the implentations
for the data structures designed to mimic the <*> signature.

    instance Functor φ ⇒ Applicative (Free φ) where
      pure = V
      (V x) ⊛ f = x <$> f
      (N g) ⊛ f = N $ (flip ($) <$> f ⊛) <$> g

For me at least, the proof of `(N g) ⊛ f` is not something I might easily
figure out or stumble upon.

