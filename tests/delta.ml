open Lwt
module D = Dropbox_lwt_unix

(** If there is no entry, we call delta without param.
    If there is one entry, we call delta with the param path_prefix as
       Sys.argv.(0).
    If there is two entries, we call delta with the param cursor as
       Sys.argv.(0) and the param path_prefix as the second. *)



let main t args =
  match args with
  | [] ->   D.delta t >>= fun delta ->
            Lwt_io.printlf "%s" (Dropbox_j.string_of_delta delta)
  | [path_prefix] ->
     D.delta t ~path_prefix >>= fun delta ->
     Lwt_io.printlf "%s" (Dropbox_j.string_of_delta delta)
  | [path_prefix; cursor] ->
     D.delta t ~cursor ~path_prefix >>= fun delta ->
     Lwt_io.printlf "%s" (Dropbox_j.string_of_delta delta)
  | _ ->
     Lwt_io.printf "Usage: delta [path_prefix [delta]]"

let () =
  Common.run main