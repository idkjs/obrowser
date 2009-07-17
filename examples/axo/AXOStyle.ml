(* This module is for tampering with style properties *)

open JSOO

type position =
  | Absolute
  | Fixed
  | Relative

type dim =
  | Px of int
  | Ex of int
  | Em of int
  | Pct of int

let px x = Px x
let ex x = Ex x
let em x = Em x
let pct x = Pct x

type color = string

class style obj =
object
  val sty = obj >>> get "style"

  (* generic methods *)
  method set_dim (n : string) (v : dim) : unit =
    sty >>> set n
      (match v with
	 | Px v -> string (string_of_int v ^ "px")
	 | Ex v -> string (string_of_int v ^ "px")
	 | Em v -> string (string_of_int v ^ "px")
	 | Pct v -> string (string_of_int v ^ "%")
      )

  (* properties *)
  method position : position =
    match sty >>> get "position" >>> as_string with
      | "fixed" -> Fixed
      | "absolute" -> Absolute
      | "relative" -> Relative
      | _ -> Relative
  method set_position (v : position) : unit =
    match v with
      | Fixed -> sty >>> set "position" (string "fixed")
      | Relative -> sty >>> set "position" (string "relative")
      | Absolute -> sty >>> set "position" (string "absolute")

  method z_index : int =
    sty >>> get "zIndex" >>> as_int
  method set_z_index (z : int) : unit =
    sty >>> set "zIndex" (int z)

  method background_color : color =
    sty >>> get "background" >>> as_string
  method set_background_color (c : color) : unit =
    sty >>> set "background" (string c)

end

let style obj =
  try
    Obj.obj (obj >>> get "caml_style" >>> as_block)
  with Failure "as_block" ->
    let style = new style obj in
      obj >>> set "caml_style" (inject (Block (Obj.repr style))) ;
      style


class geometry obj = object (self)
  method width : int =
    obj >>> get "offsetWidth" >>> as_int
  method set_width (w : int) : unit =
    (obj >>> style) # set_dim "width" (px w)
  method height : int =
    obj >>> get "offsetHeight" >>> as_int
  method set_height (h : int) : unit =
    (obj >>> style) # set_dim "height" (px h)
  method x : int =
    obj >>> get "offsetLeft" >>> as_int
  method set_x (x : int) : unit =
    (obj >>> style) # set_dim "left" (px x)
  method y : int =
    obj >>> get "offsetTop" >>> as_int
  method set_y (y : int) : unit =
    (obj >>> style) # set_dim "top" (px y)
  method bounds : int * int * int * int =
    self # x, self #  y, self # width, self # height
  method set_bounds (x, y, w, h) : unit =
    self # set_x x;
    self # set_y y;
    self # set_width w;
    self # set_height h
  initializer
    match (obj >>> style) # position with
      | Relative -> (obj >>> style) # set_position Absolute
      | Fixed | Absolute -> () (* respect previous mode *) 
end

let geometry obj =
  try
    Obj.obj (obj >>> get "caml_geometry" >>> as_block)
  with Failure "as_block" ->
    let geometry = new geometry obj in
      obj >>> set "caml_geometry" (inject (Block (Obj.repr geometry))) ;
      geometry