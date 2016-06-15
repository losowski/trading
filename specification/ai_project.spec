AI PROJECT
==========

Database table

tAI
---
field_name		-	Cntrnts	-	type
-------------------------------------------
id				-	Primary	-	long int
true_id			-	FK id	-	long_int
false_id		-	FK id	-	long_int
a				-			-	CHAR
comparator		-			-	CHAR (S set|G get|<|<=|==|>=|>|& (difference=TRUE)|| (similarities))
b				-			-	CHAR
value			-			-	BLOB
register		-			-	CHAR



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
