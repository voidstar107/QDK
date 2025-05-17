namespace EulersTotientFunction {
    open Microsoft.Quantum.Intrinsic; // Use Message() from Intrinsic namespace

    /// This function calculates Euler's totient function
    function TotientFunction(n : Int) : Int {
        if n <= 0 { // Check if n is valid value
            fail "n should be positive"; // Throw exception if n isn't positive
        }

        mutable nCoprimes = 0; // Mutable variable that counts coprimes

        for i in 1..n {
            mutable(x, y) = (n, i); // x and y are mutable variables for computing GCD of i and n

            while y > 0 { // Finds GCD of i and n and sets x = GCD(i, n)
                set (x, y) = (y, x % y); // Update both variables simultaneously with tuple deconstruction (#7 in notes)
            }

            if x == 1 {
                set nCoprimes += 1; // Increase coprimes count if current number, x, is coprime with n
            }
        }
        return nCoprimes;
    }

    @EntryPoint() // Program execution starts here
    function PrintEulersTotientFunction() : Unit { // Reminder: Unit return type is similar to void in C++
        let n = 15; // Set n as immutable variable
        Message($"φ({n}) = {TotientFunction(n)}");
    }
}

// Notes
// 1) Variable shadowing (defining variable with name that's been defined in current or outer block) forbidden in Q#
// 2) There are no global variables in Q#
// 3) There are two types of variables in Q#: mutable and immutable
// 3a) Immutable: constant and ALWAYS bound to the same value
// 3b) Mutable: "normal" variable that can take different values
// 4) let statements allow declaration of immutable variable/constant
// 4a) IE let n = 0; OR let doubleArray = [1., 2., 3.]; OR let gate = H;
// 4b) let statement doesn't specify variable type; this is done by expression on RHS
// 5) mutable statements allow declaration of mutable variable/"normal" variable
// 5a) IE mutable m = 10; OR mutable intArray = [1, 2, 3];
// 6) set statements allow reassignment of mutable variable to a different value
// 6a) IE set m += 32 (example of evaluate-and-reassign statement); OR set intArray = intArray + [4];
// 6b) set statements CANNOT be used on immutable variables
// 7) Tuple deconstruction: allows deconstruction of tuples into components and assign them to separate variables
// 7a) IE let tuple = (5, false); let (first, second) = tuple; (first = 5, second = false)
// 8) Transfer-of-control statements, ie break and continue, are NOT supported by Q#
// 9) return statements can be used at any point in code EXCEPT for when allocated qubits are involved
