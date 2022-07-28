module MetaHTML.Syntax.Meta where

import Data.Text
import MetaHTML.Syntax.GId
import qualified MetaHTML.Syntax.Object as O

data Id = Id !Text !Integer deriving (Show, Eq, Ord)

type LCtx = [(Id, Ty)]

data Ty
  = TyArr Ty Ty
  | TyBox O.LCtx O.Ty
  deriving Show

data Tm
  = TmVar Id
  | TmLam Id Ty Tm
  | TmApp Tm Tm
  | TmBox O.LCtx O.Tm
  | TmLetBox GId Tm Tm
  deriving Show
