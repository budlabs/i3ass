### v.0.1.6 - new installation scripts

Added [Makefile] and updated [install.sh] to include (*optional*) systemwide and manpage installation.

### v.0.1.6 - [i3list]  

**Breaking change**  
Complete rewrite, script is faster and output is more readable and usable (*array format*). If you have scripts relying on i3list, you need to make changes.  

### v.0.1.6 - [i3viswiz]  
**Breaking change**  
Changed output format and added more options to output. Focusing works as before, but if you have scripts that relies on the output (`-p`), you might need to update your scripts.  

### v.0.1.6 - [i3fyra]  
**Code cleanup**  
Made a big code cleanup and removed big chunks are now handled by i3var,i3viswiz and i3list. Added more comments to the code and made the whole thing more stable, I hope this will resolve many issues that some users have reported. No breaking changes or new features.

### v.0.1.6 - [i3run]  

**improvements**  
Adapted the script to use the new [i3list] which resulted in faster execution times.  

**new options**    

  - `-m` position floating window at cursor (*was default in previous version*)  
  - `-x OLDNAME` rename new windows when they are created.

### v.0.1.6 - [i3flip]

**direction arguments**  
More directions then p,n,prev,next are now allowed. up, left, prev, u, l, p all do the same thing. Same with: down, right, next, d, r, n.    
