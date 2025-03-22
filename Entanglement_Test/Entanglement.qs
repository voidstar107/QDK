namespace Entanglement { // Create namespace for code
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    /// # Summary
    /// The operation takes the Result type parameter "desired" (0 or 1) and Qubit type "target"
    /// M is measurement op that measures target state (0 or 1) and compares to desired
    /// If target doesn't match desired, the X op runs on target to flip the qubit's state
    /// SetQubitState always sets qubit to desired state
    operation SetQubitState(desired : Result, target : Qubit) : Unit {
        if desired != M(target) {
            X(target);
        }
    }
    
    /// # Summary
    /// Main operation allocates, sets, and measures two qubits whereupon the number of times |0> and |1> are returned is counted.
    /// This operation also utilizes superposition and entanglement via the H and CNOT operations (H comes before CNOT)
    @EntryPoint() // Set entry point so program knows where to start execution
    operation Main() : (Int, Int, Int, Int) {
        mutable numOnesQ1 = 0;
        mutable numOnesQ2 = 0;
        let count = 1000; // To measure each qubit 1000 times
        let initial = One; // Initializes first qubit to 1

        // use statement initializes qubits
        use (q1, q2) = (Qubit(), Qubit());   
        for test in 1..count {
            SetQubitState(initial, q1); // Set first qubit to specified initial value
            SetQubitState(Zero, q2); // Set second qubit to Zero

            H(q1); // Add Hadamard operation after init and before measuring to flip qubit halfway into state of equal probabilities of Zero or One
            CNOT (q1, q2); // CNOT (Controlled-NOT) enables entanglement which flips q2 if q1 is One

            // Use M operation twice to measure each qubit
            let resultQ1 = M(q1);            
            let resultQ2 = M(q2);           

            // Count the number of 'Ones' returned:
            if resultQ1 == One { // Increment counter for first qubit if state is One
                numOnesQ1 += 1;
            }
            if resultQ2 == One { // Increment counter for second qubit if state is One
                numOnesQ2 += 1;
            }
        }

        // Reset qubits to Zero (required by use statement; kind of reminds me of new and delete to free up resources for allocation)
        SetQubitState(Zero, q1);             
        SetQubitState(Zero, q2);
    

        // Print number of times |0> or |1> is returned
        Message($"Q1 - Zeros: {count - numOnesQ1}");
        Message($"Q1 - Ones: {numOnesQ1}");
        Message($"Q2 - Zeros: {count - numOnesQ2}");
        Message($"Q2 - Ones: {numOnesQ2}");
        return (count - numOnesQ1, numOnesQ1, count - numOnesQ2, numOnesQ2 );
        // Results for Q1 are close to 50% for|0> and 50% for |1> and always vary
        // After using CNOT, Q1's stats remain the same, but Q2's measurements are ALWAYS the same as Q1 because of entanglement
    }
}

// Notes:
// 1) Entangling qubits connects them so they can't be described independently from each other
// 1a) That is: an op on Qa also happens to Qb if Qa and Qb are entangled
// 2) Entanglement can show state of Qa without measuring it just by measuring state of Qb
// 3) Before entanglement, Qa must be put in a superposition state via the H (Hadamard) operation
// 4) H operation flips qubit halfway into ~50% probability of returning Zero and ~50% probability of returning One