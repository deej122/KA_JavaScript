KA_JavaScript
=============
        
*KhanAcademy JavaScript Interview Project (in progress)*      
      
**Deployed to Heroku at: http://khanacademy-jstest.herokuapp.com/ [LINK IS ABOVE]**     

**Initial setup :**         

1 - `npm install`       
2 - `npm install -g bower`    
3 - `bower install`       
   
**In separate tabs run :**       

4 - `mongod` (to start mongo)   
5 - `node server.js` (to start server)   
6 - `sh bin/compile_coffee.sh` (to compile coffeescript files)   
        
Navigate to localhost:8080 in browser to use application   
      
    
===========
      
This application allows the user to select a set of restrictions to be set on JavaScript code. 
      
The restrictions are:
     
1 - Require a variable declaration        
2 - Require the use of an `if` statement        
		2a - require a `for` loop within the `if` statement       
		2b - require a `while` loop within the `if` statement        
3 - Require the use of a `for` loop        
		3a - require an `if` statement within the `for` loop       
		3b - require a `while` loop within the `for` loop        
4 - Require the use of a `while` loop        
		4a - require a `for` loop in the `while` loop       
		4b - require an `if` statement in the `while` loop      
            
5 - Do not allow a variable declaration        
6 - Do not allow the use of an `if` statement       
7 - Do not allow the use of a `for` loop       
8 - Do not allow the use of a `while` loop         

The user is then allowed to write JavaScript code in an embedded text editor and their code is compared to their restrictions, live. All errors are signified in red text at the bottom of the page; once all errors are fixed a green success message is displayed.
       
===========
     
Built using Angular.js and Node.js written in CoffeeScript with a MongoDB database (not used, but capable of being used if project is expanded upon), and HTML/CSS. Dependencies setup using NPM and Bower.
     
Used Acorn to parse the JavaScript mainly because of the superior documentation and the ease of setup with Node.
          
Used CodeMirror in place of a standard HTML textarea for aesthetic appeal and built-in JavaScript formatting capabilities.
       
===========
      
Tested and working in Google Chrome, Safari, and Mozilla Firefox -- yet to test in IE 8, 9
      
===========
     
DJ Jagannathan      
19 August 2014      