namespace HelloQuantumWorld { // Namespace = collection of uniquely named operations and funcs (callables) and user-defined types
    open Microsoft.Quantum.Intrinsic; // Open directive to use Message from Microsoft.Quantum.Intrinsic namespace
    
    /// # Summary
    /// Prints a message to the console.
    @EntryPoint() // Mark SayHello operation to be called first when program executes
    operation SayHello() : Unit { // Operation declaration
        Message("Hello quantum world!"); // Use unqualified name of Message operation
    }
}

// Notes:
// 1) All Q# code must be included in a namespace
// 2) Namespaces cannot be nested; ie MS.Quantum.ML and MS.Quantum.ML.Datasets logically related but not really related in code
// 3) To access callable or other code from other namespace, either use Fully Qualified Name (FQN) or open directive
// 3a) FQN Ex: Microsoft.Quantum.Intrinsic.Message("Hello!");
// 3b) Open directive: Used in code above
// 4) Callable definitions in current namespace have priority over callables with same name in different open namespaces
// 5) Open directives can create aliases (think "import as" in Python) 
// 5a) Open MS.Quantum.Intrinsic as Builtin; Builtin.message("Hello")
// 6) Functions vs operations: Funcs = special subroutine that perform ONLY deterministic classical computations
// 6a) Operations = general-purpose subroutines without restrictions
// 7) User-defined types = tuples of named and anonymous items of other types
// 7a) newtype declares user-def type: newtype Pair = (First : Int, Second : Int);
// 8) Currently no multi-line or block comments in Q#
// 9) Three slashes (///) is a documentation comment