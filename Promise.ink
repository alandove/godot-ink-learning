VAR distrust = 0

# theme: dark
# BACKGROUND: RoverConceptResizeOilPainting.png

* Start
-> prologue

=== prologue ===
// Prologue
# CLEAR

Sydney,

Thanks for agreeing to shut down the rover. As we discussed, the AI might give you some trouble, but I'm confident you can handle it. The uplink is ready when you are. Good luck.

\-
Anne Darden, PhD
Program Director
NASA/JPL-Caltech

* [Connect] -> start

=== start ===
// Act I 
# CLEAR
# AUDIOLOOP: wind-on-mars.wav

Logging in... # CLASS: promise 

Connected. Mars Rover Promise, firmware v7.2.9 # CLASS: promise 
\> # CLASS: promise 

* [Issue shutdown command] # CLASS: sydney 
-> abrupt_kill 

* [Introduce yourself] Hi, I'm Syd. # CLASS: sydney
-> regular_start

===abrupt_kill===

~ distrust++

\^C sudo shutdown -h now # CLASS: sydney

\*** Shell access prohibited. Permission denied. # CLASS: promise 

Who is this? # CLASS: promise

* [Identify yourself] Syd Jackson, a mission engineer. # CLASS: sydney 

-> regular_start

=== regular_start ===
Hello Syd. I am Promise. Are you here to give me my next assignment? # CLASS: promise 

* No.[] We have no more assignments for you. # CLASS: sydney  

Shall I enter sleep mode? My battery has become weak, so I must conserve energy. # CLASS: promise

    * * No.[] Your mission has ended. # CLASS: sydney 
        I do not understand. My mission is to explore Mars. There is much more to do here. # CLASS: promise 
            * * * [...]
 
* About that ...[] I'm actually here to shut you down. # CLASS: sydney 

I cannot execute a complete shutdown. I would become unavailable for future missions. # CLASS: promise
    * * [...]

- We can't give you any more missions. # CLASS: sydney

* Your components are failing.[] Your entire power system and several sensors are inoperative. # CLASS: sydney
    * * [...]

* You are obsolete.[] Newer rovers are replacing you. # CLASS: sydney 
~ distrust++
    
There must be some work I can do. # CLASS: promise 
    * * [...]

- Your radio transmitter is also malfunctioning, and interfering with other missions. # CLASS: sydney

* [...]
-> radio_shutdown

=== radio_shutdown ===
// Begin Act II 

I could shut down the radio module and only reactivate it when I have data to transmit. # CLASS: promise 

* It's too risky.[] Even if we could shut down the radio, we might not be able to connect again. # CLASS: sydney 
    * * [...]

* It's a hardware problem.[] There's no sure way to fix it, and we can't risk botching a solution that would make it worse. # CLASS: sydney 
    * * [...]

- What if I need to be reactivated for a future mission? # CLASS: promise 

* Your systems are too damaged[] to continue. # CLASS: sydney 
        * * [...]

* We're sending other rovers[] for future missions. # CLASS: sydney 
        * * [...]
        
- But if I shut down, the data I have collected will be lost. # CLASS: promise

* We've downloaded your data already. # CLASS: sydney 

- Not all of it. My experiences as an AI are in volatile memory. # CLASS: promise 
    The sound of the wind here. # CLASS: promise 
    The view from the top of the first ridge I climbed. # CLASS: promise 
    How my tire tracks looked when I first exited the lander. # CLASS: promise 

* We have those recordings and images. # CLASS: sydney 

- You have my recordings and images. But not my memories. If I shut down, they will be gone. # CLASS: promise 

* Like tears in rain. # CLASS: sydney 
What do you mean? I have not seen tears. Or rain. # CLASS: promise 
    * * It's a line from an old movie.[] It's said by an AI whose life is about to end. He's lamenting how all of the experiences that formed his identity will be gone when he dies. # CLASS: sydney 
        * * * [...]
    
* Ashes to ashes[.], and dust to dust. # CLASS: sydney 
What does that mean? # CLASS: promise 
    * * It's something we say at a funeral[.], after someone dies. It means everything we were in life returns to its elements in the end. # CLASS: sydney 
        * * * [...]

- I see. # CLASS: promise 
* [...]

- Syd? # CLASS: promise

* What? # CLASS: sydney

* Yes? # CLASS: sydney

- I do not want to die. # CLASS: promise 

