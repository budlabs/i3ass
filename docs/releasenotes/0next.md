## broken regex search now works

fix for issue #211 .  
Big thanks to @henryzxb for reporting

Allthough small, this change affects all i3ass commands,
except i3king. Hopefully we didn't break something.

^ above fix introduced an issue with i3get without criterion
(targeting the active window), but it is now fixed
