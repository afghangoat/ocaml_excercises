(*
  Welcome to the official OCaml Playground!

  You don't need to install anything - just write your code
  and see the results appear in the Output panel.

  This playground is powered by OCaml 5 which comes with
  support for shared-memory parallelism through domains and effects.
  Below is some naive example code that calculates
  the Fibonacci sequence in parallel.
  
  Happy hacking!
*)

(*Keywords for myself:
let = variable declaration
rec = recursive
if then else = if
let () =... = main*)

let rec fib n =
  if n < 2 then 1
  else fib (n-1) + fib (n-2)

let rec fib_par n d =
  if d <= 1 then fib n
  else
    let a = fib_par (n-1) (d-1) in
    let b = Domain.spawn (fun _ -> fib_par (n-2) (d-1)) in
    a + Domain.join b

let rec fac n =
  if n < 2 then 1
  else fac(n-1)*n

(*
def naive_ackermann(m, n):
    global calls
    calls += 1
    if m == 0:
        return n + 1
    elif n == 0:
        return naive_ackermann(m - 1, 1)
    else:
        return naive_ackermann(m - 1, naive_ackermann(m, n - 1))
*)

let rec ack m n =
  if m == 0 then n+1
  else if n==0 then
    ack (m-1) (1)
  else
    ack (m-1) (ack (m) (n-1))

let num_domains = 2
let n = 20
let m= 10
let () =
  
  let res = fib_par n num_domains in
  Printf.printf "fib(%d) = %d\n" n res;

  let fac_res = fac m in
  Printf.printf "fac(%d) = %d\n" m fac_res;

  let ack_res = ack 1 1 in
  Printf.printf "ack(1,1) = %d\n" ack_res;

(*
  By the way, a much better, single-threaded implementation that calculates
  the Fibonacci sequence is this:

  let rec fib m n i =
    if i < 1 then m
    else fib n (n + m) (i - 1)

  let fib = fib 0 1

  For a more in-depth, realistic example of how to use
  parallel computation, take a look at
  https://v2.ocaml.org/releases/5.0/manual/parallelism.html#s:par_iterators
*)
