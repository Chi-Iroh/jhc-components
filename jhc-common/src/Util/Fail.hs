module Util.Fail () where

import Control.Monad.Identity
  
instance MonadFail (Either String) where
  fail = Left

instance MonadFail (Identity) where
  fail = error
