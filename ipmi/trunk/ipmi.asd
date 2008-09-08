;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asdf)

(defsystem ipmi
  :description "Intelligent Platform Management Interface"
  :version "1.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:usocket-udp)
  :components ((:file "package")
	       (:file "base" :depends-on ("package"))
               (:file "rmcp" :depends-on ("base"))
               (:file "asf" :depends-on ("rmcp"))
               (:file "ipmi" :depends-on ("rmcp"))
               (:file "chassis" :depends-on ("rmcp"))
               (:file "sel" :depends-on ("ipmi"))
               (:file "pef" :depends-on ("ipmi"))
               (:file "sdr" :depends-on ("ipmi"))
               (:file "fru" :depends-on ("ipmi"))
               (:file "sol" :depends-on ("ipmi"))))
