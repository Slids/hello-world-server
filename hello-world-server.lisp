(defpackage #:hello-world-server
  (:use #:cl
        #:hunchentoot)
  (:local-nicknames
   (#:hwp #:cl-protobufs.hello-world)))

(in-package :hello-world-server)

(setf *dispatch-table*
      (list #'dispatch-easy-handlers))

(setf *show-lisp-errors-p* t
      *show-lisp-backtraces-p* t)

(setf *acceptor* nil)

(define-easy-handler (hello-world :uri "/hello")
    ((state-variable :parameter-type 'string))
  (let* ((bytes (read-from-string state-variable))
         (octet-bytes (make-array (length bytes)
                                  :element-type '(unsigned-byte 8)
                                  :initial-contents bytes))
         (my-message (cl-protobufs:deserialize-object-from-bytes
                      'hwp:request octet-bytes))
         (my-response
           (hwp:make-response
            :response
            (if (hwp:request.has-name my-message)
                (format nil "Hello ~a" (hwp:request.name my-message))
                "Hello"))))
    (format nil "~a" (cl-protobufs:serialize-object-to-bytes my-response))))

(defun stop-server ()
  (when *acceptor*
    (stop *acceptor*)))

(defun start-server ()
  (stop-server)
  (start (setf *acceptor*
               (make-instance 'easy-acceptor
                              :port 4242))))

(start-server)
