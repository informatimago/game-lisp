(asdf:defsystem "game"
  ;; system attributes:
  :description  "This system loads the GAME."
  :author       "AUTHOR NAME <EMAIL>"
  :maintainer   "MAINTAINER NAME <EMAIL>"
  :licence      "AGPL3"
  ;; component attributes:
  :version      "0.0.0"
  :properties ((#:author-email                   . "AUTHOR NAME")
               (#:date                           . "Summer 2018")
               ((#:albert #:output-dir)          . "/tmp/documentation/game/")
               ((#:albert #:formats)             . ("docbook"))
               ((#:albert #:docbook #:template)  . "book")
               ((#:albert #:docbook #:bgcolor)   . "white")
               ((#:albert #:docbook #:textcolor) . "black"))
  :depends-on ()
  :components ((:file "entity")
               (:file "game"  :depends-on ("entity"))
               )
  #+asdf-unicode :encoding #+asdf-unicode :utf-8)
