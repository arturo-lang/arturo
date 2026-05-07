
>> :task value
[+] passed!
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

>> map.async — fan-out parallel map
[+] passed!

>> map.parallel — order preserved
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
