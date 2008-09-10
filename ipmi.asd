;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :asdf)

(defsystem ipmi
  :description "Intelligent Platform Management Interface"
  :version "1.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:asn.1
               :ironclad
               :usocket-udp)
  :components ((:file "package")
               (:file "condition" :depends-on ("package"))
	       (:file "base" :depends-on ("condition"))
               (:file "network" :depends-on ("base"))
               (:file "session" :depends-on ("network"))
               (:file "rmcp" :depends-on ("base"))
               (:file "asf" :depends-on ("rmcp"))
               (:file "ipmi" :depends-on ("asf" "session"))
               (:file "chassis" :depends-on ("ipmi"))
               (:file "channel" :depends-on ("ipmi"))
               (:file "sel" :depends-on ("ipmi"))
               (:file "pef" :depends-on ("ipmi"))
               (:file "sdr" :depends-on ("ipmi"))
               (:file "fru" :depends-on ("ipmi"))
               (:file "sol" :depends-on ("ipmi"))
               (:file "interface" :depends-on ("ipmi"))))
