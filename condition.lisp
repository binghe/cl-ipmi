;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :ipmi)

(define-condition ipmi-error (error)
  ())

(define-condition ipmi-decode-error (ipmi-error)
  ())

(define-condition ipmi-warning (warning)
  ())

(define-condition ipmi-decode-warning (ipmi-warning)
  ())
