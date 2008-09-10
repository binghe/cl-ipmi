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
                     :initarg :class-of-message))
  (:documentation "RMCP Message"))

(defmethod ipmi-encode ((object rmcp))
  (with-slots (version sequence-number class-of-message) object
    (vector version 0 sequence-number class-of-message)))

(defmethod ipmi-decode-protocol ((stream stream) (parent t) (protocol (eql :rmcp)))
  (let* ((version (read-byte stream))
         (reserved (read-byte stream))
         (sequence-number (read-byte stream))
         (class-of-message (read-byte stream)))
    (declare (ignore reserved))
    (ipmi-decode-protocol stream
                          (make-instance 'rmcp
                                         :version version
                                         :sequence-number sequence-number
                                         :class-of-message class-of-message)
                          class-of-message)))

(defmethod ipmi-decode-protocol ((stream stream) (parent rmcp) (protocol integer))
  (declare (ignore stream protocol))
  (warn 'ipmi-decode-warning)
  parent)
