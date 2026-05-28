
>> :task value
[+] passed!
[+] passed!
[+] passed!

>> do.async — eager by default (.lazy opts out)
[+] passed!
[+] passed!

>> do.async — in-process closure capture
[+] passed!
[+] passed!

>> do.async — :error fidelity
[+] passed!
[+] passed!

>> wait.all — order preserved
[+] passed!

>> wait.all — failures slot in as :error
[+] passed!

>> wait.first[.cancel]
[+] passed!

>> wait.timeout — bare wait with budget
[+] passed!
[+] passed!

>> cancel
[+] passed!

>> pause from main pumps the fiber scheduler
[+] passed!

>> do.async.isolated — subprocess flavor
[+] passed!
[+] passed!

>> do.isolated — sync subprocess execution
[+] passed!
[+] passed!

>> map.async — fan-out parallel map
[+] passed!

>> map.parallel — order preserved
[+] passed!

>> .parallel + .with: index injection
[+] passed!
[+] passed!

>> loop.async — fan-out side-effect loop
[+] passed!

>> select.parallel — order preserved
[+] passed!

>> every?.parallel
[+] passed!

>> some?.parallel
[+] passed!

>> :event value
[+] passed!

>> on / emit — payload via .with:
[+] passed!

>> off — bulk unsubscribe
[+] passed!

>> on.once — fires only once
[+] passed!

>> on .id + off id — per-handler unsubscribe
[+] passed!

>> task callbacks — on.done
[+] passed!

>> task callbacks — on.failed
[+] passed!

>> :channel value
[+] passed!

>> channel — buffered send / receive
[+] passed!

>> channel — close drains buffer then yields :null
[+] passed!

>> channel — unbuffered cross-fiber
[+] passed!

>> channel — bounded fan-out workers
[+] passed!

>> channel — polymorphic send / receive carry any value type
[+] passed!

>> socket — listen / accept / receive / send round-trip
[+] passed!

>> socket — receive.async with .timeout
[+] passed!

>> channel — cross-process fan-in (child → parent send)
[+] passed!

>> channel — cross-process worker pool (parent → child dispatch)
[+] passed!

>> channel — cross-process close propagation (parent unplug wakes child)
[+] passed!

>> channel — cross-process dict payload fidelity
[+] passed!

>> socket — connect.async parallel fan-out
[+] passed!
