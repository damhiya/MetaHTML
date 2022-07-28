module MetaHTML.Syntax.GId where

import Data.Text

data GId = GId !Text !Integer deriving (Show, Eq, Ord)
