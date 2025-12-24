NOT true => false 
NOT maybe => maybe 
NOT false => true 

true AND true => true 
true AND maybe => maybe 
true AND false => false 
maybe AND true => maybe 
maybe AND maybe => maybe 
maybe AND false => false 
false AND true => false 
false AND maybe => false 
false AND false => false 

true OR true => true 
true OR maybe => true 
true OR false => true 
maybe OR true => true 
maybe OR maybe => maybe 
maybe OR false => maybe 
false OR true => true 
false OR maybe => maybe 
false OR false => false 

true XOR true => false 
true XOR maybe => maybe 
true XOR false => true 
maybe XOR true => maybe 
maybe XOR maybe => maybe 
maybe XOR false => maybe 
false XOR true => true 
false XOR maybe => maybe 
false XOR false => false