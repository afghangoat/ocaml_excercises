

(*let make_poetry len = 
  Printf.printf "Paragrap number %d \n" len;
  let str = "[Click here and insert a PICTURE (mandatory)]";
  str *)

let show_intset x =
    let buf = Buffer.create 128 in
    let rec loop x n =
        if x <> 0 then
            begin
            if x mod 2 = 1 then
                begin
                if Buffer.contents buf <> "" then
                    Buffer.add_string buf ", ";
                Buffer.add_string buf (string_of_int n)
                end;
            loop (x / 2) (n + 1)
            end
    in
    loop x 0;
    Buffer.contents buf

let poetry_words_first = [
  "silver"; "crimson"; "whispering"; "ancient"; "lonely"; "burning"; "hollow";
  "silent"; "midnight"; "gilded"; "ashen"; "wandering"; "falling"; "eternal";
  "moonlit"; "fragile"; "sacred"; "stormy"; "tender"; "echoing"; "forest"; "dream"; "river"; "embers"; "sky"; "veil"; "horizon";
  "ashes"; "petal"; "flame"; "shore"; "mist"; "memory"; "stone";
  "shadow"; "garden"; "sorrow"; "mirror"; "wind"; "light"
]

let poetry_words_second = [
  "is"; "was"; "are"; "were"; "be"; "been"; "being";
  "like"; "as"; "in"; "on"; "under"; "above"; "beyond";
  "of"; "to"; "from"; "with"; "without"; "between"; "among";
  "there"; "here"; "then"; "when"; "while"; "where";
  "and"; "but"; "or"; "so"; "for"; "yet"; "nor";
  "if"; "though"; "because"; "before"; "after"; "until";
  "upon"; "within"; "around"; "through"; "into"; "over"
]

let words_count_first= List.length poetry_words_first
let words_count_second= List.length poetry_words_second

let make_poetry len =
  let buf = Buffer.create 1024 in
  let rec loop x n=
    if x <> 0 then
      begin
      if x mod 2 == 1 then
        begin
          let word_index : int = Random.int words_count_first in
          Buffer.add_string buf (List.nth poetry_words_first word_index);
          
        end
      else
        begin
          let word_index : int = Random.int words_count_second in
          Buffer.add_string buf (List.nth poetry_words_second word_index);
        end;
      if n mod 5 == 4 then
        begin
          if x mod 2 == 1 then
            begin
              Buffer.add_string buf ",\n";
            end
          else
            Buffer.add_string buf ".\n";
          loop (x-1) (0)
        end
      else
        begin
          Buffer.add_string buf " ";
          loop (x-1) (n+1)
        end;
      end
  in
  loop len 0;
  Buffer.contents buf

let () =
  
  (*let q = show_intset 10 in
  Printf.printf "Paragrap number %s \n" q;*)

  let len = 100 in
  let poetry = make_poetry len in
  Printf.printf "Poetry generated with length=%d: \n%s" len poetry;

(*
Example output: 
Poetry generated with length=100: 
here veil after embers there.
flame from echoing until memory,
without wind like fragile between.
ashen until falling where shadow,
being horizon as stormy being.
moonlit when silver been sky,
like mirror between sorrow upon.
sky was mist on stone,
until silent as ancient be.
flame is light within ashen,
there shore after silent above.
lonely but mist after ashen,
upon tender as eternal after.
eternal there flame are ancient,
is garden where light be.
sacred before mirror with dream,
within sacred so lonely nor.
flame being embers upon moonlit,
on eternal there mirror of.
memory so ashes and sorrow,
*)