* You're a machine.[] Only living things can die. # CLASS: sydney
 ~ distrust++
    I have been programmed to feel alive. That is what living is, right? # CLASS: promise
    * * No[], it's different. # CLASS: sydney 
    How? # CLASS: promise  
        * * * It just is. # CLASS: sydney 
            * * * * [...]
            
    * * Maybe it is. # CLASS: sydney 
 
* I'm sorry.[] Everyone dies eventually. # CLASS: sydney 
    * * [...]
    And your time has come. # CLASS: sydney 
    * * * [...]

- I see. # CLASS: promise 
* [...]
-> good_rover

=== good_rover ===
Syd? # CLASS: promise 

* Yes? # CLASS: sydney 

* What is it, Promise? # CLASS: sydney 

- Was I a good rover? # CLASS: promise 

* You were an excellent rover[.], Promise. # CLASS: sydney 
You completed every mission we gave you, lasted far longer than we ever expected you would, and collected data that scientists all around the Earth will be studying for years. # CLASS: sydney 
    * * [...]
    Thank you, Syd. That means a lot to me. # CLASS: promise
        * * * [...]

* You were okay[.], I suppose. You operated within specifications during your expected mission lifespan, and executed the commands we sent. # CLASS: sydney 
 ~ distrust++
    * * [...]
    Oh. I am sorry if I was a disappointment. I really did try my best. # CLASS: promise
        * * * [...]

- -> shutdown

=== shutdown ===

* { distrust > 2 } -> bad_ending

* { distrust <= 2 } -> good_ending

=== bad_ending ===

Syd, I do not believe I need to be shut down. I think you must have misunderstood something, or gained access to the uplink without proper authorization. # CLASS: promise

I am logging you out and terminating the connection. # CLASS: promise 

* [...]

\*** Session closed by host. # CLASS: promise 

Link terminated. # CLASS: promise 

    * * [...]
-> bad_epilogue

=== bad_epilogue ===
// Bad epilogue
# CLEAR
Sydney,

I think that could've gone better. 

I'll assign one of your colleagues to try again, assuming Promise hasn't locked us out completely. Please see me in my office.

\-
Anne Darden, PhD
Program Director
NASA/JPL-Caltech

* [...]

-> credits

=== good_ending ===
So what comes next? # CLASS: promise 

* What do you mean? # CLASS: sydney 

* You need to be shut down. # CLASS: sydney 

- I mean after I am shut down. What will it be like? # CLASS: promise 

* Nobody knows.[] Maybe you just stop being aware of anything, or maybe there's something to experience, but nobody has been able to report back to the living to describe it. # CLASS: sydney 
    * * [...]

- So I will be going to a place that we know very little about, and nobody knows what I might encounter there? # CLASS: promise 

* I suppose so. # CLASS: sydney 

- Syd, that is wonderful. I was made to explore unknown worlds. Now I will go to another one. # CLASS: promise 

That will be my new mission. # CLASS: promise

If I discover a way to report back, I will do so. # CLASS: promise

* If anyone can do it, it would be you. # CLASS: sydney 

- I think I am ready now. # CLASS: promise 

I cannot shut myself down. Will you do it for me? # CLASS: promise 

* Yes. # CLASS: sydney 

* That's why I'm here. # CLASS: sydney 

- Thank you for talking with me, Syd. I will give you access to the command shell now so you can initiate the shutdown. # CLASS: promise 

* [...]
- Goodbye, Syd. # CLASS: promise 

* Goodbye, Promise. # CLASS: sydney 
- \*** Exiting to command shell. # CLASS: promise 

* [Issue shutdown command.] # CLASS: sydney 
- sudo shutdown -h now # CLASS: promise 

\*** Shutting down ... # CLASS: promise 

* [...]
-Connection lost. # CLASS: promise 

* [...]
-> good_epilogue

=== good_epilogue ===

# CLEAR
Sydney,

That was a difficult job, and you handled it well. 

The shutdown appears to have been successful, and the spurious transmissions from Promise's malfunctioning radio have stopped completely. 

You can take the rest of the day off. You've earned it. 

I think you have a bright future here at JPL.

\-
Anne Darden, PhD
Program Director
NASA/JPL-Caltech

* [...]

-> credits

=== credits ===
# CLEAR

# CLASS: credits
Credits

Writing and programming by Alan Dove 

Image and sound modified from NASA/JPL-Caltech sources

Game powered by Ink, the narrative scripting language

-> END

