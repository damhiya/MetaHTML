module MetaHTML.Syntax.Object where

import Data.Text
import MetaHTML.Syntax.GId

data Id = Id !Text !Integer deriving (Show, Eq, Ord)

type LCtx = [(Id, Ty)]

newtype Tag = Tag Text deriving Show

data Ty
  = TyHtml
  | TyNode
  | TyTag
  | TyAttr
  | TyText
  | TyList Ty
  deriving Show

data Tm
  = TmVar Id
  | TmHtml Tm Tm
  | TmNodeElem Tm Tm Tm
  | TmNodeText Tm
  | TmTag Tag
  | TmAttr Text Text
  | TmText Text
  | TmCons Tm Tm
  | TmNil
  | TmAppend Tm Tm
  | TmClo GId [Tm]
  deriving Show
