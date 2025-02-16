(deffacts initial-bbca-3-years-stats
(book-value 1801.09)
(pbv 4.78)
(eps 326.34)
(pe 27.45)
)

(deftemplate introduction
(slot done-introducting)
)

(deftemplate investor-action
(slot action)
(slot certainty (type FLOAT))
)

; introduction

(defrule introduct
=>
(printout t "Hello, I am a bbca analyst expert system. Nice to meet you!!" crlf)
(printout t "I'll pose a series of questions to assist you in evaluating whether a bbca is overvalued or reasonably priced." crlf crlf)
(assert (introduction (done-introducting yes)))
)

; current book value

(defrule ask-for-future-book-value
(introduction (done-introducting yes))
=>
(printout t "In future circumstances, would you think the book value for bbca would decrease or increase?" crlf)
(printout t "PS: The 3-years mean of bbca book value is 1801.09" crlf)
(bind ?response(read))
(if (member$ ?response (create$ decrease increase))
       then
       (assert (future-book-value ?response))
       else
       (printout t "Invalid value. Please enter a valid value." crlf)))


(defrule increase-book-value
(future-book-value increase)
=>
(printout t "In a scale of 0-1, how sure do you think the book value would increase?" crlf)
(bind ?response(read))
(assert (increase-book-value ?response))
)

(defrule decrease-book-value
(future-book-value decrease)
=>
(printout t "In a scale of 0-1, how sure do you think the book value would decrease?" crlf)
(bind ?response(read))
(assert (decrease-book-value ?response))
)

; price to book value

(defrule ask-for-future-price-to-book-value
(introduction (done-introducting yes))
(or(increase-book-value ?a1)(decrease-book-value ?a2))
=>
(printout t "In future circumstances, would you think the price to book value for bbca would decrease or increase?" crlf)
(printout t "PS: The 3-years mean of bbca price to book value is 4.78" crlf)
(bind ?response(read))
(if (member$ ?response (create$ decrease increase))
       then
       (assert (future-price-to-book-value ?response))
       else
       (printout t "Invalid value. Please enter a valid value." crlf))
)

(defrule increase-price-to-book-value
(future-price-to-book-value increase)
=>
(printout t "In a scale of 0-1, how sure do you think the price to book value would increase?" crlf)
(bind ?response(read))
(assert (increase-price-to-book-value ?response))
)

(defrule decrease-book-value
(future-price-to-book-value decrease)
=>
(printout t "In a scale of 0-1, how sure do you think the book value would decrease?" crlf)
(bind ?response(read))
(assert (decrease-price-to-book-value ?response))
)

; conclude investor action on book-value

(defrule increase-book-value-AND-increase-price-to-book-value
(increase-book-value ?c1)
(increase-price-to-book-value ?c2)
=>
   (assert (investor-action (action buy-bbca) (certainty (* (min ?c1 ?c2) 0.7))))
   (printout t "Based on increase in book value and price to book value, you should buy bbca with a certainty of " (* (min ?c1 ?c2) 0.7) crlf crlf)
)

(defrule increase-book-value-OR-increase-price-to-book-value
(or (and (increase-book-value ?c1)
(decrease-price-to-book-value ?c2))
(and (decrease-book-value ?c1)
(increase-price-to-book-value ?c2))
)
=>
(assert (investor-action (action buy-bbca) (certainty(* (max ?c1 ?c2) 0.4))))
(printout t "Based on increase in book value or price to book value, you should buy bbca with a certainty of " (* (max ?c1 ?c2) 0.4) crlf crlf)
)

(defrule decrease-book-value-AND-decrease-price-to-book-value
(decrease-book-value ?c1)
(decrease-price-to-book-value ?c2)
=>
(assert (investor-action (action sell-bbca) (certainty(* (min ?c1 ?c2) 0.9))))
(printout t "Based on decrease in book value and price to book value, you should sell bbca with a certainty of " (* (min ?c1 ?c2) 0.9) crlf crlf)
)

; earning per share

(defrule ask-for-future-earning-per-share
(introduction (done-introducting yes))
(or (increase-price-to-book-value ?a1) (decrease-price-to-book-value ?a2))
=>
(printout t "In future circumstances, would you think the earning per share for bbca would decrease or increase?" crlf)
(printout t "PS: The 3-years mean of bbca earning per share is 326.34" crlf)
(bind ?response(read))
(if (member$ ?response (create$ decrease increase))
       then
       (assert (future-earning-per-share ?response))
       else
       (printout t "Invalid value. Please enter a valid value." crlf))
)

(defrule increase-earning-per-share
(future-earning-per-share increase)
=>
(printout t "In a scale of 0-1, how sure do you think the earning per share would increase?" crlf)
(bind ?response(read))
(assert (increase-earning-per-share ?response))
)

(defrule decrease-earning-per-share
(future-earning-per-share decrease)
=>
(printout t "In a scale of 0-1, how sure do you think the earning per share would decrease?" crlf )
(bind ?response(read))
(assert (decrease-earning-per-share ?response))
)

