crimes <- c(
  "Arson",
  "Assault",                                  
  "Burglary",                                 
  "Case Closure",                             
  "Civil Sidewalks",                          
  "Courtesy Report",                          
  "Disorderly Conduct",                       
  "Drug Offense",                             
  "Drug Violation",                           
  "Embezzlement",                             
  "Family Offense",                           
  "Fire Report",                              
  "Forgery And Counterfeiting",               
  "Fraud",                                    
  "Gambling",                                 
  "Homicide",                                 
  "Human Trafficking (A), Commercial Sex Acts",
  "Human Trafficking, Commercial Sex Acts",   
  "Juvenile Offenses",                        
  "Larceny Theft",                            
  "Liquor Laws",                              
  "Lost Property",                            
  "Malicious Mischief",                       
  "Miscellaneous Investigation",              
  "Missing Person",                           
  "Motor Vehicle Theft",                      
  "Motor Vehicle Theft?",                     
  "Non-Criminal",                             
  "Offences Against The Family And Children", 
  "Other",                                    
  "Other Miscellaneous",                      
  "Other Offenses",                           
  "Prostitution",                             
  "Rape",                                     
  "Recovered Vehicle",                        
  "Robbery",                                  
  "Sex Offense",                              
  "Stolen Property",                          
  "Suicide",                                  
  "Suspicious",                               
  "Suspicious Occ",                           
  "Traffic Collision",                        
  "Traffic Violation Arrest",                 
  "Vandalism",                                
  "Vehicle Impounded",                        
  "Vehicle Misplaced",                        
  "Warrant",                                  
  "Weapons Carrying Etc",                     
  "Weapons Offence",                          
  "Weapons Offense"
)

grep("a", crimes)

crimes[grep("a", crimes)]

grep("Theft", crimes)

crimes[grep("Theft", crimes)]

grep("Theft", crimes, value = TRUE)

grep("theft", value = TRUE, crimes)

grep("theft", crimes, value = TRUE, ignore.case = TRUE)

grep("theft", crimes, value = TRUE, ignore.case = TRUE, invert = TRUE)

gsub("a", "z", "cat")

gsub("A", "z", "cat")

gsub("A", "z", "cat", ignore.case = TRUE)

gsub("Offence", "Offense", crimes)

gsub("a", "", crimes)

grep("[xyz]", crimes, value = TRUE)

grep("[zyx]", crimes, value = TRUE)

grep("[01234567890]", crimes, value = TRUE)

grep("[aeiou][aeiou][aeiou]", crimes, value = TRUE)

grep("[x-z]", crimes, value = TRUE)

grep("[aeiou]{3}", crimes, value = TRUE)

grep("[aeiou]{2,3}", crimes, value = TRUE)

grep("[aeiou]{3,3}", crimes, value = TRUE)

grep("[aeiou]{,3}", crimes, value = TRUE)

grep("[aeiou]{3,}", crimes, value = TRUE)

grep("^Family", crimes, value = TRUE)

grep("Theft$", crimes, value = TRUE)

grep("Weapons Offen.e", crimes, value = TRUE)

grep("^[A-Za-z]+ [A-Za-z]+$", crimes, value = TRUE)

gsub("Weapons.*", "Weapons", crimes)

grep("Drug|Weapons", crimes, value = TRUE)

grep("(Offense)", crimes, value = TRUE)

grep("(Drug|Weapons) Offense", crimes, value = TRUE)

grep("Offens?", crimes, value = TRUE)

grep("(Drug|Weapons) Offens?", crimes, value = TRUE)

toupper(crimes)

tolower(crimes)
