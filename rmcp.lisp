;;;; -*- Mode: Lisp -*-
;;;; $Id$

;;;; RMCP (Remote Management Control Protocol)

(in-package :ipmi)

(defconstant +rmcp-version-1.0+ #x06)
(defconstant +rmcp-normal-message+ #b00000000)
(defconstant +rmcp-ack-message+ #b10000000)
(defconstant +rmcp-message-class-asf+ 6)
(defconstant +rmcp-message-class-ipmi+ 7)
(defconstant +rmcp-message-class-oem+ 8)

(defclass rmcp ()
  ((version          :type (unsigned-byte 8)
                     :initarg :version
                     :initform +rmcp-version-1.0+)
   (sequence-number  :type (unsigned-byte 8)
                     :initarg :sequence-number
                     :initform #xff)
   (class-of-message :type (unsigned-byte 8)
                     :initarg :class-of-message
                     :initform +rmcp-message-class-asf+))
  (:documentation "RMCP Message"))

(defmethod encode ((object rmcp))
  (format t "RMCP encode before.~%")
  (with-slots (version sequence-number class-of-message) object
    (vector version 0 sequence-number class-of-message)))
