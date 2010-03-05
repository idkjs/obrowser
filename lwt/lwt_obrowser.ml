(* Lightweight thread library for Objective Caml
 * http://www.ocsigen.org/lwt
 * Module Lwt_obrowser
 * Copyright (C) 2010 Vincent Balat and Rapha�l Proust
 * Laboratoire PPS - CNRS Universit� Paris Diderot
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, with linking exceptions;
 * either version 2.1 of the License, or (at your option) any later
 * version. See COPYING file for details.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 * 02111-1307, USA.
 *)


let sleep s = Lwt_preemptive.detach Thread.delay s

let yield () = sleep 0.0

(*
let http_post url args = Lwt_preemptive.detach (AXOCom.http_post url) args

let http_get_post url get_args post_args =
  Lwt_preemptive.detach (AXOCom.http_get_post url get_args) post_args
*)

  

(* old implementation was:

open Lwt

let (>=>) x f = f x

let sleep_ms t =
  let (res, w) = Lwt.task () in
  let f = Lwt.wakeup w (* � rev ! *) in
  let timeout =
    AXOJs.Node.window
    >=> JSOO.call_method "setTimeout" [| (* f ; *) JSOO.int t |]
  in
  Lwt.on_cancel res
    (fun () -> 
       AXOJs.Node.window
       >=> JSOO.call_method "clearTimeout" [| timeout |]
       >=> ignore);
  res
  
let sleep t =
  let t = int_of_float (t *. 1000.) in
  sleep_ms t

let yield () = sleep_ms 0

exception Timeout

let timeout d = sleep d >> Lwt.fail Timeout

let with_timeout d f = Lwt.select [timeout d; Lwt.apply f ()]

(* We do not need a run function *)


*)
