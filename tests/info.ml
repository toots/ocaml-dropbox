open Lwt
module D = Dropbox_lwt_unix

let main t args =
  D.info t >>= fun info ->
  let open Lwt_io in
  printlf "Name: %s (account_id: %s)\n\
           referral_link: %s\n\
           Country: %s  (locale: %s)\n\
           Is paired: %b\n"
          info.D.name.D.display_name info.D.account_id (Uri.to_string info.D.referral_link)
          info.D.country info.D.locale info.D.is_paired

let () =
  Common.run main
