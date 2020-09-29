(defpackage #:hello-world-server
  (:use #:cl
        #:hunchentoot)
  (:export #:start-server
           #:stop-server)
  (:local-nicknames
   (#:hwp #:cl-protobufs.hello-world)
   (#:pu #:protobuf-utilities)))

(in-package :hello-world-server)

(setf *dispatch-table*
      (list #'dispatch-easy-handlers))

(setf *show-lisp-errors-p* t
      *show-lisp-backtraces-p* t)

(setf *acceptor* nil)

(define-easy-handler (hello-world :uri "/hello")
    ((request :parameter-type 'string))
  (pu:with-deserialized-protos-serializing-return ((request . hwp:request))
    (hwp:make-response
     :response
     (if (hwp:request.has-name request)
         (format nil "Hello ~a" (hwp:request.name request))
         "Hello"))))

(defun stop-server ()
  (when *acceptor*
    (stop *acceptor*)))

(defun start-server ()
  (stop-server)
  (start (setf *acceptor*
               (make-instance 'easy-acceptor
                              :port 4242))))

(start-server)
