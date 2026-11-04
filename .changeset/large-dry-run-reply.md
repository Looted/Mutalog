---
"mutalog": patch
---

Read large worker replies without running out of stack. The dry-run
reply carries every test's coverage and can reach megabytes on a big
suite; it was collected by appending code lists (quadratic) and parsed
from a code list, which exhausted the default stack and was reported as
"The dry run did not complete: crashed". Replies are now gathered as
strings and parsed from a string, and an error raised while reading a
reply, such as `resource_error(stack)`, is reported as that error
instead of `crashed`.
