AI PROJECT
==========

HIGH LEVEL DESIGN
-----------------
- Produce an AI that links registers and data
- Basically emulates an infinitely powerful microcontroller
- Provide a very simple 


Database table
--------------

tAI
---
field_name		-	Cntrnts	-	type
-------------------------------------------
id				-	Primary	-	long int
true_id			-	FK id	-	long_int
false_id		-	FK id	-	long_int
a				-			-	CHAR
comparator		-			-	CHAR (S set|G get|<|<=|==|!=|>=|>|& (difference=TRUE)| | (similarities) ~ (like - true if more than 75% or so matches)
b				-			-	CHAR
value			-			-	BLOB
register		-			-	CHAR


- This structure is to be the same in the compiled code.
	Obviously BLOB is the same as CHAR + LENGTH
- This length is OK as the entire thing will be autogenerated(python)
- Code must compile into C Structs
	- May have to link into python for the DB connection (to be lazy).
	- C-Stack must always unravel properly,
		- the internal stack we make is a round-robin stack to push too hard


Usage Description
-----------------
INITIALISATION:
- Basic library of knowledge built in
- Load in the libraries represented by register and A
	- A by default will be the register, B can be a constant or a register (but must be initialised as A first = "A != NULL" or "register=blah, value=NULL" for explicit settings
- Wait on a variable to change value (be notified of the change)
	- take actions

LOADING NEW VARIABLE:
- All variables are to be stored in /dev/shm
- All variables are to be provided by a libary
- When a new variable is required,
	1) Hunt the library folder for a dynamic linked library
	2) Load it and use the library
	3) The unknown returns NULL
		- this is to be interpreted as void, and cannot be used to decide (returns false)
- All the internal "READ" function are mapped in a queue for this entry, for quick access.
	- This cannot be planned beforehand (unless by a live query), as it is both library specific, and based on runtime.

RUNNING:
- Interrupt
	- A variable changes
		- Find the get functions that read this
		- Process each one in a cascade
- Set
	- copies value into "register"
		- This will trigger whatever the library action is, and this will be performed before we return.
			- If it is asyncronous, then make it work that way.
	- Moves to true_id
- Get
	- copies register into value
	- moves to true_id
- Comparators
	- & and | are string comparators
	- ~ is a comparator to apply to strings or numbers
		- Checks if they are close
	- Numeric comparators (gt|eq|lt)
		- For strings compares differences like &
			- lt means A must be less data than B
			- gt means B must be less data than A
			- eq means they are equivalent

LOGIC:
	- Recursion loops must have a test in them (else we kick out)
	- Infinite recursion allowed (round robin stack)
	- Each request looks up the next value (emulates the behaviour)
	- Each branch is to be executed (knowledge tree)
		- We keep track of which branch we followed, and make sure when we unravel the stack we don't repeat the same branch


Names:
------
ELMO
	Eugene's Learning Modelling Objective
ANITA
	A nice intelligent thoughtful AI
MIA
	Machine Intelligence Achieved
AI
	Another Intelligence
JARVIS
	Just Another Real Very Intelligent System





These compile into an application language
-------------------------------------------
(Comparator)
IF (a) (comparator) (b) THEN 
LABEL	MYTRUE:
	IF (true_id) != NULL THEN:
		GOTO PUSH true_id;
		GOTO PTR  true_id; //Jump function pointer to here
	ELSE
		GOTO PUSH myused SET WITH 'mytrue';
		GOTO RUN MYFALSE;
		GOTO PUSH mytrue SET WITH (ptr_id = (*this));
	END IF;
ELSE
LABEL	MYFALSE:
	IF (false_id) != NULL THEN:
		GOTO PUSH false_id;
		GOTO PTR false_id; //Jump function pointer to here
	ELSE
		IF GOTO POP myused IS SET TO 'myfalse' THEN
			NO OP
		ELSE
			GOTO RUN GOTO POP mytrue;
		END IF;
		GOTO PUSH myused SET WITH 'myfalse';
		GOTO RUN MYFALSE;
		GOTO PUSH mytrue SET WITH (ptr_id = (*this));
	END IF;
END IF
;


	


F (a) (comparator) (b) THEN 
LABEL	MYTRUE:
	IF (true_id) != NULL THEN:
		GOTO PUSH true_id;
		GOTO PTR  true_id; //Jump function pointer to here
	ELSE
		GOTO PUSH myused SET WITH 'mytrue';
		GOTO RUN MYFALSE;
		GOTO PUSH mytrue SET WITH (ptr_id = (*this));
	END IF;
ELSE
LABEL	MYFALSE:
	IF (false_id) != NULL THEN:
		GOTO PUSH false_id;
		GOTO PTR false_id; //Jump function pointer to here
	ELSE
		IF GOTO POP myused IS SET TO 'myfalse' THEN
			NO OP
		ELSE
			GOTO RUN GOTO POP mytrue;
		END IF;
		GOTO PUSH myused SET WITH 'myfalse';
		GOTO RUN MYFALSE;
		GOTO PUSH mytrue SET WITH (ptr_id = (*this));
	END IF;
END


# Always jump rather than call a function - we don't car about state

(write register)
IF COMPARATOR == "G" THEN
	SET value TO (*register);
	GOTO POP
END F
;

(read register)
IF COMPARATOR == "S" THEN
	SET value FROM (*register);
END F
;






//NEWER VERSION for all
PRFX_true_function() (
	//if true:
	LABEL PRFX_true;
	IF (peep stack_bool() == true)
	(
		pop stack_bool();
		goto peep stack_ptr();
		pop stack_ptr();
	)
	ELSE
	(
		push stack_bool(true);
		push stack_ptr(&PRFX_false_function);
	)
)

PRFX_false_function() (
	//if false:
	LABEL PRFX_false;
	IF (peep stack_bool() == false)
	(
		pop stack_bool();
		goto peep stack_ptr();
		pop stack_ptr();
	)
	ELSE
	(
		push stack_bool(false);
		push stack_ptr(&PRFX_true_function);
	)
)
)

main() {
	stack_ptr  = RoundRobinStack();
	stack_bool = RoundRobinStack();
	GOTO 0;
	if (a) (comparator) (b)
	{
		PRFX_true_function();
	}
	else
	{
		PRFX_false_function()
	}
}




Implementation
===============
libraries provide the register names
- Functions
	- read (capped at 1 blob)
	- write
	- operators
		(<|<=|==|>=|>|& (difference=TRUE)|| (similarities))
Compiler:
- Compiles the code as follows
- All registers to be declared from all the named values in the database
		- These are to be blobs of Ram
	- working registers:
		value			=	blob type
		stack_ptr		= 	a round robbin stack storing only ID OR NULL
		stack_bool		= 	a round robbin stack storing only TRUE and FALSE
			FUNCTIONS:	1) pop, peep, put (get and remove, get, set)
	- Variable declaration:
		- List taken from register, a and b
	- All variables initialised with zero (NULL)

Executable:
	- All variables initialed golbally (importing <variable_name> library to link with)
	- Implement any if else statement as GOTO only.
		IF TRUE //Next ID
