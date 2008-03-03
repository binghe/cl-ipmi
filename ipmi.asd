;;;; -*- Mode: Lisp -*-

(in-package :asdf)

(require "comm")

(defsystem ipmi
  :description "Intelligent Platform Management Interface"
  :version "0.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (#+lispworks :lispworks-udp
               :ironclad
               :ieee-floats)
  :components ((:file "package")))