; price to earning

(defrule ask-for-future-price-to-earning
(introduction (done-introducting yes))
(or (increase-earning-per-share ?a1) (decrease-earning-per-share ?a2))
=>
(printout t "In future circumstances, would you think the price to earning for bbca would decrease or increase?" crlf)
(printout t "PS: The 3-years mean of bbca price to earning is 27.45" crlf)
(bind ?response(read))
(if (member$ ?response (create$ decrease  increase))
       then
       (assert (future-price-to-earning ?response))
       else
       (printout t "Invalid value. Please enter a valid value." crlf))
)

(defrule increase-price-to-earning
(future-price-to-earning increase)
=>
(printout t "In a scale of 0-1, how sure do you think the price to earning would increase?" crlf )
(bind ?response(read))
(assert (increase-price-to-earning ?response))
)

(defrule decrease-price-to-earning
(future-price-to-earning decrease)
=>
(printout t "In a scale of 0-1, how sure do you think the price to earning would decrease?" crlf)
(bind ?response(read))
(assert (decrease-price-to-earning ?response))
)

; conclude investor action on earning-per-share

(defrule increase-earning-per-share-AND-increase-price-to-earning
(increase-earning-per-share ?c1)
(increase-price-to-earning ?c2)
=>
(assert (investor-action (action buy-bbca) (certainty(* (min ?c1 ?c2) 0.5))))
(printout t "Based on increase in earning per share and price to earning, you should buy bbca with a certainty of " (* (min ?c1 ?c2) 0.5) crlf crlf)
(assert (input-done yes))
)

(defrule increase-earning-per-share-OR-increase-price-to-earning
(or (and (increase-earning-per-share ?c1)
(decrease-price-to-earning ?c2))
(and (decrease-earning-per-share ?c1)
(increase-price-to-earning ?c2))
)
=>
(assert (investor-action (action buy-bbca)  (certainty(* (max ?c1 ?c2) 0.3))))
(printout t "Based on increase in earning per share or price to earning, you should buy bbca with a certainty of " (* (max ?c1 ?c2) 0.3) crlf crlf)
(assert (input-done yes))
)

(defrule decrease-earning-per-share-AND-decrease-price-to-earning
(decrease-earning-per-share ?c1)
(decrease-price-to-earning ?c2)
=>
(assert (investor-action (action sell-bbca) (certainty(* (min ?c1 ?c2) 0.5))))
(printout t "Based on decrease in earning per share and price to earning, you should sell bbca with a certainty of " (* (min ?c1 ?c2) 0.5) crlf crlf)
(assert (input-done yes))
)

; calculate certainties

(defrule calculate-cf-both-positive
   ?fact1 <- (investor-action (action ?act) (certainty ?c1&:(>= ?c1 0)))
   ?fact2 <- (investor-action (action ?act) (certainty ?c2&:(>= ?c2 0)))
   (test (neq ?fact1 ?fact2))
   =>
   (retract ?fact1 ?fact2)
   (bind ?c3 (- (+ ?c1 ?c2) (* ?c1 ?c2)))
   (assert (investor-action (action ?act) (certainty ?c3))))


(defrule calculate-cf-both-negative
   ?fact1 <- (investor-action (action ?act) (certainty ?c1&:(<= ?c1 0)))
   ?fact2 <- (investor-action (action ?act) (certainty ?c2&:(<= ?c2 0)))
   (test (neq ?fact1 ?fact2))
   =>
   (retract ?fact1 ?fact2)
   (bind ?c3 (+ (+ ?c1 ?c2) (* ?c1 ?c2)))
   (assert (investor-action (action ?act) (certainty ?c3))))


(defrule calculate-cf-opposite-signs
   ?fact1 <- (investor-action (action ?act) (certainty ?c1&:(>= ?c1 0)))
   ?fact2 <- (investor-action (action ?act) (certainty ?c2&:(<= ?c2 0)))
   =>
   (retract ?fact1 ?fact2)
   (bind ?c3 (/ (+ ?c1 ?c2) (- 1 (min (abs ?c1) (abs ?c2)))))
   (assert (investor-action (action ?act) (certainty ?c3)))
)

; display the result

(defrule display-buy-bbca
?fact1<-(investor-action (action buy-bbca) (certainty ?c1))
(not  (investor-action (action buy-bbca) (certainty ?c2&:(neq ?c1 ?c2))))
(input-done yes)
=>
(printout t "Based on the information you provided, you should buy bbca with a certainty of " ?c1 crlf crlf)
)

(defrule display-sell-bbca
?fact1<-(investor-action (action sell-bbca) (certainty ?c1))
(not  (investor-action (action sell-bbca) (certainty ?c2&:(neq ?c1 ?c2))))
(input-done yes)
=>
(printout t "Based on the information you provided, you should sell bbca with a certainty of " ?c1 crlf crlf)
)