;; A component whose `f` returns the `map<u32, u32>` `{1: 2}`, which WAVE can't
;; render yet.
(component
  (core module $m
    (memory (export "memory") 1)
    ;; The single (key, value) entry.
    (data (i32.const 16) "\01\00\00\00\02\00\00\00")
    ;; The returned (pointer, length) pair.
    (data (i32.const 32) "\10\00\00\00\01\00\00\00")
    (func (export "f") (result i32) i32.const 32)
    (func (export "realloc") (param i32 i32 i32 i32) (result i32) unreachable))
  (core instance $i (instantiate $m))
  (func (export "f") (result (map u32 u32))
    (canon lift (core func $i "f") (memory (core memory $i "memory")) (realloc (core func $i "realloc")))))
