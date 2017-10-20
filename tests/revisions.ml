open Printf
open Lwt
module D = Dropbox_lwt_unix

let revisions t fn =
  D.revisions t fn >>= function
  | Some metadata_list ->
     let show_rev metadata =
       let d =
         Dropbox.Date.to_string metadata.D.server_modified
       in
       sprintf "rev: %s (%s)" metadata.D.rev d in
    let revisions = String.concat "\n" (List.map show_rev metadata_list) in
    Lwt_io.printlf "%s" revisions
  | None -> Lwt_io.printlf "No file %S." fn

let main t args =
  match args with
  | [] -> Lwt_io.printlf "No file specified"
  | _ -> Lwt_list.iter_p (revisions t) args

let () =
  Common.run main
