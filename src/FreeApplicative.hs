{-# LANGUAGE GADTs, NoImplicitPrelude, UnicodeSyntax #-}

module FreeApplicative (Free(..)) where

import Data.Function (($), flip)

class Functor φ where
  (<$>) ∷ (α → β) → φ α → φ β

class Functor φ ⇒ Applicative φ where
  pure ∷ α               → φ α
  (⊛)  ∷ φ (α → β) → φ α → φ β

class Applicative φ ⇒ Monad φ where
  (>>=) ∷ φ α → (α → φ β) → φ β

data Free φ α where
     V ∷ α            → Free φ α
     N ∷ φ (Free φ α) → Free φ α

instance Functor φ ⇒ Functor (Free φ) where
  f <$> (V x) = V $ f x
  f <$> (N g) = N $ (f <$>) <$> g

instance Functor φ ⇒ Applicative (Free φ) where
  pure = V
  (V x) ⊛ f = x <$> f
  (N g) ⊛ f = N $ (flip ($) <$> f ⊛) <$> g

instance Functor φ ⇒ Monad (Free φ) where
  (V x) >>= k = k x
  (N f) >>= k = N $ (>>= k) <$> f
