;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: ipmi; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  Alert Standard Forum (ASF) Specification, v2.0
  http://www.dmtf.org/standards/documents/ASF/DSP0136.pdf
  </DESCRIPTION>
 <COPYRIGHT YEAR='2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/asf.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080321'>create documentation for "asf.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

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

(defmethod encode ((object asf))
  (with-slots (message-type message-tag data-length) object
    (vector #x00 #x00 #x11 #xbe message-type message-tag 0 data-length)))

(defclass asf-presence-ping (asf)
  ()
  (:documentation "ASF Presence Ping Message (Ping Request)"))

(defmethod initialize-instance ((instance asf-presence-ping) &rest initargs
                                &key &allow-other-keys)
  (declare (ignore initargs))
  (setf (message-type-of instance) +asf-message-type-presence-ping+)
  (call-next-method))

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


:eof
