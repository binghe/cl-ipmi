;;;; -*- Mode: Lisp -*-
;;;; $Id$

;;;; Alert Standard Forum (ASF) Specification, v2.0
;;;;  http://www.dmtf.org/standards/documents/ASF/DSP0136.pdf

(in-package :ipmi)

(defconstant +asf-iana-enterprise-number+ 4542)
(defconstant +asf-version-1.0+ #b0001)
(defconstant +asf-message-type-presence-ping+ #x80)
(defconstant +asf-message-type-presence-pong+ #x40)
(defconstant +asf-ipmi-supported+ #b10000000)
(defconstant +asf-rmcp-security-extensions-supported+ #b10000000)

(defclass asf (rmcp)
  ((message-type :type (unsigned-byte 8)
                 :initarg :message-type
                 :accessor message-type-of)
   (message-tag  :type (unsigned-byte 8)
                 :initarg :message-tag
                 :initform 0)
   (data-length  :type (unsigned-byte 8)
                 :initarg :data-length
                 :initform 0))
  (:documentation "Alert Standard Forum Message"))

(defmethod initialize-instance :after ((instance asf) &rest initargs)
  (declare (ignore initargs))
  (setf (slot-value instance 'class-of-message) +rmcp-message-class-asf+))

(defmethod ipmi-encode ((object asf))
  (with-slots (message-type message-tag data-length) object
    (vector #x00 #x00 #x11 #xbe message-type message-tag 0 data-length)))

(defclass asf-presence-ping (asf)
  ()
  (:documentation "ASF Presence Ping Message (Ping Request)"))

(defmethod initialize-instance :after ((instance asf-presence-ping) &rest initargs)
  (declare (ignore initargs))
  (setf (message-type-of instance) +asf-message-type-presence-ping+))

(defclass asf-presence-pong (asf)
  ((iana-enterprise-number :type (unsigned-byte 32)
                           :initarg :iana-enterprise-number
                           :initform +asf-iana-enterprise-number+)
   (oem-defined            :type (unsigned-byte 32)
                           :initarg :oem-defined
                           :initform 0)
   (supported-entities     :type (unsigned-byte 8)
                           :initarg :supported-entities
                           :initform (logand +asf-ipmi-supported+
                                             +asf-version-1.0+))
   (supported-interactions :type (unsigned-byte 8)
                           :initarg :supported-interactions
                           :initform 0))
  (:documentation "ASF Presence Pong Message (Ping Response)"))

(defmethod initialize-instance :after ((instance asf-presence-pong) &rest initargs)
  (declare (ignore initargs))
  (setf (message-type-of instance) +asf-message-type-presence-pong+))

(defmethod ipmi-decode-protocol ((stream stream) (parent rmcp)
                                 (protocol (eql +rmcp-message-class-asf+)))
  (declare (ignore protocol))
  (let* ((enterprise-number (decode-integer-4 stream))
         (message-type (read-byte stream))
         (message-tag (read-byte stream))
         (reserved (read-byte stream))
         (data-length (read-byte stream)))
    (declare (ignore reserved))
    (if (/= enterprise-number +asf-iana-enterprise-number+)
        (error 'ipmi-decode-error)
      (ipmi-decode-protocol stream
                            (change-class parent 'asf
                                          :message-type message-type
                                          :message-tag message-tag
                                          :data-length data-length)
                            message-type))))

(defmethod ipmi-decode-protocol ((stream stream) (parent asf) (protocol integer))
  (declare (ignore stream protocol))
  (warn 'ipmi-decode-warning)
  parent)

(defmethod ipmi-decode-protocol ((stream stream) (parent asf)
                                 (protocol (eql +asf-message-type-presence-ping+)))
  (declare (ignore stream protocol))
  (change-class parent 'asf-presence-ping))

(defmethod ipmi-decode-protocol ((stream stream) (parent asf)
                                 (protocol (eql +asf-message-type-presence-pong+)))
  (let* ((enterprise-number (decode-integer-4 stream))
         (oem (decode-integer-4 stream))
         (supported-entities (read-byte stream))
         (supported-interactions (read-byte stream)))
    (change-class parent 'asf-presence-pong
                  :iana-enterprise-number enterprise-number
                  :oem-defined oem
                  :supported-entities supported-entities
                  :supported-interactions supported-interactions)))
